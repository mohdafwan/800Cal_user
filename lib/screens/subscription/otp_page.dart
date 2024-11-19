import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/otp/otp_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../backend/payments/payment_gateway.dart';
import '../../utils/app_text.dart';

class OtpPageScreen extends StatelessWidget {
  final String phoneNumber;
  final Map data;
  OtpPageScreen({super.key, required this.phoneNumber, required this.data});

  var otpController = TextEditingController();
  Future<bool> _onWillPop() async {
    Get.put(BottomBarBackend()).updateIndex(13);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              c.lang == 'en'
                  ? AppText.enterFourDigitOtpEn
                  : AppText.enterFourDigitOtpAr,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 52,
                fontWeight: FontWeight.w600,
              ),
            ),
            heightBox(8),
            Text(
              '${c.lang == 'en' ? AppText.codeSentToEn : AppText.codeSentToAr} $phoneNumber ',
              style: TextStyle(
                color: AppColor.secondaryGreyColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
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
                text: c.lang == 'en' ? AppText.nextEn : AppText.nextAr,
                onTap: () {
                  if (otpController.text.isNotEmpty) {
                    if (Get.find<OtpBackend>().verifyOtp(otpController.text)) {
                      Get.put(PaymentGateway()).orderPayments(context, data);
                      // Map<String, dynamic> data2 = {
                      //   'TranID': [
                      //     'Trx233424d',
                      //   ],
                      // };
                      // Get.put(PaymentGateway())
                      //     .successOrder(context, data, data2);
                    } else {
                      Fluttertoast.showToast(msg: 'Wrong Otp');
                    }
                  } else {
                    Fluttertoast.showToast(msg: 'Please enter otp');
                  }
                },
              ),
            ),
            heightBox(80),
          ],
        ),
      ),
    ));
  }
}
