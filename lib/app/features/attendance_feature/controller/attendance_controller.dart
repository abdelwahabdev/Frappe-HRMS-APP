import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../common/custom_snakbar.dart';
import '../../../utils/constant/app_strings.dart';
import '../../../utils/constant/check_in_type.dart';
import '../../../utils/helper/depug_log.dart';
import '../../../utils/helper/shared_pref.dart';
import '../data/attendance_report_repo.dart';
import '../data/bio_service.dart';
import '../data/employee_checkin_service.dart';
import '../data/get_branch_service.dart';
import '../data/location_service.dart';
import '../model/attendance_report_model.dart';
import '../model/branch_models.dart';
import '../model/employee_checkin_model.dart';

class AttendanceController extends GetxController {
  static AttendanceController get instance => Get.find();

  final LocationService _locationService = LocationService();
  final EmployeeCheckinService _employeeCheckinService =
      EmployeeCheckinService();
  final AttendanceReportService _attendanceReportService =
      AttendanceReportService();
  final BiometricService _biometricService = BiometricService();
  final GetBranchDataService _getBranchDataService = GetBranchDataService();
  late StreamSubscription<ServiceStatus> _serviceStatusStream;

  final RxList<BranchListModel> branchList = <BranchListModel>[].obs;
  final Rx<BranchListModel?> selectedBranch = Rx<BranchListModel?>(null);
  final Rx<Position?> currentPosition = Rx<Position?>(null);
  final RxList<AttendanceReportModel> attendanceList =
      <AttendanceReportModel>[].obs;

  final RxBool isCheckingIn = false.obs;
  final RxBool isSuccessCheckin = true.obs;
  final RxBool ispenddingFingerprint = true.obs;
  final RxBool serviceEnabled = false.obs;
  final RxBool isWaitingBranch = false.obs;
  final RxString timeNow = RxString('');
  final RxDouble distance = 0.0.obs;

  var selectedCheckinType = CheckinType.IN.obs; 

  late Timer _timer;

  @override
  void onInit() async {
    super.onInit();
    fetchCurrentPosition();
    _startTimer();
    await fetchBranchList();
    _listenToLocationService();

    everAll([currentPosition, selectedBranch], (_) => updateDistanceToOffice());
  }

  @override
  void onClose() {
    _timer.cancel();
    _serviceStatusStream.cancel();

    super.onClose();
  }

  void _listenToLocationService() {
    _serviceStatusStream =
        Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      serviceEnabled.value = (status == ServiceStatus.enabled);
      if (serviceEnabled.value) {
        fetchCurrentPosition();
      } else {
        currentPosition.value = null;
        // showCustomSnackBar('Location services are disabled.'.tr, isError: true);
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      updateDistanceToOffice();
    });
  }

  // Method to update the selected check-in type
  void updateCheckinType(CheckinType type) {
    selectedCheckinType.value = type;
  }

  Future<void> getUserAttendanceReport() async {
    try {
      final empName = UserPreference.getEmployeeName();
      attendanceList.value = await _attendanceReportService
          .getEmployeeAttendanceReport(empName: empName);
    } catch (e) {
      debugLog('Error fetching attendance report: $e');
      showCustomSnackBar('Failed to fetch attendance report.'.tr,
          isError: true);
    }
  }

  Future<void> fetchCurrentPosition() async {
    try {
      serviceEnabled.value = await _locationService.isLocationServiceEnabled();
      if (!serviceEnabled.value) {
        showCustomSnackBar('Location services are disabled.'.tr, isError: true);
        return;
      }
      currentPosition.value = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      updateDistanceToOffice();
    } catch (e) {
      showCustomSnackBar('Failed to get current location.'.tr, isError: true);
    }
  }

  Future<void> checkInUseBiometrics() async {
    if (currentPosition.value == null) {
      showCustomSnackBar('No location data available for check-in.'.tr,
          isError: true);
      return;
    }

    if (selectedBranch.value == null &&
        UserPreference.getEnableRemote() == false) {
      showCustomSnackBar('No branch selected.'.tr, isError: true);
      return;
    }

    updateDistanceToOffice();

    if (distance.value > selectedBranch.value!.acceptanceRadius &&
        UserPreference.getEnableRemote() == false) {
      if (!Get.isSnackbarOpen) {
        showCustomSnackBar(AppStrings.ureTooFar.tr, isError: true);
      }
      return;
    }

    try {
      final authenticated = await _biometricService.authenticate();
      if (authenticated) {
        await _checkIn();
      }
    } catch (e) {
      showCustomSnackBar(AppStrings.authErrorOccured.tr, isError: true);
    }
  }

  Future<void> _checkIn() async {
    isCheckingIn.value = true;
    try {
      ispenddingFingerprint.value = false;
      Position? position = currentPosition.value;
      if (position != null) {
        bool success =
            await _employeeCheckinService.addEmployeeCheckin(EmployeeCheckin(
          logType: selectedCheckinType.value == CheckinType.IN ? 'IN' : 'OUT',
          longitude: position.longitude,
          latitude: position.latitude,
        ));

        if (success) {
          isSuccessCheckin.value = true;
          Future.delayed(const Duration(seconds: 2), () {
            ispenddingFingerprint.value = true;
            isCheckingIn.value = false;
          });
          showCustomSnackBar(AppStrings.processCompleted.tr,
              isError: false, duration: const Duration(milliseconds: 1000));
        } else {
          isSuccessCheckin.value = false;
          Future.delayed(const Duration(seconds: 2), () {
            ispenddingFingerprint.value = true;
            isCheckingIn.value = false;
          });
          // showCustomSnackBar('Failed to check in.'.tr, isError: true);
        }
      }
    } catch (e) {
      isSuccessCheckin.value = false;
      Future.delayed(const Duration(seconds: 2), () {
        ispenddingFingerprint.value = true;
        isCheckingIn.value = false;
      });
      debugLog('Error during check-in: $e');
      showCustomSnackBar(AppStrings.checkinErrorOcuured.tr, isError: true);
    }
  }

  Future<void> fetchBranchList() async {
    try {
      isWaitingBranch.value = true;
      branchList.value = await _getBranchDataService.fetchBranchList();
      final userBranchName = UserPreference.getBranchName();
      selectedBranch.value = branchList.firstWhere(
        (branch) => branch.branchName == userBranchName,
        orElse: () => branchList.first,
      );
    } catch (e) {
      showCustomSnackBar(AppStrings.failedToFetchBranch.tr, isError: true);
      isWaitingBranch.value = false;
    } finally {
      isWaitingBranch.value = false;
    }
  }

  void changeBranch(BranchListModel branch) {
    selectedBranch.value = branch;
    UserPreference.setBranchName(branch.branchName);
    UserPreference.setAcceptanceRadius(branch.acceptanceRadius);
    UserPreference.setCompanyLatitude(branch.branchLatitude);
    UserPreference.setCompanyLongitude(branch.branchLongitude);
    updateDistanceToOffice();
    update();
  }

  void updateDistanceToOffice() {
    if (currentPosition.value != null && selectedBranch.value != null) {
      distance.value = Geolocator.distanceBetween(
        currentPosition.value!.latitude,
        currentPosition.value!.longitude,
        selectedBranch.value!.branchLatitude,
        selectedBranch.value!.branchLongitude,
      );
    }
  }
}
