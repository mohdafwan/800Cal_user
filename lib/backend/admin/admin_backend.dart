import 'dart:convert';

import 'package:eight_hundred_cal/services/http_service.dart';
import 'package:eight_hundred_cal/utils/api_constants.dart';
import 'package:get/get.dart';

class AdminBackend extends GetxController {
  Map adminData = {};

  fetchAdminData() async {
    try {
      var response = await HttpServices.get(ApiConstants.adminDetails);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        adminData = data['details'];
        update();
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print("Fetch Admin Data Error: $e");
    }
  }
}
