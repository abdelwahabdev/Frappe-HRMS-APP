import 'package:flutter/material.dart';

import '../utils/helper/app_dimension.dart';
import 'app_color.dart';
import 'text_theme/sf_pro_text_theme.dart';

class AppTextTheme {
  
  static const String fontFamily = 'Almarai';

  //SF PRO TEXT THEME
  static TextTheme sfProTextTheme = const TextTheme(
    displayLarge: SFPROTextStyle.largeTitleRegular,
    displayMedium: SFPROTextStyle.title1Regular,
    displaySmall: SFPROTextStyle.title2Regular,
    headlineLarge: SFPROTextStyle.title3Regular,
    headlineMedium: SFPROTextStyle.headlineRegular,
    headlineSmall: SFPROTextStyle.headlineRegular,
    titleLarge: SFPROTextStyle.bodyRegular,
    titleMedium: SFPROTextStyle.bodyRegular,
    titleSmall: SFPROTextStyle.subheadlineRegular,
    bodyLarge: SFPROTextStyle.bodyRegular,
    bodyMedium: SFPROTextStyle.bodyRegular,
    bodySmall: SFPROTextStyle.footnoteRegular,
  );
  static TextTheme lightTextTheme = const TextTheme(
      displayLarge: TextStyle(
        color: AppColors.onBackgroundColor,
        fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
        fontFamily: fontFamily,
      ),
      displayMedium: TextStyle(
        color: AppColors.onBackgroundColor,
        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
        fontFamily: fontFamily,
      ),
      displaySmall: TextStyle(
        color: AppColors.onBackgroundColor,
        fontSize: Dimensions.FONT_SIZE_LARGE,
        fontFamily: fontFamily,
      ),
      headlineLarge: TextStyle(
        color: AppColors.onBackgroundColor,
        fontSize: Dimensions.FONT_SIZE_LARGE,
        fontFamily: fontFamily,
      ),
      headlineMedium: TextStyle(
        color: AppColors.onBackgroundColor,
        fontSize: Dimensions.FONT_SIZE_DEFAULT,
        fontFamily: fontFamily,
      ),
      headlineSmall: TextStyle(
        color: AppColors.onBackgroundColor,
        fontSize: Dimensions.FONT_SIZE_SMALL,
        fontFamily: fontFamily,
      ),
      titleLarge: TextStyle(
        color: AppColors.onBackgroundColor,
        fontSize: Dimensions.FONT_SIZE_DEFAULT,
        fontFamily: fontFamily,
      ),
      titleMedium: TextStyle(
        color: AppColors.onBackgroundColor,
        fontSize: Dimensions.FONT_SIZE_SMALL,
        fontFamily: fontFamily,
      ),
      titleSmall: TextStyle(
        color: AppColors.onBackgroundColor,
        fontSize: Dimensions.FONT_SIZE_SMALL,
        fontFamily: fontFamily,
      ),
      bodyLarge: TextStyle(
        color: AppColors.onBackgroundColor,
        fontSize: Dimensions.FONT_SIZE_LARGE,
        fontFamily: fontFamily,
      ),
      bodyMedium: TextStyle(
        color: AppColors.onBackgroundColor,
        fontSize: Dimensions.FONT_SIZE_DEFAULT,
        fontFamily: fontFamily,
      ),
      bodySmall: TextStyle(
        color: AppColors.onBackgroundColor,
        fontSize: Dimensions.FONT_SIZE_SMALL,
        fontFamily: fontFamily,
      ));
}
