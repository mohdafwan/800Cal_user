import 'package:eight_hundred_cal/screens/login/register_screen_detail.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../backend/bottom_bar/bottom_bar_backend.dart';
import '../../backend/login/register_backend.dart';
import '../../backend/otp/otp_backend.dart';
import '../../backend/translator/translator_backend.dart';
import '../../utils/app_text.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/show_loader_dialog.dart';

// Change from StatelessWidget to StatefulWidget
class OtpPageScreen2 extends StatefulWidget {
  final String phone;
  final String fname;
  final String lname;
  final String email;
  final String password;
  final String dob;
  final String gender;
  final String weight;
  final String eheight;
  final String address;
  final String referalCode;

  OtpPageScreen2({
    Key? key,
    required this.phone,
    required this.fname,
    required this.lname,
    required this.email,
    required this.password,
    required this.dob,
    required this.gender,
    required this.weight,
    required this.eheight,
    required this.address,
    required this.referalCode,
  }) : super(key: key);

  @override
  State<OtpPageScreen2> createState() => _OtpPageScreen2State();
}

class _OtpPageScreen2State extends State<OtpPageScreen2> {
  late String currentPhone;
  final otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentPhone = widget.phone;
  }

  Future<bool> _onWillPop() async {
    Get.find<BottomBarBackend>().updateIndex(13);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final translatorBackend = Get.find<TranslatorBackend>();
    final otpBackend = Get.find<OtpBackend>();
    final registerBackend = Get.find<RegisterBackend>();

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: AppColor.pimaryColor,
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translatorBackend.lang == 'en'
                      ? AppText.enterFourDigitOtpEn
                      : AppText.enterFourDigitOtpAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                heightBox(8),
                Row(
                  children: [
                    Text(
                      '${translatorBackend.lang == 'en' ? AppText.codeSentToEn : AppText.codeSentToAr} +965 $currentPhone ',
                      style: TextStyle(
                        color: AppColor.secondaryGreyColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: AppColor.whiteColor),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            final newPhoneController =
                                TextEditingController(text: widget.phone);
                            return AlertDialog(
                              backgroundColor: AppColor.pimaryColor,
                              title: Text(
                                'Edit Phone Number',
                                style: TextStyle(color: AppColor.whiteColor),
                              ),
                              content: TextField(
                                controller: newPhoneController,
                                keyboardType: TextInputType.number,
                                maxLength: 8,  // Limit to 8 digits
                                style: TextStyle(color: AppColor.whiteColor),
                                decoration: InputDecoration(
                                  hintText: 'Enter 8 digit phone number',
                                  hintStyle: TextStyle(
                                      color: AppColor.secondaryGreyColor),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.whiteColor),
                                  ),
                                  counterText: "", // Hide the counter
                                ),
                                onChanged: (value) {
                                  // Remove any non-digit characters
                                  String digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
                                  
                                  // Ensure exactly 8 digits
                                  if (digitsOnly.length > 8) {
                                    newPhoneController.text = digitsOnly.substring(0, 8);
                                    newPhoneController.selection = TextSelection.fromPosition(
                                      TextPosition(offset: 8),
                                    );
                                  }
                                },
                              ),
                              actions: [
                                TextButton(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: AppColor.whiteColor),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                  child: Text(
                                    'Save',
                                    style: TextStyle(color: AppColor.whiteColor),
                                  ),
                                  onPressed: () {
                                    if (newPhoneController.text.length == 8) {  // Validate length
                                      setState(() {
                                        currentPhone = newPhoneController.text;
                                      });
                                      Get.back();
                                      // Clear previous OTP
                                      otpController.clear();
                                      // Send OTP to new number
                                      otpBackend.sendOtpSms(newPhoneController.text);
                                      // Show toast message
                                      Fluttertoast.showToast(msg: 'OTP sent to new number');
                                    } else {
                                      Fluttertoast.showToast(msg: 'Please enter 8 digits');
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                heightBox(30),
                Container(
                  width: double.infinity,
                  height: height(context) * .1,
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColor.secondaryGreyColor,
                  ),
                  child: Center(
                    child: TextFormField(
                      controller: otpController,
                      scrollPhysics: NeverScrollableScrollPhysics(),
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      style: TextStyle(
                        fontSize: 40,
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.w600,
                        letterSpacing: width(context) * .13,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: "",
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Center(
                  child: CustomButton(
                    text: translatorBackend.lang == 'en'
                        ? AppText.nextEn
                        : AppText.nextAr,
                    onTap: () async {
                      if (otpController.text.isNotEmpty) {
                        showLoaderDialog(context);
                        bool isVerified =
                            otpBackend.verifyOtp(otpController.text);
                        Navigator.pop(context);
                        if (isVerified) {
                          Fluttertoast.showToast(msg: 'Successfully verified');

                          registerBackend.completeRegistration(
                            currentPhone,
                            widget.fname,
                            widget.lname,
                            widget.email,
                            widget.password,
                            widget.dob,
                            widget.gender,
                            widget.weight,
                            widget.eheight,
                            widget.address,
                            widget.referalCode,
                          );
                        } else {
                          Fluttertoast.showToast(msg: 'Wrong OTP');
                        }
                      } else {
                        Fluttertoast.showToast(msg: 'Please enter OTP');
                      }
                    },
                  ),
                ),
                heightBox(80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
