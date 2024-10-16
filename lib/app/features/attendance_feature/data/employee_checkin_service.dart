import 'dart:convert';

import 'package:bio_attend/app/utils/constant/api_string.dart';
import 'package:bio_attend/app/utils/helper/depug_log.dart';
import 'package:bio_attend/app/utils/helper/shared_pref.dart';
import 'package:http/http.dart' as http;

import '../model/employee_checkin_model.dart';

class EmployeeCheckinService {
  Future<bool> addEmployeeCheckin(EmployeeCheckin checkin) async {
    final token = UserPreference.getToken();

    var headers = {
      'Authorization': 'Basic $token',
      'Content-Type': 'application/json',
    };
    var baseSiteUrl = 'https://${UserPreference.getSiteURL()}';

    var url = Uri.parse(
        baseSiteUrl + APIString.apiBaseURL + APIString.employeeCheckinENDPOINT);

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(checkin.toJson()),
      );

      debugLog('Response status: ${response.statusCode}');
      debugLog('Response body: ${response.body}');
      debugLog(jsonEncode(checkin.toJson()));

      if (response.statusCode == 200) {
        debugLog('Response: ${response.body}');
        debugLog('Employee checkin added successfully');
        return true;
      } else {
        debugLog('Failed to add employee checkin: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      debugLog('Error: $e');
      return false;
    }
  }
}
