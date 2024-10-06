import 'package:flutter/material.dart';
import '../utils/helper/app_dimension.dart';
import 'app_color.dart';
import 'text_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      fontFamily: AppTextTheme.fontFamily,
      textTheme: AppTextTheme.lightTextTheme,
      scaffoldBackgroundColor: AppColors.scafoldBackgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.onPrimaryColor,
        primary: AppColors.primaryColor,
        onPrimary: AppColors.onPrimaryColor,
        secondary: AppColors.secondaryColor,
        onSecondary: AppColors.onSecondaryColor,
        primaryContainer: AppColors.primaryContainerColor,
        error: AppColors.error,
      ),
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF5FCF9),
          isDense: true,
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.fillColor),
            borderRadius:
                BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT)),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.fillColor),
            borderRadius:
                BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT)),
          )),
      dropdownMenuTheme: const DropdownMenuThemeData(
          menuStyle: MenuStyle(
        backgroundColor: MaterialStatePropertyAll(AppColors.onPrimaryColor),
      )),
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.onPrimaryColor,
          titleTextStyle: AppTextTheme.lightTextTheme.displaySmall!
              .copyWith(color: AppColors.onPrimaryColor),
          iconTheme: const IconThemeData(
            color: AppColors.onPrimaryColor,
          ),
          surfaceTintColor: AppColors.primaryColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.onPrimaryColor,
        minimumSize: const Size(double.infinity, 48),
        textStyle: AppTextTheme.lightTextTheme.displaySmall,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
        ),
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.error,
            minimumSize: const Size.fromHeight(50),
            side: const BorderSide(
              width: 1.0,
              color: AppColors.error,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
            )),
      ),
      cardTheme: CardTheme(
          color: AppColors.primaryContainerColor.withOpacity(0.60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
          ),
          elevation: 0,
          surfaceTintColor: Colors.transparent));
}
