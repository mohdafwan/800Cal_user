import 'dart:convert';
import 'dart:math';
import 'package:eight_hundred_cal/services/http_service.dart';
import 'package:eight_hundred_cal/utils/api_constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OtpBackend extends GetxController {
  String otp = '';

  void generateOtp() {
    Random random = Random();
    int value = random.nextInt(9999);
    otp = value.toString().padLeft(4, '0');
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );
  }

  bool isValidKuwaitiNumber(String phoneNumber) {
    String normalizedNumber = phoneNumber.replaceAll('+965', '').trim();
    return RegExp(r'^(?:965)?[569]\d{7}$').hasMatch(normalizedNumber);
  }

  String formatPhoneNumber(String phoneNumber) {
    String normalizedNumber = phoneNumber.replaceAll('+965', '');
    normalizedNumber = normalizedNumber.replaceFirst(RegExp(r'^0+'), '');
    return '965$normalizedNumber';
  }

  Future<void> sendOtpSms(String phoneNumber) async {
    if (!isValidKuwaitiNumber(phoneNumber)) {
      showToastMessage('Please enter a valid Kuwait phone number');
      return;
    }

    String formattedNumber = formatPhoneNumber(phoneNumber);
    generateOtp();

    Map<String, String> body = {
      "username": 'e800cal',
      "password": '6Th8@yNu7K',
      "sender": "800cal", 
      "mobile": formattedNumber,
      "lang": "2",
      "message": "$otp is your verification code for 800cal",
    };

    try {
      var response = await HttpServices.post(
        ApiConstants.otp, 
        jsonEncode(body),
      );

      print("Request body: ${jsonEncode(body)}");
      print("Response: ${response.body}");
      
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        
        if (responseData['result'] == 'OK' ) {
          showToastMessage('OTP sent successfully');
        } else {
          showToastMessage('Failed to send OTP: ${responseData['description'] ?? 'Unknown error'}');
        }
      } else {
        showToastMessage('Failed to send OTP, please try again');
      }
    } catch (e) {
      showToastMessage('Network error, please try again');
    }
  }

  bool verifyOtp(String value) {
    return otp == value;
  }
}