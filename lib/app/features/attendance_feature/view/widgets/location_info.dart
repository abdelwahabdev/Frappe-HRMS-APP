import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../localization/localization_controller.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/constant/app_images.dart';
import '../../../../utils/helper/shared_pref.dart';

class LocationInfo extends StatelessWidget {
  const LocationInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final radius = UserPreference.getAcceptanceRadius().roundToDouble();
    final text = MyLocalController.find.selectedLang.value == 'en'
        ? 'You must be $radius M away from office to check in'
        : 'يجب عليك الدخول ضمن نطاق $radius متر من المكان الرئيسي للتحقق';

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: LottieBuilder.asset(Images.locationLottie),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.hintColor,
              ),
        ),
      ],
    );
  }
}
