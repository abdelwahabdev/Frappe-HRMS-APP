import 'package:bio_attend/app/utils/constant/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/custom_appbar.dart';
import '../../../utils/helper/shared_pref.dart';
import '../../auth_feature/data/auth_repo.dart';
import '../controller/attendance_controller.dart';
import 'widgets/action_card.dart';
import 'widgets/branch_dorpdown.dart';
import 'widgets/location_info.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final AttendanceController controller = Get.put(AttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.attendanceCheckin.tr,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: AuthService().logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const BranchDropdown(),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.distance.value >
                      UserPreference.getAcceptanceRadius() &&
                  UserPreference.getEnableRemote() == false) {
                return const LocationInfo();
              } else {
                return const SizedBox.shrink();
              }
            }),
            SizedBox(height: Get.height * 0.01),
            const ActionCard(),
          ],
        ),
      ),
    );
  }
}
