import 'package:bio_attend/app/utils/helper/app_dimension.dart';
import 'package:bio_attend/app/utils/helper/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/custom_button.dart';
import '../../../common/custom_text_form.dart';
import '../../../utils/constant/app_strings.dart';
import '../controller/auth_controller.dart';

class CompanySettingPage extends GetView<AuthController> {
  const CompanySettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
        child: Column(
          children: [
            Text(AppStrings.welcomemsg.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge),
            30.ph,
            CustomTextField(
              // hintText: AppStrings.companySiteUrl.tr,
              hintText: 'demo.itsystematic.com',
              controller: controller.companySiteURLController,
              label: AppStrings.siteURL.tr,
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        child: CustomElevatedButton(
          key: UniqueKey(),
          title: Text(AppStrings.continuebutton.tr),
          onPressed: () => controller.setSiteURL(),
        ),
      ),
    );
  }
}
