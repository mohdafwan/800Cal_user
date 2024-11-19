import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eight_hundred_cal/model/appleuser/apple_user.dart';
import 'package:eight_hundred_cal/backend/login/register_backend.dart';

import 'package:eight_hundred_cal/backend/theme/theme_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/guestmode/guest_mode.dart';
import 'package:eight_hundred_cal/screens/login/login_screen.dart';

import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/widgets/password_controller.dart';
import 'package:eight_hundred_cal/widgets/show_loader_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_date_calendar_picker.dart';
import '../../widgets/custom_text_box.dart';
import '../../widgets/skip_button.dart';

class SignupScreen extends StatefulWidget {
  final GoogleSignInAccount? googleUser;
  final List? appleUser;
  final Map<String, dynamic>? facebookUser;
  const SignupScreen(
      {Key? key, this.googleUser, this.facebookUser, this.appleUser})
      : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String dob = "";
  bool _obscureText = true;
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final referalCodeController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  var selectedGender = '';
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final addressController = TextEditingController();
  final List<String> genderItems = ['Male', 'Female'];
  String? selectedValue;

  var c = Get.put(RegisterBackend());
  var t = Get.put(TranslatorBackend());

  @override
  void initState() {
    super.initState();
    if (widget.googleUser != null) {
      final nameParts = widget.googleUser!.displayName?.split(' ') ?? [];
      fnameController.text = nameParts.isNotEmpty ? nameParts.first : '';
      lnameController.text = nameParts.length > 1 ? nameParts.last : '';
      emailController.text = widget.googleUser!.email;
      passwordController.text = widget.googleUser!.id;
      print(nameParts);
    }

    if (widget.facebookUser != null) {
      fnameController.text = widget.facebookUser!['first_name'] ?? '';
      lnameController.text = widget.facebookUser!['last_name'] ?? '';
      emailController.text = widget.facebookUser!['email'] ?? '';
      passwordController.text = widget.facebookUser!['id'] ?? '';
      print(widget.facebookUser);
    }

    // if (widget.appleUser != null) {
    //   emailController.text = widget.appleUser!.first;
    //   passwordController.text = widget.appleUser!.last;
    // }
    if (widget.appleUser != null && widget.appleUser!.isNotEmpty) {
      final appleUserDetails = widget.appleUser!.first as AppleUserDetails;
      fnameController.text = appleUserDetails.firstName;
      lnameController.text = appleUserDetails.lastName;
      emailController.text = appleUserDetails.email;
      passwordController.text = appleUserDetails.uid;
      log("Apple user signed in with email: ${appleUserDetails.email}, first name: ${appleUserDetails.firstName}, last name: ${appleUserDetails.lastName}, and uid: ${appleUserDetails.uid}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAppleUser =
        widget.appleUser != null && widget.appleUser!.isNotEmpty;
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SkipButton(
                        onTap: () {
                          Get.to(() => GuestScreen());
                        },
                      ),
                      Image.asset(
                        "assets/icons/logo.png",
                        height: 200,
                        width: 200,
                      ),
                      emailController.text.isEmpty
                          ? Text(
                              t.lang == 'en'
                                  ? AppText.signupForFreeEn
                                  : AppText.signupForFreeAr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : Text(
                              t.lang == 'en'
                                  ? AppText.continuesignupForFreeEn
                                  : AppText.continuesignupForFreeAr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                      heightBox(20),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: fnameController,
                        enabled: !isAppleUser,
                        decoration: InputDecoration(
                          hintText: t.lang == 'en'
                              ? AppText.firstNameEn
                              : AppText.firstNameAr,
                          hintStyle: TextStyle(
                            color: AppColor.textgreyColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          fillColor: AppColor.inputBoxBGColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppColor.whiteColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: AppColor.inputBoxBGColor,
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'First name is required';
                          }
                          return null;
                        },
                      ),
                      heightBox(20),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: lnameController,
                        enabled: !isAppleUser,
                        decoration: InputDecoration(
                          hintText: t.lang == 'en'
                              ? AppText.lastNameEn
                              : AppText.lastNameAr,
                          hintStyle: TextStyle(
                            color: AppColor.textgreyColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          fillColor: AppColor.inputBoxBGColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppColor.whiteColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: AppColor.inputBoxBGColor,
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Last name is required';
                          }
                          return null;
                        },
                      ),
                      heightBox(20),
                      Row(
                        children: [
                          Container(
                            height: 55,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColor.inputBoxBGColor,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: AppColor.whiteColor, width: 2),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '🇰🇼',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '+965',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Only kuwait numbers are allowed',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    backgroundColor: AppColor.secondaryColor,
                                    duration: Duration(seconds: 3),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              decoration: InputDecoration(
                                hintText: t.lang == 'en'
                                    ? AppText.phoneNumberEn
                                    : AppText.phoneNumberAr,
                                hintStyle: TextStyle(
                                  color: AppColor.textgreyColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                fillColor: AppColor.inputBoxBGColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: AppColor.whiteColor, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: AppColor.inputBoxBGColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(8),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone number is required';
                                }

                                String phoneNumber = value.replaceAll(RegExp(r'\D'), '');

                                if (phoneNumber.length != 8) {
                                  return 'Phone number must be 8 digits';
                                }

                                // Check if the number starts with valid Kuwait mobile prefixes
                                if (!phoneNumber.startsWith(RegExp(r'[569]'))) {
                                  return 'Invalid Kuwait number. Must start with 5, 6, or 9';
                                }

                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      //gmail
                      emailController.text.isEmpty
                          ? heightBox(20)
                          : heightBox(0),
                      emailController.text.isEmpty
                          ? TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: emailController,
                              enabled: widget.googleUser == null,
                              decoration: InputDecoration(
                                hintText: t.lang == 'en'
                                    ? AppText.emailEn
                                    : AppText.emailAr,
                                hintStyle: TextStyle(
                                  color: AppColor.textgreyColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                fillColor: AppColor.inputBoxBGColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: AppColor.whiteColor, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: AppColor.inputBoxBGColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            )
                          : heightBox(0),
                      heightBox(20),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: dobController,
                        decoration: InputDecoration(
                          hintText: t.lang == 'en'
                              ? AppText.dateofbirthEn
                              : AppText.dateofbirthAr,
                          hintStyle: TextStyle(
                            color: AppColor.textgreyColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          fillColor: AppColor.inputBoxBGColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppColor.whiteColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: AppColor.inputBoxBGColor,
                              width: 2,
                            ),
                          ),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime currentDate = DateTime.now();
                          DateTime firstDate = DateTime(currentDate.year - 100);
                          DateTime lastDate = currentDate;

                          DateTime? pickedDate = await customDatePicker(
                              context, firstDate, lastDate);
                          if (pickedDate != null) {
                            dob = pickedDate.toString();
                            dobController.text =
                                DateFormat('dd MMM, yyyy').format(pickedDate);
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Date of birth is required';
                          }
                          return null;
                        },
                      ),
                      heightBox(20),
                      DropdownButtonFormField2(
                        isExpanded: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppColor.whiteColor, width: 2),
                          ),
                          fillColor: AppColor.inputBoxBGColor,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: AppColor.inputBoxBGColor,
                              width: 2,
                            ),
                          ),
                        ),
                        hint: Text(
                          "Gender",
                          style: TextStyle(color: AppColor.textgreyColor),
                        ),
                        items: genderItems
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    color: AppColor.textgreyColor,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select gender';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value as String;
                          });
                        },
                        onSaved: (value) {
                          selectedGender = value.toString();
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                          ),
                          iconSize: 24,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColor.inputBoxBGColor,
                          ),
                        ),
                        menuItemStyleData: MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                        ),
                        value: selectedValue,
                      ),
                      heightBox(20),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: addressController,
                        decoration: InputDecoration(
                          hintText: t.lang == 'en'
                              ? AppText.addressEn
                              : AppText.addressAr,
                          hintStyle: TextStyle(
                            color: AppColor.textgreyColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          fillColor: AppColor.inputBoxBGColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppColor.whiteColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: AppColor.inputBoxBGColor,
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Address is required';
                          }
                          return null;
                        },
                      ),
                      heightBox(20),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: t.lang == 'en'
                              ? AppText.enterYourHeightEn
                              : AppText.enterYourHeightAr,
                          fillColor: AppColor.inputBoxBGColor,
                          filled: true,
                          hintStyle: TextStyle(
                            color: AppColor.textgreyColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppColor.whiteColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: AppColor.inputBoxBGColor,
                              width: 2,
                            ),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Height is required';
                          }
                          int height = int.tryParse(value) ?? 0;

                          if (height < 50 || height > 300) {
                            return 'Please enter a valid height';
                          }

                          return null;
                        },
                      ),
                      heightBox(20),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        controller: weightController,
                        decoration: InputDecoration(
                          hintText: t.lang == 'en'
                              ? AppText.enterYourWeightEn
                              : AppText.enterYourWeightAr,
                          hintStyle: TextStyle(
                            color: AppColor.textgreyColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          fillColor: AppColor.inputBoxBGColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppColor.whiteColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: AppColor.inputBoxBGColor,
                              width: 2,
                            ),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Weight is required';
                          }
                          return null;
                        },
                      ),
                      heightBox(20),
                      passwordController.text.isEmpty
                          ? TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: passwordController,
                              enabled: widget.googleUser == null,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                hintText: widget.googleUser != null
                                    ? "Password set to Google ID"
                                    : (t.lang == 'en'
                                        ? AppText.passwordEn
                                        : AppText.passwordAr),
                                hintStyle: TextStyle(
                                  color: AppColor.textgreyColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                fillColor: AppColor.inputBoxBGColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: AppColor.whiteColor, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: AppColor.inputBoxBGColor,
                                    width: 2,
                                  ),
                                ),
                                // suffixIcon: IconButton(
                                //   icon: Icon(
                                //     _obscureText
                                //         ? Icons.visibility_off
                                //         : Icons.visibility,
                                //     color: AppColor.textgreyColor,
                                //   ),
                                //   onPressed: () {
                                //     setState(() {
                                //       _obscureText = !_obscureText;
                                //     });
                                //   },
                                //   splashColor: Colors.transparent,
                                //   highlightColor: Colors.transparent,
                                // ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }

                                return null;
                              },
                            )
                          : heightBox(0),
                      passwordController.text.isEmpty
                          ? heightBox(20)
                          : heightBox(0),
                      CustomTextBox(
                        hintText: t.lang == 'en'
                            ? "${AppText.referalCodeEn} (${AppText.optionalEn})"
                            : "${AppText.referalCodeAr} (${AppText.optionalAr})",
                        controller: referalCodeController,
                        obscureText: true,
                      ),
                      heightBox(20),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: t.lang == 'en'
                                  ? AppText.alreadyhaveanaccountEn
                                  : AppText.alreadyhaveanaccountAr,
                              style: TextStyle(
                                color: AppColor.mediumGreyColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: " ",
                            ),
                            TextSpan(
                                text: t.lang == 'en'
                                    ? AppText.loginEn
                                    : AppText.loginAr,
                                style: TextStyle(
                                  color: AppColor.secondaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(() => LoginScreen());
                                  })
                          ],
                        ),
                      ),

                      heightBox(
                          height(context) * (t.lang == 'en' ? 0.03 : .03)),
                      heightBox(10),
                      CustomButton(
                        text: t.lang == 'en'
                            ? AppText.createAccountEn
                            : AppText.createAccountAr,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            showLoaderDialog(context);
                            c.register(
                              fnameController.text,
                              lnameController.text,
                              phoneController.text,
                              emailController.text,
                              dobController.text,
                              selectedGender.toLowerCase(),
                              addressController.text,
                              heightController.text,
                              weightController.text,
                              passwordController.text,
                              referalCode: referalCodeController.text.isNotEmpty
                                  ? referalCodeController.text
                                  : '',
                            );
                          }
                        },
                      ),
                      heightBox(50),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
