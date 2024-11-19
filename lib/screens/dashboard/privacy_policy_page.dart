import 'dart:io';

import 'package:eight_hundred_cal/backend/admin/admin_backend.dart';
import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/widgets/ios_custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_appbar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});
  Future<bool> _onWilPop() {
    Get.put(BottomBarBackend()).updateIndex(4);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    final isIos = Platform.isIOS;
    return WillPopScope(
      onWillPop: _onWilPop,
      child: SafeArea(
          child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: isIos
              ? IosCustomAppBar(
                  text: c.lang == 'en'
                      ? AppText.privacyPolicyEn
                      : AppText.privacyPolicyAr,
                  onPressesd: () {
                    Get.put(BottomBarBackend()).updateIndex(4);
                  })
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(top: 20),
                  child: CustomAppBar(
                    text: c.lang == 'en'
                        ? AppText.privacyPolicyEn
                        : AppText.privacyPolicyAr,
                  ),
                ),
        ),
        backgroundColor: AppColor.pimaryColor,
        body: GetBuilder<AdminBackend>(builder: (controller) {
          String data = controller.adminData['privacypolicy'];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // CustomAppBar(
                  //     text: c.lang == 'en'
                  //         ? AppText.privacyPolicyEn
                  //         : AppText.privacyPolicyAr),
                  heightBox(20),
                  HtmlWidget(
                    '''$data''',
                    renderMode: RenderMode.column,

                    // set the default styling for text
                    textStyle:
                        TextStyle(fontSize: 16, color: AppColor.whiteColor),
                  ),
                ],
              ),
            ),
          );
        }),
      )),
    );
  }
}
