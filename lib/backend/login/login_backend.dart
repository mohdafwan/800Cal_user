import 'dart:convert';
import 'dart:developer';

import 'package:eight_hundred_cal/model/appleuser/apple_user.dart';
import 'package:eight_hundred_cal/screens/login/signup_screen.dart';
import 'package:eight_hundred_cal/screens/splash.dart';
import 'package:eight_hundred_cal/widgets/error_snak_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../model/profile/profile_model.dart';
import '../../services/http_service.dart';
import '../../services/storage_service.dart';
import '../../utils/api_constants.dart';
import '../../utils/db_keys.dart';
import '../profile/profile_backend.dart';
import '../subscription/subscription_backend.dart';

class LoginBackend extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.back();
      ErrorSnackBar("Please fill all the fields");
      return false;
    }

    isLoading.value = true;

    try {
      var response = await HttpServices.post(
        ApiConstants.login,
        jsonEncode({
          "username": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        log("Login Data: $data");

        if (data['error']) {
          errorMessage.value = data['message'];
          return false;
        } else {
          StorageService().write(DbKeys.authToken, data["token"]);
          await handleSuccessfulLogin(data);
          return true;
        }
      } else {
        errorMessage.value = "No user found with this email and password";
        return false;
      }
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
      log(e.toString());
      ErrorSnackBar(errorMessage.value);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleSuccessfulLogin(Map<String, dynamic> data) async {
    var controller = Get.put(ProfileBackend());
    bool profileFetched = await controller.fetchProfileData();

    if (profileFetched) {
      ProfileModel model = controller.model!;
      await Get.put(SubscriptionBackend())
          .fetchSubscriptionData(model.subscriptionId);

      Get.offAll(() => SplashScreen());
    } else {
      errorMessage.value = "Failed to fetch profile data";
      ErrorSnackBar(errorMessage.value);
    }
  }

  Future<bool> checkUserExists(String email, String googleUid) async {
    try {
      Map<String, String> requestData = {
        "email": email,
      };

      var response = await HttpServices.post(
        ApiConstants.checkUserExists,
        jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        log("Check User Exists Response: $data");

        if (!data['error']) {
          log("User exists, logging in...");

          var loginResponse = await HttpServices.post(
            ApiConstants.login,
            jsonEncode({
              "username": email,
              "password": googleUid,
            }),
          );

          if (loginResponse.statusCode == 200) {
            var loginData = jsonDecode(loginResponse.body);
            log("Login Data: $loginData");

            if (loginData['error']) {
              errorMessage.value = loginData['message'];
            } else {
              StorageService().write(DbKeys.authToken, loginData["token"]);
              await handleSuccessfulLogin(loginData);
              Fluttertoast.showToast(
                  msg: "Login Successful!", backgroundColor: Colors.green);
            }
          } else {
            errorMessage.value = "No user found with this email";
          }

          return true;
        } else {
          errorMessage.value = data['message'];
          return false;
        }
      } else {
        log("Unexpected status code: ${response.statusCode}");
        errorMessage.value = "No user found with this email.";
        return false;
      }
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
      log(e.toString());
      ErrorSnackBar(errorMessage.value);
      return false;
    }
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    var controller = Get.put(LoginBackend());
    try {
      await _googleSignIn.signOut();

      var googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        var email = googleUser.email;
        var googleUid = googleUser.id;

        print(googleUser.photoUrl);
        print("Google user signed in with email: $email and uid: $googleUid");
        bool userExists = await controller.checkUserExists(email, googleUid);

        if (!userExists) {
          print("No user found, navigating to registration...");
          Fluttertoast.showToast(
              msg: "you are not register", backgroundColor: Colors.red);
          Get.off(() => SignupScreen(googleUser: googleUser));
        }
      } else {
        String message = ("User has cancelled login with Google");
        Fluttertoast.showToast(msg: errorMessage.value = message);
      }
    } catch (e) {
      print("Error signing in with Google: $e");
    } finally {
      isLoading.value = false;
    }
  }

  forgetPassword(String email) async {
    try {
      Map body = {"username": email, "role": "customer"};
      var response = await HttpServices.patch(
          ApiConstants.forgetPassword, jsonEncode(body));
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "We have sent you a reset password link to your email.");
        Get.back();
      } else {
        Fluttertoast.showToast(
            msg: "please Enter valid email", backgroundColor: Colors.redAccent);
        Get.back();
        print("Forget Password Error: ${response.body}");
        // ErrorSnackBar("Something went wrong");
      }
    } catch (e) {
      print("Forget Password Error: $e");
    }
  }

  Future<void> signInWithFacebook() async {
    isLoading.value = true;
    var controller = Get.put(LoginBackend());

    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final userDataR = await FacebookAuth.instance.getUserData();
        var email = userDataR['email'];
        var facebookUid = userDataR['id'];

        print(userDataR['picture']['data']['url']);
        print(
            "Facebook user signed in with email: $email and uid: $facebookUid");

        // Check if the user exists
        bool userExists = await controller.checkUserExists(email, facebookUid);

        if (!userExists) {
          print("No user found, navigating to registration...");
          Fluttertoast.showToast(
              msg: "you are not registered", backgroundColor: Colors.red);
          Get.off(() => SignupScreen(facebookUser: userDataR));
        }
      } else if (result.status == LoginStatus.cancelled) {
        String message = ("User has cancelled login with Facebook");
        Fluttertoast.showToast(msg: errorMessage.value = message);
      } else {
        String message = ("Facebook login failed: ${result.message}");
        Fluttertoast.showToast(msg: errorMessage.value = message);
      }
    } catch (e) {
      print("Error signing in with Facebook: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithApple() async {
    isLoading.value = true;
    var controller = Get.put(LoginBackend());
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final email = appleCredential.email ?? "Apple user";
      final firstName = appleCredential.givenName ?? "";
      final lastName = appleCredential.familyName ?? "";
      final appleUid = appleCredential.userIdentifier ?? "";

      //String uniqueEmail = "Apple User${appleUid.substring(0, 10)}";

      // List appleCredentailDetail = [uniqueEmail, appleUid];
      AppleUserDetails appleUserDetails = AppleUserDetails(
        email: email,
        uid: appleUid,
        firstName: firstName,
        lastName: lastName,
      );

      // print("Apple user signed in with email: $uniqueEmail and uid: $appleUid");
      print(
          "Apple user signed in with email: ${email.toString()}, first name: $firstName, last name: $lastName, and uid: $appleUid");
      bool userExists = await controller.checkUserExists(email, appleUid);

      if (!userExists) {
        print("No user found, navigating to registration...");
        print(email);
        Fluttertoast.showToast(
            msg: "You are not registered", backgroundColor: Colors.red);

        // Get.off(() => SignupScreen(appleUser: appleCredentailDetail));
        Get.off(
          () => SignupScreen(
            appleUser: [
              appleUserDetails,
            ],
          ),
        );
      }
    } catch (e) {
      print("Error signing in with Apple: $e");
      Fluttertoast.showToast(msg: "Apple sign-in failed");
    } finally {
      isLoading.value = false;
    }
  }
}
