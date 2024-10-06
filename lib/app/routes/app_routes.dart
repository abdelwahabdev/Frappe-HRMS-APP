import 'package:bio_attend/app/features/attendance_feature/controller/attendance_binding.dart';
import 'package:bio_attend/app/features/auth_feature/view/login_page.dart';
import 'package:get/get.dart';
import '../features/attendance_feature/view/attendance_page.dart';
import '../features/auth_feature/controller/auth_bindings.dart';
import '../features/auth_feature/view/company_setting_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String companySetting = '/CompanySettingPage';
  static const String login = '/login';
  static const String home = '/home';
  static const String attendancePage = '/AttendancePage';

  static List<GetPage> appPages = [
     GetPage(
        name: companySetting,
        page: () => const CompanySettingPage(),
        binding: AuthBinding(),
        transition: Transition.cupertino),
    GetPage(
        name: login,
        page: () => const LoginPage(),
        binding: AuthBinding(),
        transition: Transition.cupertino),
    GetPage(
      name: attendancePage,
      page: () => const AttendancePage(),
      transition: Transition.cupertino,
      binding: AttendanceBinding(),
    )
  ];
}
