import 'package:bio_attend/app/features/auth_feature/data/save_userdata_in_local_storage.dart';
import 'package:bio_attend/app/routes/app_routes.dart';
import 'package:bio_attend/app/utils/helper/depug_log.dart';
import 'package:bio_attend/app/utils/helper/shared_pref.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../data/auth_repo.dart';
import '../model/user_model.dart';

class AuthController extends GetxController {
  // services class
  final AuthService authService = AuthService();

  // text edditing controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController companySiteURLController =
      TextEditingController(text: UserPreference.getSiteURL());

  // observables bools
  final RxBool isObscure = true.obs;
  final RxBool isShowIndicator = false.obs;

  // observables models
  final Rx<UserModel?> userModel = Rx<UserModel?>(null);

  Future<void> login() async {
    final usernameOrEmail = usernameController.text;
    final password = passwordController.text;
    try {
      isShowIndicator.value = true;
      final response = await authService.login(usernameOrEmail, password);

      if (response != null) {
        userModel.value = response;

        SaveUserdataInLocalStorage.saveUserdataInLocalStorage(
            userModel.value!.data);

        Get.offAllNamed(AppRoutes.attendancePage);
      } else {
        // Show an error message to the user
        // Get.snackbar('Error', 'Login failed. Please try again.'.tr,
        //     snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      debugLog('Error logging in user: $e');
    } finally {
      isShowIndicator.value = false;
    }
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username'.tr;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password'.tr;
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters'.tr;
    }
    return null;
  }

  void setSiteURL() async {
    try {
      await UserPreference.setSiteURL(companySiteURLController.text);
      Get.toNamed(AppRoutes.login);
    } catch (e) {
      debugLog('Error setting site url: $e');
    }
  }

  void toggleVisable() {
    isObscure.value = !isObscure.value;
  }
}
