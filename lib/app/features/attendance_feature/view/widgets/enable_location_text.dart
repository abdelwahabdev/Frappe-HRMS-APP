
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constant/app_strings.dart';

class EnableLocationText extends StatelessWidget {
  const EnableLocationText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.enapleLocation.tr,
      textAlign: TextAlign.center,
      style: Theme.of(Get.context!).textTheme.bodyMedium,
    );
  }
}


