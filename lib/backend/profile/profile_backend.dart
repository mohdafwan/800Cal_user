import 'dart:convert';
import 'dart:io';

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/profile/profile_model.dart';
import 'package:eight_hundred_cal/screens/splash.dart';
import 'package:eight_hundred_cal/services/cloudinary_setup.dart';
import 'package:eight_hundred_cal/services/http_service.dart';
import 'package:eight_hundred_cal/services/storage_service.dart';
import 'package:eight_hundred_cal/utils/api_constants.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/utils/db_keys.dart';
import 'package:eight_hundred_cal/widgets/show_loader_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileBackend extends GetxController {
  /* ProfileModel? model;
  String userToken = '';
  var isLoading = false.obs;
  Future<bool> fetchProfileData() async {
    isLoading.value = true;
    var c = Get.put(TranslatorBackend());
    String token = await StorageService().read(DbKeys.authToken);
    userToken = token;
    var response = await HttpServices.getWithToken(ApiConstants.profile, token);
    debugPrint("responsedata profiledata111${response.body}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      debugPrint("responsedata profiledata222${data}");
      model = ProfileModel.fromJson(data['customer']);

      model?.username = await c.translateText(model!.username);
      model?.email = await c.translateText(model!.email);
      model?.firstname = await c.translateText(model!.firstname);
      model?.lastname = await c.translateText(model!.lastname);
      model?.gender = await c.translateText(model!.gender);
      model?.gender = await c.translateText(model!.gender);
      model?.phonenumber = await c.translateText(model!.phonenumber);
      model?.address = await c.translateText(model!.address);
      model?.image = await c.translateText(model!.image);
      Get.put(SubscriptionBackend()).updateDate(
          DateTime.fromMillisecondsSinceEpoch(
              Get.put(ProfileBackend()).model!.subscriptionStartDate));
      isLoading.value = false;
      update();
      return true;
    } else {
      print("Fetch profile data failed333: ${response.statusCode}");
      isLoading.value = false;
    }
    return false;
  }*/

  ProfileModel? model;
  String userToken = '';
  var isLoading = false.obs;

  Future<bool> fetchProfileData() async {
    isLoading.value = true;
    try {
      userToken = await StorageService().read(DbKeys.authToken);
      var response =
          await HttpServices.getWithToken(ApiConstants.profile, userToken);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        model = ProfileModel.fromJson(data['customer']);
        await _translateProfileData();
        Get.put(SubscriptionBackend()).updateDate(
          DateTime.fromMillisecondsSinceEpoch(model!.subscriptionStartDate),
        );
      } else {
        _handleError("Failed to fetch profile data: ${response.statusCode}");
      }
    } catch (e) {
      _handleError("An error occurred while fetching profile data: $e");
    } finally {
      isLoading.value = false;
      update();
    }
    return model != null;
  }

  Future<void> _translateProfileData() async {
    final translator = Get.put(TranslatorBackend());
    model?.username = await translator.translateText(model!.username);
    model?.email = await translator.translateText(model!.email);
    model?.firstname = await translator.translateText(model!.firstname);
    model?.lastname = await translator.translateText(model!.lastname);
    model?.gender = await translator.translateText(model!.gender);
    model?.phonenumber = await translator.translateText(model!.phonenumber);
    model?.address = await translator.translateText(model!.address);
    model?.image = await translator.translateText(model!.image);
  }

  void _handleError(String message) {
    // Replace with a custom error dialog or notification
    print(message);
  }

  Future<ProfileModel> fetchProfileData2(String token) async {
    try {
      var c = Get.put(TranslatorBackend());
      var response =
          await HttpServices.getWithToken(ApiConstants.profile, token);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        ProfileModel model2 = ProfileModel.fromJson(data['customer']);

        model2.username = await c.translateText(model!.username);
        model2.email = await c.translateText(model!.email);
        model2.firstname = await c.translateText(model!.firstname);
        model2.lastname = await c.translateText(model!.lastname);
        model2.gender = await c.translateText(model!.gender);
        model2.gender = await c.translateText(model!.gender);
        model2.phonenumber = await c.translateText(model!.phonenumber);
        model2.address = await c.translateText(model!.address);
        //model2.image = await c.translateText(model!.image);
        update();
        return model2;
      } else {
        print("Fetch profile data failed: ${response.statusCode}");
      }
      return dummyProfileModel;
    } catch (e) {
      print("Fetching profile data failed: $e");
      return dummyProfileModel;
    }
  }

  // uploadImage(ImageSource source, BuildContext context) async {
  //   final picker = await ImagePicker().pickImage(source: source);
  //   showLoaderDialog(context);
  //   if (picker != null) {
  //     String url = await CloudinaryService().uploadFIle(File(picker.path));
  //     Get.back();
  //     model!.image = url;
  //     update();
  //   } else {
  //     Get.back();
  //   }
  // }
  uploadImage(ImageSource source, BuildContext context) async {
    try {
      final picker = await ImagePicker().pickImage(source: source);
      if (picker != null) {
        showLoaderDialog(context);
        String url = await CloudinaryService().uploadFIle(File(picker.path));
        Get.back();
        model!.image = url;
        update();
      } else {
        Get.snackbar(
          'Error',
          'No image selected',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      //Get.back(); // Close the loader if it's open
      // Get.snackbar(
      //   'Error',
      //   'Failed to upload image: $e',
      //   snackPosition: SnackPosition.BOTTOM,
      // );
      showPermissionDialog(context);
    }
  }

  void showPermissionDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("Permission Denied"),
          content: Text("Please enable the permission in the app settings."),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: Text("Cancel"),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: Text("Go to Settings"),
              onPressed: () {
                Get.back();
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  updateProfile(ProfileModel model, BuildContext context) async {
    try {
      showLoaderDialog(context);
      String token = await StorageService().read(DbKeys.authToken);
      var response = await HttpServices.patchWithToken(
          ApiConstants.updateProfile, jsonEncode(model.toJson()), token);

      if (response.statusCode == 200) {
        fetchProfileData();
        Get.back();
        Get.put(BottomBarBackend()).updateIndex(10);
      } else {
        print("Update profile data failed: ${response.statusCode}");
      }
    } catch (e) {
      print("update profile data failed: $e");
    }
  }

  updateProfile2(ProfileModel model, BuildContext context) async {
    try {
      String token = await StorageService().read(DbKeys.authToken);
      var response = await HttpServices.patchWithToken(
          ApiConstants.updateProfile, jsonEncode(model.toJson()), token);

      if (response.statusCode == 200) {
        fetchProfileData();
      } else {
        print("Update profile data failed: ${response.statusCode}");
      }
    } catch (e) {
      print("update profile data failed: $e");
    }
  }

  updateSubscriptionProfile(ProfileModel model) async {
    try {
      String token = await StorageService().read(DbKeys.authToken);
      var response = await HttpServices.patchWithToken(
          ApiConstants.updateProfile, jsonEncode(model.toJson()), token);

      if (response.statusCode == 200) {
        Get.deleteAll();
        Get.offAll(() => SplashScreen());
      } else {
        print("Update profile data failed: ${response.statusCode}");
      }
    } catch (e) {
      print("update profile data failed: $e");
    }
  }
}
