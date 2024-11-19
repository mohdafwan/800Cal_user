import 'dart:convert';
import 'dart:developer';

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/otp/otp_backend.dart';
import 'package:eight_hundred_cal/screens/login/otp_verification.dart';
import 'package:eight_hundred_cal/screens/login/upload_profile_reg.dart';
import 'package:eight_hundred_cal/widgets/error_snak_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/profile/profile_model.dart';
import '../../services/http_service.dart';
import '../../services/storage_service.dart';
import '../../utils/api_constants.dart';
import '../../utils/db_keys.dart';
import '../profile/profile_backend.dart';

class RegisterBackend extends GetxController {
  void sendOtp(
    String phone,
    String fname,
    String lname,
    String email,
    String password,
    String dob,
    String gender,
    String address,
    String height,
    String weight,
    String referalCode,
  ) {
    try {
      var otpBackend = Get.put(OtpBackend());
      otpBackend.sendOtpSms(phone);
      log("Navigating to OtpPageScreen2 with phone: $phone");
      Get.to(() => OtpPageScreen2(
            phone: phone,
            fname: fname,
            lname: lname,
            email: email,
            password: password,
            referalCode: referalCode,
            dob: dob,
            gender: gender,
            weight: weight,
            eheight: height,
            address: address,
          ))?.then((_) {
        Get.to(() => UploadProfilePhotoForRegister());
      });
    } catch (e) {
      log("Error during OTP navigation: $e");
      ErrorSnackBar("Failed to navigate to OTP screen");
    }
  }

  void completeRegistration(
    String phone,
    String fname,
    String lname,
    String email,
    String password,
    String dob,
    String gender,
    String weight,
    String height,
    String address,
    String referalCode,
  ) async {
    Map<String, String> requestData = {
      "username": email,
      "password": password,
      "email": email,
      "phonenumber": phone,
      "firstname": fname,
      "lastname": lname,
      "dob": dob,
      'gender': gender,
      "weight": weight,
      "height": height,
      "address": address,
      "referredby": referalCode,
    };

    log("Register Request Data: $requestData");

    var response =
        await HttpServices.post(ApiConstants.register, jsonEncode(requestData));

    log("Register Response Status Code: ${response.statusCode}");
    log("Register Response Body: ${response.body}");

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      log("Register Response Data: $data");

      if (data['error']) {
        Get.back();
        ErrorSnackBar(data['message']);
      } else {
        log("Login Data: $data");
        StorageService().write(DbKeys.authToken, data["token"]);
        Get.back();
        // var controller = Get.put(ProfileBackend());
        // await controller.fetchProfileData().then(
        //   (value) async {
        //     if (value) {
        //       ProfileModel model = Get.put(ProfileBackend()).model!;
        //       await Get.put(SubscriptionBackend())
        //           .fetchSubscriptionData(model.subscriptionId);
        //       Get.offAll(() => SplashScreen());
        //     }
        //   },
        // );
        showSnackBar("Registration successful");
      }
    } else if (response.statusCode == 400) {
      Get.back();
      log("Register Response Error: User already exists");
      ErrorSnackBar("User already exists");
    } else {
      Get.back();
      log("Register Response Error: ${response.body}");
      ErrorSnackBar("Something went wrong");
    }
  }

  void register(
    String fname,
    String lname,
    String phone,
    String email,
    String dob,
    String gender,
    String weight,
    String height,
    String address,
    String password, {
    String referalCode = '',
  }) async {
    if (email != "" &&
        password != "" &&
        fname != "" &&
        lname != "" &&
        phone != "") {
      sendOtp(
        phone,
        fname,
        lname,
        email,
        password,
        dob,
        gender,
        weight,
        height,
        address,
        referalCode,
      );
    } else {
      Get.back();
      ErrorSnackBar("Please fill all the fields");
    }
  }

  void showSnackBar(String message, {bool isError = false}) {
    Get.snackbar(
      isError ? "Error" : "Success",
      message,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  registerSubProfile(ProfileModel model) async {
    try {
      ProfileBackend profileBackend = Get.put(ProfileBackend());
      ProfileModel primaryModel = profileBackend.model!;

      Map<String, dynamic> data = {
        "username": model.email,
        "password": model.password,
        "email": model.email,
        "phonenumber": model.phonenumber,
        "firstname": model.firstname,
        "lastname": model.lastname,
        "address": model.address,
        "gender": model.gender,
        "height": model.height,
        "weight": model.weight,
        "dob": model.dob,
      };

      var response =
          await HttpServices.post(ApiConstants.register, jsonEncode(data));
      var resBody = jsonDecode(response.body);

      if (response.statusCode == 201) {
        print("Register Response Body: $resBody");
        if (resBody.containsKey("token") && resBody["token"] != null) {
          String token = resBody["token"];

          List<String> arr = List<String>.from(primaryModel.subusers);
          arr.remove(token);
          model.subusers.addAll(arr);

          var resp = await HttpServices.patchWithToken(
              ApiConstants.updateProfile, jsonEncode(model.toJson()), token);
          if (resp.statusCode == 200) {
            arr.add(token);
            log('token:$token');
            primaryModel.subusers = arr;

            var resFinal = await HttpServices.patchWithToken(
                ApiConstants.updateProfile,
                jsonEncode(primaryModel.toJson()),
                profileBackend.userToken);
            if (resFinal.statusCode == 200) {
              profileBackend.fetchProfileData();
              Get.back();
              Get.put(BottomBarBackend()).updateIndex(10);
            } else {
              print("Final profile update error: ${resFinal.body}");
              _showMessage(resFinal.body);
            }
          } else {
            print("Subuser profile update error: ${resp.body}");
            _showMessage(resp.body);
          }
        } else {
          print("Register response did not contain a valid token");
          _showMessage("Register response did not contain a valid token");
        }
      } else {
        print("Register Sub Profile Error: ${response.body}");
        _showMessage(resBody["message"] ?? "Register Sub Profile Error");
      }
    } catch (e) {
      print("Register Sub Profile Error: $e");
      _showMessage("Register Sub Profile Error: $e");
    }
  }

  void _showMessage(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
