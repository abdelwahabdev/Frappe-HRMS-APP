import 'package:bio_attend/app/features/auth_feature/model/user_model.dart';
import 'package:bio_attend/app/utils/helper/shared_pref.dart';

class SaveUserdataInLocalStorage {
  SaveUserdataInLocalStorage._();

  static saveUserdataInLocalStorage(UserDataModel userData) {
    UserPreference.setIsLoggedIn(true);
    UserPreference.setToken(userData.token);
    UserPreference.setUsername(userData.username);
    UserPreference.setEmail(userData.email);
    UserPreference.setEnableRemote(userData.enableRemote);
    UserPreference.setFullName(userData.fullName);
    UserPreference.setEmployeeName(userData.employeeName!);
    UserPreference.setCompanyLatitude(userData.latitude);
    UserPreference.setCompanyLongitude(userData.longitude);
    UserPreference.setAcceptanceRadius(userData.acceptanceRadius);
    UserPreference.setIsLoggedIn(true);
    UserPreference.setBranchName(userData.branchName!);
  }

  static clearUserdataInLocalStorage() {
    UserPreference.setToken('');
    UserPreference.setUsername('');
    UserPreference.setEmail('');
    UserPreference.setEnableRemote(0);
    UserPreference.setFullName('');
    UserPreference.setEmployeeName('');
    UserPreference.setCompanyLatitude(0.0);
    UserPreference.setCompanyLongitude(0.0);
    UserPreference.setAcceptanceRadius(0.0);
    UserPreference.setIsLoggedIn(false);
    UserPreference.setBranchName('');
  }
}
