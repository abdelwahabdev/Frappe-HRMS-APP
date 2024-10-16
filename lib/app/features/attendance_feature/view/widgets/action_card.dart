import 'package:bio_attend/app/features/attendance_feature/controller/attendance_controller.dart';
import 'package:bio_attend/app/theme/app_color.dart';
import 'package:bio_attend/app/utils/constant/app_images.dart';
import 'package:bio_attend/app/utils/helper/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/constant/check_in_type.dart';

class ActionCard extends StatefulWidget {
  const ActionCard({super.key});

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  final List<bool> selected = [false, true];

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

      if (controller.serviceEnabled.value) {
        return Column(
          children: [
            const SizedBox(height: 20),
            ToggleButtons(
              isSelected: selected,
              color: Colors.black,
              fillColor: AppColors.primaryColor,
              borderColor: AppColors.primaryColor.withOpacity(0.2),
              splashColor: AppColors.primaryColor.withOpacity(0.3),
              selectedBorderColor: AppColors.primaryColor.withOpacity(0.8),
              selectedColor: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              constraints: const BoxConstraints(minWidth: 100, minHeight: 40),
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < selected.length; i++) {
                    selected[i] = i == index;
                  }
                  if (index == 0) {
                    controller.updateCheckinType(CheckinType.OUT);
                  } else {
                    controller.updateCheckinType(CheckinType.IN);
                  }
                });
              },
              children: [Text(CheckinType.OUT.name), Text(CheckinType.IN.name)],
            ),
            const SizedBox(height: 50),
            Obx(() {
              if (controller.isSuccessCheckin.value == true &&
                  !controller.ispenddingFingerprint.value) {
                return Lottie.asset(
                  Images.successFingerprint,
                  height: 120,
                  repeat: false,
                  onLoaded: (composition) {
                    Future.delayed(const Duration(milliseconds: 2500), () {
                      // controller.isSuccessCheckin.value = false;
                      controller.ispenddingFingerprint.value = true;
                    });
                  },
                );
              } else if (controller.isSuccessCheckin.value == false &&
                  !controller.ispenddingFingerprint.value) {
                return Lottie.asset(
                  Images.failedFingerprint,
                  height: 120,
                  repeat: false,
                  onLoaded: (composition) {
                    Future.delayed(const Duration(milliseconds: 2500), () {
                      // controller.isSuccessCheckin.value = false;
                      controller.ispenddingFingerprint.value = true;
                    });
                  },
                );
              } else {
                return GestureDetector(
                  onTap: () => controller.checkInUseBiometrics(),
                  child: Image.asset(
                    Images.pendingFingerprint,
                    height: 100,
                  ),
                );
              }
            }),
          ],
        );
      } else {
        return const SizedBox.shrink();
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

            // Row(
            //   children: [
            //     BuildActionCardItem(
            //       btn: AppStrings.checkIn.tr,
            //       title: AppStrings.attendance.tr,
            //       onPressed: () => controller.checkInUseBiometrics(
            //           checkinType: CheckinType.IN),
            //       isCheckInBTN: true,
            //     ),
            //     BuildActionCardItem(
            //       btn: AppStrings.checkOut.tr,
            //       title: AppStrings.leave.tr,
            //       onPressed: () => controller.checkInUseBiometrics(
            //           checkinType: CheckinType.OUT),
            //       isCheckInBTN: false,
            //     ),
            //   ],
            // ),