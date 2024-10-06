import 'package:bio_attend/app/features/attendance_feature/controller/attendance_controller.dart';
import 'package:bio_attend/app/theme/app_color.dart';
import 'package:bio_attend/app/utils/constant/app_strings.dart';
import 'package:bio_attend/app/utils/helper/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/attendance_report_model.dart';



class BuildReportList extends GetWidget<AttendanceController> {
  const BuildReportList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.attendanceList.isEmpty) {
        // return const CustomLoadingIndecator();
        return Center(child: Text(AppStrings.noDataFound.tr));
      } else {
        List<AttendanceReportModel> attendanceList = controller.attendanceList;
        return Column(
          children: [
            Container(
              width: double.infinity,
              // height: ,
              color: Theme.of(context).cardTheme.color!.withOpacity(0.2),
              child: Center(
                child: Text(AppStrings.attendancereport.tr),
              ),
            ),
            10.ph,
            Expanded(
              child: ListView.builder(
                itemCount: attendanceList.length,
                itemBuilder: (context, index) {
                  AttendanceReportModel report = attendanceList[index];
                  return Card(
                    color: Theme.of(context).colorScheme.onPrimary,
                    child: ListTile(
                        leading: Text(report.attendanceDate,
                            style: Theme.of(context).textTheme.bodyMedium),
                        title: Text(
                          report.status,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: report.status == 'Absent'
                                        ? AppColors.error
                                        : AppColors.successColor,
                                  ),
                        ),
                        trailing: Text(report.workingHours.toString(),
                            style: Theme.of(context).textTheme.bodyMedium)),
                  );
                },
              ),
            ),
          ],
        );
      }
    });
  }
}
