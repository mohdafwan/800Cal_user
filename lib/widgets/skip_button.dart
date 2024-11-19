// import 'package:eight_hundred_cal/backend/theme/theme_backend.dart';
// import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:get/get.dart';

// import '../utils/app_text.dart';
// import '../utils/colors.dart';

// class SkipButton extends StatefulWidget {
//   final Function()? onTap;
//   const SkipButton({super.key, required this.onTap});

//   @override
//   State<SkipButton> createState() => _SkipButtonState();
// }

// class _SkipButtonState extends State<SkipButton> {
//   var c = Get.put(TranslatorBackend());

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Get.put(ThemeBackend()).checkTheme();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ThemeBackend>(
//         init: ThemeBackend(),
//         builder: (controller) {
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               FlutterSwitch(
//                 width: 70,
//                 height: 48,
//                 value: controller.isDarkMode,
//                 onToggle: (value) {
//                   controller.updateTheme(value);
//                 },
//                 activeToggleColor: AppColor.secondaryColor,
//                 activeColor: AppColor.inputBoxBGColor,
//                 inactiveColor: AppColor.inputBoxBGColor,
//               ),
//               InkWell(
//                 onTap: widget.onTap,
//                 child: Text(
//                   c.lang == 'en'
//                       ? AppText.continueAsGuestEn
//                       : AppText.continueAsGuestAr,
//                   style: TextStyle(
//                     color: AppColor.secondaryColor,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               )
//             ],
//           );
//         });
//   }
// }
import 'dart:developer';

import 'package:eight_hundred_cal/backend/theme/theme_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/db_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../utils/app_text.dart';
import '../utils/colors.dart';

class SkipButton extends StatefulWidget {
  final Function()? onTap;
  const SkipButton({super.key, required this.onTap});

  @override
  State<SkipButton> createState() => _SkipButtonState();
}

class _SkipButtonState extends State<SkipButton> {
  late TranslatorBackend c;
  late ThemeBackend themeBackend;

  @override
  void initState() {
    super.initState();
    c = Get.put(TranslatorBackend());
    themeBackend = Get.put(ThemeBackend());
    themeBackend.checkTheme();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeBackend>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlutterSwitch(
              width: 70,
              height: 48,
              value: controller.isDarkMode,
              onToggle: (value) {
                controller.updateTheme(value);
              },
              activeToggleColor: AppColor.secondaryColor,
              activeColor: AppColor.inputBoxBGColor,
              inactiveColor: AppColor.inputBoxBGColor,
            ),
            InkWell(
              onTap: widget.onTap,
              // onTap: () {
              //   String dummyAccessToken = DbKeys.authToken;
              //   log('Sending dummy access token: $dummyAccessToken');
              //   if (widget.onTap != null) {
              //     widget.onTap!();
              //   }
              // },
              child: Text(
                c.lang == 'en'
                    ? AppText.continueAsGuestEn
                    : AppText.continueAsGuestAr,
                style: TextStyle(
                  color: AppColor.secondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
