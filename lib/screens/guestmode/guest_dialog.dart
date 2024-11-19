import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../login/login_screen.dart';

class GuestDialog extends StatelessWidget {
  const GuestDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.pimaryColor,
      elevation: 5,
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Gap(32),
            Flexible(
              flex: 1,
              child: SvgPicture.asset(
                'assets/images/info.svg',
                width: 80,
              ),
            ),
            Gap(10),
            Flexible(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    'Please login to continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Gap(10),
                  SizedBox(
                    width: 100,
                    child: OutlinedButton(
                      onPressed: (() {
                        Get.offAll(LoginScreen());
                      }),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColor.greenColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Gap(10),
                  GestureDetector(
                    onTap: (() {
                      Get.back();
                    }),
                    child: Text(
                      'Continue as Guest',
                      style: TextStyle(color: AppColor.textgreyColor
                          // fontWeight: FontWeight.bold,
                          // fontSize: 20,
                          ),
                    ),
                  ),
                  Gap(5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
