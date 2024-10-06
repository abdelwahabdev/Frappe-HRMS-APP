import 'package:bio_attend/app/localization/app_localization.dart';
import 'package:bio_attend/app/routes/app_routes.dart';
import 'package:bio_attend/app/utils/helper/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/features/attendance_feature/controller/attendance_binding.dart';
import 'app/features/auth_feature/controller/auth_bindings.dart';
import 'app/localization/localization_controller.dart';
import 'app/theme/app_theme.dart';
import 'app/utils/constant/app_strings.dart';
import 'app/utils/helper/permission_request.dart';

SharedPreferences? sharedpref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PermissionRequest.requestPermission();

  sharedpref = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final locaController = Get.put(MyLocalController());
    final localeValue = locaController.selectedLang.value;
    final locale = (localeValue == 'en' || localeValue == 'ar')
        ? Locale(localeValue)
        : const Locale('ar');

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: AppTheme.lightTheme,
        initialRoute: UserPreference.isLoggedIn()
            ? AppRoutes.attendancePage
            : AppRoutes.companySetting,
        initialBinding:
            UserPreference.isLoggedIn() ? AttendanceBinding() : AuthBinding(),
        getPages: AppRoutes.appPages,

        // APP LOCALIZATION
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const <Locale>[Locale('en'), Locale('ar')],
        locale: locale,
        translations: AppLocalization(),
        //
        defaultTransition: Transition.topLevel,
        transitionDuration: const Duration(milliseconds: 500));
  }
}
