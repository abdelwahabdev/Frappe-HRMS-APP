import 'package:bio_attend/app/common/custom_button.dart';
import 'package:bio_attend/app/common/custom_text_form.dart';
import 'package:bio_attend/app/features/auth_feature/controller/auth_controller.dart';
import 'package:bio_attend/app/routes/app_routes.dart';
import 'package:bio_attend/app/utils/constant/app_images.dart';
import 'package:bio_attend/app/utils/constant/app_strings.dart';
import 'package:bio_attend/app/utils/helper/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: constraints.maxHeight * 0.1),
                Image.asset(
                  Images.logo,
                  height: 120,
                ),
                SizedBox(height: constraints.maxHeight * 0.1),
                Form(
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: formKey,
                    child: Column(children: [
                      CustomTextField(
                        hintText: AppStrings.enterYourUsername.tr,
                        controller: controller.usernameController,
                        label: AppStrings.userName.tr,
                        validator: (value) =>
                            controller.validateUsername(value),
                      ),
                      CustomTextField(
                        hintText: AppStrings.enterYourPassword.tr,
                        controller: controller.passwordController,
                        label: AppStrings.password.tr,
                        visable: controller.isObscure.value,
                        toggleSuffixIcon: () => controller.toggleVisable(),
                        validator: (value) =>
                            controller.validatePassword(value),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: controller.isShowIndicator.value
                            ? Lottie.asset(Images.itSystematicLoaderLottie,
                                height: 60)
                            : CustomElevatedButton(
                                key: UniqueKey(),
                                title: Text(AppStrings.login.tr),
                                onPressed: () {
                                  if (formKey.currentState!.validate() &&
                                      !controller.isShowIndicator.value) {
                                    formKey.currentState!.save();
                                    controller.login();
                                  }
                                },
                              ),
                      ),
                    ])),
                20.ph,
                TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.companySetting);
                    },
                    child: Text(AppStrings.editSiteUrl.tr)),
              ],
            ),
          ),
        );
      }),
    );
  }
}
