import 'dart:convert';

import 'package:bio_attend/app/utils/constant/api_string.dart';
import 'package:http/http.dart' as http;

import '../../../utils/helper/shared_pref.dart';
import '../model/attendance_report_model.dart';

class AttendanceReportService {
  Future<List<AttendanceReportModel>> getEmployeeAttendanceReport(
      {required String empName}) async {
    final token = UserPreference.getToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $token',
    };
    var baseSiteUrl = 'http://${UserPreference.getSiteURL()}';
    var url = Uri.parse(
        '$baseSiteUrl${APIString.apiBaseURL}${APIString.empAttendanceReportENDPOINT}?employee_name=$empName');

    var response = await http.post(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['report'];
      List<AttendanceReportModel> attendanceList =
          data.map((e) => AttendanceReportModel.fromJson(e)).toList();
      return attendanceList;
    } else {
      throw Exception('Failed to load attendance report');
    }
  }
}
