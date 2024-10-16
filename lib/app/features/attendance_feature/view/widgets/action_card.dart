import 'package:bio_attend/app/features/attendance_feature/controller/attendance_controller.dart';
import 'package:bio_attend/app/theme/app_color.dart';
import 'package:bio_attend/app/utils/helper/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/custom_loading_indecator.dart';
import '../../../../utils/constant/app_strings.dart';
import '../../../../utils/constant/check_in_type.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AttendanceController>();
    return Obx(() {
      bool isWithinRadius =
          controller.distance.value <= UserPreference.getAcceptanceRadius();
      bool isRemoteEnabled = UserPreference.getEnableRemote() == true;

      if (!isWithinRadius && !isRemoteEnabled) {
        return const SizedBox.shrink();
      }

      if (!controller.isCheckingIn.value && controller.serviceEnabled.value) {
        return Card(
          color: AppColors.onPrimaryColor,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Obx(() => Text(
                    AttendanceController.instance.timeNow.value,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    style: Theme.of(Get.context!).textTheme.displayLarge,
                  )),
              const SizedBox(height: 10),
              Row(
                children: [
                  BuildActionCardItem(
                    btn: AppStrings.checkIn.tr,
                    title: AppStrings.attendance.tr,
                    onPressed: () => controller.checkInUseBiometrics(
                        checkinType: CheckinType.IN),
                    isCheckInBTN: true,
                  ),
                  BuildActionCardItem(
                    btn: AppStrings.checkOut.tr,
                    title: AppStrings.leave.tr,
                    onPressed: () => controller.checkInUseBiometrics(
                        checkinType: CheckinType.OUT),
                    isCheckInBTN: false,
                  ),
                ],
              ),
            ],
          ),
        );
      } else {
        return const CustomLoadingIndecator();
      }
    });
  }
}

class BuildActionCardItem extends StatelessWidget {
  const BuildActionCardItem({
    super.key,
    required this.btn,
    required this.title,
    required this.isCheckInBTN,
    this.onPressed,
  });
  final String btn;
  final String title;
  final bool isCheckInBTN;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Obx(() => AttendanceController.instance.distance.value <=
                    UserPreference.getAcceptanceRadius() ||
                UserPreference.getEnableRemote() == true
            ? isCheckInBTN
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.successColor),
                    onPressed: onPressed ?? () {},
                    child: Text(btn))
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                    ),
                    onPressed: onPressed ?? () {},
                    child: Text(btn))
            : Text(
                '${AttendanceController.instance.distance.value.toStringAsFixed(2)} KM away'))
      ]),
    ));
  }
}
