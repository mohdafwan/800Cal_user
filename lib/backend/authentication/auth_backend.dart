import 'dart:convert';

import 'package:get/get.dart';

import '../../services/http_service.dart';
import '../../utils/api_constants.dart';

class AuthBackend extends GetxController {
  Future<bool> authentication() async {
    var response = await HttpServices.get(ApiConstants.authentication);

    var data = jsonDecode(response.body);
    return data['status'];
  }
}
