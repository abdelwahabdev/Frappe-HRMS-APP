import 'dart:convert';

import 'package:bio_attend/app/utils/constant/api_string.dart';
import 'package:http/http.dart' as http;

import '../../../utils/helper/depug_log.dart';
import '../../../utils/helper/shared_pref.dart';
import '../model/branch_models.dart';

class GetBranchDataService {
  Future<List<BranchListModel>> fetchBranchList() async {
    // Retrieve token and site URL from user preferences
    final token = UserPreference.getToken();
    final baseSiteUrl = 'https://${UserPreference.getSiteURL()}';

    // Set up headers
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $token',
    };

    // Create the request
    var request = http.Request(
      'POST',
      Uri.parse(
          '$baseSiteUrl${APIString.apiBaseURL}${APIString.getBranchListENDPOINT}'),
    );

    request.headers.addAll(headers);

    // Send the request
    http.StreamedResponse response = await request.send();

    // Check the response status
    if (response.statusCode == 200) {
      // Parse the response
      String responseBody = await response.stream.bytesToString();
      final parsedJson = json.decode(responseBody);

      // Parse the branch list
      List<BranchListModel> branchList = (parsedJson['message'] as List)
          .map((branch) => BranchListModel.fromJson(branch))
          .toList();
      debugLog(branchList.toString());

      return branchList;
    } else {
      throw Exception('Failed to load branch list: ${response.reasonPhrase}');
    }
  }
}
