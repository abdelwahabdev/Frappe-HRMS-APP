import 'package:bio_attend/app/features/attendance_feature/controller/attendance_controller.dart';
import 'package:get/get.dart';

class AttendanceBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AttendanceController());
  }
}
