import 'package:eight_hundred_cal/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../screens/login/login_screen.dart';
import '../../services/storage_service.dart';

class AccountController extends GetxController {
  var isDeleting = false.obs;
  var deleteSuccess = false.obs;
  var deleteError = ''.obs;

  Future<void> deleteAccount(String accessToken) async {
    final String url = ApiConstants.deleteProfile;
    isDeleting.value = true;
    deleteSuccess.value = false;
    deleteError.value = '';

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        print('Success Account deleted successfully.');
        deleteSuccess.value = true;
        logoutAndNavigateToLogin();
      } else {
        print('Error Failed to delete account: ${response.body}');
        deleteError.value = 'Failed to delete account: ${response.body}';
      }
    } catch (e) {
      print('Error An error occurred: $e');
      deleteError.value = 'An error occurred: $e';
    } finally {
      isDeleting.value = false;
    }
  }

  void logoutAndNavigateToLogin() async {
    await StorageService().box.erase();
    Get.offAll(() => LoginScreen());
  }
}
