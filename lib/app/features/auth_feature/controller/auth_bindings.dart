import 'package:bio_attend/app/features/auth_feature/controller/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<AuthController>(() => AuthController());
  }
}