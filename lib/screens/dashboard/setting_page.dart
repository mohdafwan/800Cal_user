import 'dart:io';

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/theme/theme_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_appbar.dart';
import 'package:eight_hundred_cal/widgets/ios_custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../utils/app_text.dart';
import '../profile/delete_profile.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      Get.put(BottomBarBackend()).updateIndex(4);
      return Future.value(false);
    }

    var c = Get.put(TranslatorBackend());
    Get.put(ThemeBackend()).checkTheme();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Platform.isIOS
                ? IosCustomAppBar(
                    text: c.lang == 'en'
                        ? AppText.settingsEn
                        : AppText.settingsAr,
                    onPressesd: () {
                      Get.put(BottomBarBackend()).updateIndex(4);
                    },
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
                        .copyWith(top: 20),
                    child: CustomAppBar(
                        text: c.lang == 'en'
                            ? AppText.settingsEn
                            : AppText.settingsAr),
                  ),
          ),
          backgroundColor: AppColor.pimaryColor,
          body: GetBuilder<ThemeBackend>(
            init: ThemeBackend(),
            builder: (controller) {
              return Scaffold(
                backgroundColor: AppColor.pimaryColor,
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
                      .copyWith(top: 20),
                  child: Column(
                    children: [
                      // Platform.isIOS
                      //     ? IosCustomAppBar(
                      //         text: c.lang == 'en'
                      //             ? AppText.settingsEn
                      //             : AppText.settingsAr,
                      //         onPressesd: () {})
                      //     : CustomAppBar(
                      //         text: c.lang == 'en'
                      //             ? AppText.settingsEn
                      //             : AppText.settingsAr),
                      // heightBox(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            c.lang == 'en'
                                ? AppText.darkModeEn
                                : AppText.darkModeAr,
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          FlutterSwitch(
                            width: 60,
                            height: 30,
                            value: controller.isDarkMode,
                            onToggle: (value) {
                              controller.updateTheme(value);
                            },
                            activeToggleColor: AppColor.secondaryColor,
                            activeColor: AppColor.inputBoxBGColor,
                            inactiveColor: AppColor.inputBoxBGColor,
                          ),
                        ],
                      ),
                      Divider(
                        color: AppColor.mediumGreyColor,
                      ),
                      DeleteProfile(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
