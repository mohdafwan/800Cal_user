// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:eight_hundred_cal/backend/login/login_backend.dart';
import 'package:eight_hundred_cal/backend/theme/theme_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/guestmode/guest_mode.dart';
import 'package:eight_hundred_cal/screens/login/forget_password.dart';
import 'package:eight_hundred_cal/screens/login/signup_screen.dart';
import 'package:eight_hundred_cal/screens/splash.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:eight_hundred_cal/widgets/custom_text_box.dart';
import 'package:eight_hundred_cal/widgets/error_snak_bar.dart';
import 'package:eight_hundred_cal/widgets/show_loader_dialog.dart';
import 'package:eight_hundred_cal/widgets/skip_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  var c = Get.put(LoginBackend());
  var t = Get.put(TranslatorBackend());

  void _handleLogin() async {
    showLoaderDialog(context);
    bool loginSuccess =
        await c.login(emailController.text, passwordController.text);
    Navigator.of(context).pop();
    if (loginSuccess) {
      //SucessSnackBar("Login successful for user: ${emailController.text}");
      SucessSnackBar("✅Login successful");
      Get.offAll(
        () => SplashScreen(),
      );
    } else {
      print("Login failed. Please check your credentials.");
    }
  }

  @override
  void dispose() {
    _handleLogin();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ThemeBackend>(
        init: ThemeBackend(),
        builder: (controller) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColor.pimaryColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  children: [
                    SkipButton(
                      onTap: () {
                        Get.to(() => GuestScreen());
                      },
                    ),
                    heightBox(MediaQuery.of(context).size.height / 65),
                    Image.asset(
                      "assets/icons/logo.png",
                      height: width(context) * .4,
                      width: width(context) * .4,
                    ),
                    Text(
                      t.lang == 'en'
                          ? AppText.loginForFreeEn
                          : AppText.loginForFreeAr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    heightBox(24),
                    CustomTextBox(
                      hintText: t.lang == 'en'
                          ? AppText.usernameEn
                          : AppText.usernameAr,
                      controller: emailController,
                    ),
                    heightBox(20),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: t.lang == 'en'
                            ? AppText.passwordEn
                            : AppText.passwordAr,
                        hintStyle: TextStyle(
                          color: AppColor.textgreyColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        fillColor: AppColor.inputBoxBGColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: AppColor.whiteColor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: AppColor.inputBoxBGColor, width: 2),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColor.textgreyColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    heightBox(10),
                    InkWell(
                      onTap: () {
                        Get.to(() => ForgetPassword());
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          t.lang == 'en'
                              ? AppText.forgetPasswordEn
                              : AppText.forgetPasswordAr,
                          style: TextStyle(
                            color: AppColor.secondaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    heightBox(27),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SocialMediaLoginCardwithFaceBook(),
                          Platform.isIOS
                              ? SocialMediaLoginCardwithApple()
                              : SocialMediaLoginCard()
                        ],
                      ),
                    ),
                    heightBox(32),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: t.lang == 'en'
                                ? AppText.donthaveanaccountEn
                                : AppText.donthaveanaccountAr,
                            style: TextStyle(
                              color: AppColor.mediumGreyColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(text: " "),
                          TextSpan(
                              text: t.lang == 'en'
                                  ? AppText.signupEn
                                  : AppText.signupAr,
                              style: TextStyle(
                                color: AppColor.secondaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(() => SignupScreen());
                                })
                        ],
                      ),
                    ),
                    heightBox(32),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Obx(() {
                        if (c.isLoading.value) {
                          return CircularProgressIndicator();
                        }
                        return CustomButton(
                          text: t.lang == 'en'
                              ? AppText.loginEn
                              : AppText.loginAr,
                          onTap: _handleLogin,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Google singin [ Google signIn ]
class SocialMediaLoginCard extends StatelessWidget {
  const SocialMediaLoginCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var t = Get.put(TranslatorBackend());
    var controller = Get.find<LoginBackend>();
    return InkWell(
      onTap: () {
        controller.signInWithGoogle();
      },
      child: Container(
        height: 70,
        width: Get.width * 0.43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.inputBoxBGColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/google.png",
              height: 28,
              width: 28,
            ),
            widthBox(10),
            Text(
              t.lang == 'en' ? AppText.googleEn : AppText.googleAr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Facebook signin [ FaceBook singIn ]
class SocialMediaLoginCardwithFaceBook extends StatelessWidget {
  const SocialMediaLoginCardwithFaceBook({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var t = Get.put(TranslatorBackend());
    var controller = Get.find<LoginBackend>();
    return InkWell(
      onTap: () {
        controller.signInWithFacebook();
      },
      child: Container(
        height: 70,
        width: Get.width * 0.43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.inputBoxBGColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/fb.png",
              height: 28,
              width: 28,
            ),
            widthBox(10),
            Text(
              t.lang == 'en' ? AppText.facebookEn : AppText.facebookAr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Apple signin [ Apple singIn ]
class SocialMediaLoginCardwithApple extends StatelessWidget {
  const SocialMediaLoginCardwithApple({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var t = Get.put(TranslatorBackend());
    var controller = Get.find<LoginBackend>();
    return InkWell(
      onTap: () {
        controller.signInWithApple();
      },
      child: Container(
        height: 70,
        width: Get.width * 0.43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.inputBoxBGColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/apple.png",
              height: 28,
              width: 28,
            ),
            widthBox(10),
            Text(
              t.lang == 'en' ? AppText.appleEn : AppText.appleAr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
