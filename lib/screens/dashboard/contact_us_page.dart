import 'dart:io';

import 'package:eight_hundred_cal/backend/admin/admin_backend.dart';
import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_appbar.dart';
import 'package:eight_hundred_cal/widgets/ios_custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dashboard_page.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});
  Future<bool> _onWillPop() {
    Get.put(BottomBarBackend()).updateIndex(4);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
          child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Platform.isIOS
              ? IosCustomAppBar(
                  text: c.lang == 'en'
                      ? AppText.contactUsEn
                      : AppText.contactUsAr,
                  onPressesd: () {
                    Get.put(BottomBarBackend()).updateIndex(4);
                  },
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: CustomAppBar(
                      text: c.lang == 'en'
                          ? AppText.contactUsEn
                          : AppText.contactUsAr),
                ),
        ),
        backgroundColor: AppColor.pimaryColor,
        body: GetBuilder<AdminBackend>(builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
                .copyWith(top: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // CustomAppBar(
                  //     text: c.lang == 'en'
                  //         ? AppText.contactUsEn
                  //         : AppText.contactUsAr),
                  heightBox(20),
                  DashboardCardWidget(
                    fontSize: 16,
                    image: "assets/icons/phone.png",
                    title: '${controller.adminData['phonenumber'] ?? ''}',
                    onTap: () async {
                      String url =
                          'tel:${controller.adminData['phonenumber'] ?? ''}';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    },
                  ),
                  heightBox(20),
                  DashboardCardWidget(
                    fontSize: 16,
                    image: "assets/icons/email.png",
                    title: '${controller.adminData['email'] ?? ''}',
                    onTap: () async {
                      String url =
                          'mailto:${controller.adminData['email'] ?? ''}?subject=App Feedback&body='
                          '';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    },
                  ),
                  heightBox(20),
                  DashboardCardWidget(
                    fontSize: 16,
                    image: "assets/icons/instagram.png",
                    title: '${controller.adminData['instagram'] ?? ''}',
                    onTap: () async {
                      String url = '${controller.adminData['instagram'] ?? ''}'
                          '';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    },
                  ),
                  heightBox(20),
                  DashboardCardWidget(
                    fontSize: 16,
                    image: "assets/icons/twitter.png",
                    title: '${controller.adminData['twitter'] ?? ''}',
                    onTap: () async {
                      String url = '${controller.adminData['twitter'] ?? ''}'
                          '';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    },
                  ),
                  heightBox(20),
                  DashboardCardWidget(
                    fontSize: 16,
                    image: "assets/icons/web.png",
                    title: '${controller.adminData['website'] ?? ''}',
                    onTap: () async {
                      String url = '${controller.adminData['website'] ?? ''}'
                          '';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    },
                  ),
                  heightBox(20),
                  DashboardCardWidget(
                    fontSize: 16,
                    image: "assets/icons/tik-tok.png",
                    title: '${controller.adminData['tiktok'] ?? ''}',
                    onTap: () async {
                      String url = '${controller.adminData['tiktok'] ?? ''}'
                          '';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    },
                  ),
                  heightBox(20),
                  DashboardCardWidget(
                    fontSize: 16,
                    image: "assets/icons/snapchat.png",
                    title: '${controller.adminData['snapchat'] ?? ''}',
                    onTap: () async {
                      String url = '${controller.adminData['snapchat'] ?? ''}'
                          '';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    },
                  ),
                  heightBox(20),
                  DashboardCardWidget(
                    fontSize: 16,
                    image: "assets/icons/whatsapp.png",
                    title: '${controller.adminData['whatsapp'] ?? ''}',
                    showColor: false,
                    onTap: () async {
                      String url = '${controller.adminData['whatsapp'] ?? ''}'
                          '';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    },
                  ),
                  heightBox(20),
                  DashboardCardWidget(
                    fontSize: 16,
                    image: "assets/icons/facebook.png",
                    title: '${controller.adminData['facebook'] ?? ''}',
                    onTap: () async {
                      String url = '${controller.adminData['facebook'] ?? ''}'
                          '';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    },
                  ),
                  heightBox(120),
                ],
              ),
            ),
          );
        }),
      )),
    );
  }
}
