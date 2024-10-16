import 'dart:convert';

import 'package:bio_attend/app/common/custom_snakbar.dart';
import 'package:bio_attend/app/features/auth_feature/data/save_userdata_in_local_storage.dart';
import 'package:bio_attend/app/routes/app_routes.dart';
import 'package:bio_attend/app/utils/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constant/api_string.dart';
import '../model/user_model.dart';

class AuthService {
  Future<UserModel?> login(String usernameOrEmail, String password) async {
    var baseSiteUrl = 'http://${UserPreference.getSiteURL()}';
    var url = '$baseSiteUrl${APIString.apiBaseURL}${APIString.loginENDPOINT}';

    final body = jsonEncode({'usr': usernameOrEmail, 'pwd': password});
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['message']['message'] == 'Login Successful') {
          return UserModel.fromJson(responseData['message']);
        } else {
          showCustomSnackBar(responseData['message']['message'].toString().tr,
              isError: true);
          return null;
        }
      } else if (response.statusCode == 301) {
        showCustomSnackBar(
          'invalid_server'.trParams({'code': response.reasonPhrase.toString()}),
          isError: true,
        );
      }else if (response.statusCode == 500){
        showCustomSnackBar(
          'server_error'.trParams({'code': response.reasonPhrase.toString()}),
          isError: true,
        );    
      } else {
        showCustomSnackBar(
            'an_error_occurred'.trParams({'code': response.statusCode.toString()}),
            isError: true);
        return null;
      }
    } catch (e) {
      showCustomSnackBar('network_error'.trParams({'error': e.toString()}),
          isError: true);
      return null;
    }
    return null;
  }

  Future<void> logout() async {
    try {
      var site = 'http://${UserPreference.getSiteURL()}';
      var url = site + APIString.logoutEndPoint;
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        await SaveUserdataInLocalStorage.clearUserdataInLocalStorage();
        if (UserPreference.getSiteURL() == '') {
          Get.offAllNamed(AppRoutes.companySetting);
        } else {
          Get.offAllNamed(AppRoutes.login);
        }
      } else {
        showCustomSnackBar(
            'logout_error'.trParams({'error': response.reasonPhrase ?? ''}),
            isError: true);
      }
    } catch (e) {
      showCustomSnackBar(
          'logout_network_error'.trParams({'error': e.toString()}),
          isError: true);
    }
  }
}
