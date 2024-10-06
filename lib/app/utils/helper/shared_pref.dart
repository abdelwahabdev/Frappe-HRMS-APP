import '../../../main.dart';

class UserPreference {
  static Future<void> setEnableRemote(int enable) async {
    if (enable == 1) {
      await sharedpref!.setBool('enable_remote', true);
    } else {
      await sharedpref!.setBool('enable_remote', false);
    }
  }

  static bool getEnableRemote() {
    return sharedpref!.getBool('enable_remote') ?? false;
  }

  static Future<void> setBranchName(String branch) async {
    await sharedpref!.setString('branch_name', branch);
  }

  static String getBranchName() {
    return sharedpref!.getString('branch_name') ?? '';
  }

  static Future<void> setSiteURL(String site) async {
    await sharedpref!.setString('site_url', site);
  }

  static String getSiteURL() {
    return sharedpref!.getString('site_url') ?? 'https://demo.itsystematic.com';
  }

  static Future<void> setIsLoggedIn(bool login) async {
    await sharedpref!.setBool('logged_in', login);
  }

  static bool isLoggedIn() {
    return sharedpref!.getBool('logged_in') ?? false;
  }

  static Future<void> setToken(String apiKey) async {
    await sharedpref!.setString('token', apiKey);
  }

  static String getToken() {
    return sharedpref!.getString('token') ?? '';
  }

  static Future<void> setUsername(String username) async {
    await sharedpref!.setString('username', username);
  }

  static String getUsername() {
    return sharedpref!.getString('username') ?? '';
  }

  static Future<void> setUserId(String userId) async {
    await sharedpref!.setString('user_id', userId);
  }

  static String getUserId() {
    return sharedpref!.getString('user_id') ?? '';
  }

  static Future<void> setEmail(String email) async {
    await sharedpref!.setString('email', email);
  }

  static String getEmail() {
    return sharedpref!.getString('email') ?? '';
  }

  static Future<void> setFullName(String fullName) async {
    await sharedpref!.setString('full_name', fullName);
  }

  static String getFullName() {
    return sharedpref!.getString('full_name') ?? '';
  }

  static Future<void> setEmployeeName(String employeeName) async {
    await sharedpref!.setString('employee_name', employeeName);
  }

  static String getEmployeeName() {
    return sharedpref!.getString('employee_name') ?? '';
  }

  static Future<void> setCompanyLatitude(double latitude) async {
    await sharedpref!.setDouble('company_latitude', latitude);
  }

  static double getCompanyLatitude() {
    return sharedpref!.getDouble('company_latitude') ?? 0.0;
  }

  static Future<void> setCompanyLongitude(double longitude) async {
    await sharedpref!.setDouble('company_longitude', longitude);
  }

  static double getCompanyLongitude() {
    return sharedpref!.getDouble('company_longitude') ?? 0.0;
  }

  static Future<void> setAcceptanceRadius(double radius) async {
    await sharedpref!.setDouble('acceptance_radius', radius);
  }

  static double getAcceptanceRadius() {
    return sharedpref!.getDouble('acceptance_radius') ?? 0.0;
  }
}
