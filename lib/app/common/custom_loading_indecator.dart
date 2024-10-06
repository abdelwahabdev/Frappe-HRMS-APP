import 'package:bio_attend/app/utils/constant/app_images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingIndecator extends StatelessWidget {
  const CustomLoadingIndecator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: LottieBuilder.asset(Images.itSystematicLoaderLottie));
  }
}