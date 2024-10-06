import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common/custom_button.dart';
import '../../../../utils/constant/app_strings.dart';
import '../../../../utils/helper/depug_log.dart';
import '../../controller/attendance_controller.dart';
import '../../model/branch_models.dart';
import 'enable_location_text.dart';

class BranchDropdown extends StatefulWidget {
  const BranchDropdown({super.key});

  @override
  State<BranchDropdown> createState() => _BranchDropdownState();
}

class _BranchDropdownState extends State<BranchDropdown> {
  final RxBool locationAccessEnabled = false.obs;

  @override
  void initState() {
    super.initState();
    checkForAccessLocationEnabled();
  }

  void checkForAccessLocationEnabled() async {
    locationAccessEnabled.value = await Permission.location.isGranted;
    debugLog(locationAccessEnabled.value.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<AttendanceController>();
      if (controller.branchList.isEmpty) {
        return const SizedBox.shrink();
      }
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Chip(
              side: BorderSide.none,
              label: controller.serviceEnabled.value
                  ? const BranchDropdownContent()
                  : const EnableLocationText(),
            ),
          ),
          const SizedBox(height: 10),
          if (!controller.serviceEnabled.value)
            CustomElevatedButton(
              onPressed: Geolocator.openLocationSettings,
              title: Text(AppStrings.goToSetting.tr),
            ),
          if (!locationAccessEnabled.value)
            CustomElevatedButton(
              onPressed: () async {
                final status = await Permission.location.request();
                AttendanceController.instance.onInit();
                if (status.isGranted) {
                  locationAccessEnabled.value = true;
                }
              },
              title: Text(AppStrings.enableAccess.tr),
            ),
        ],
      );
    });
  }
}

class BranchDropdownContent extends StatelessWidget {
  const BranchDropdownContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AttendanceController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          return Text('${controller.distance.value.round()} M');
        }),
        const SizedBox(width: 10),
        Obx(() {
          return DropdownButton<BranchListModel>(
            elevation: 0,
            underline: Container(),
            hint: const Text('Select Branch'),
            value: controller.selectedBranch.value,
            onChanged: (BranchListModel? newValue) {
              if (newValue != null) {
                controller.changeBranch(newValue);
              }
            },
            items: controller.branchList
                .map<DropdownMenuItem<BranchListModel>>((branch) {
              return DropdownMenuItem<BranchListModel>(
                value: branch,
                child: Text(branch.branchName),
              );
            }).toList(),
          );
        }),
        const SizedBox(width: 10),
        const Icon(Icons.location_on_rounded, color: Colors.red),
      ],
    );
  }
}
