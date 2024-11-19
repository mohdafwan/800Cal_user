// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/guestmode/widget/homescreen_banner.dart';
import 'package:eight_hundred_cal/screens/guestmode/widget/profile_complete_banner.dart';
import 'package:eight_hundred_cal/screens/home/widgets/home_screen_program_widget.dart';
import 'package:eight_hundred_cal/screens/home/widgets/home_screen_restaurant_widget.dart';
import 'package:eight_hundred_cal/screens/login/login_screen.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../backend/profile/profile_backend.dart';
import '../../backend/program/program_backend.dart';
import '../../backend/restaurant/restaurant_backend.dart';

class GuestHomeScreen extends StatelessWidget {
  const GuestHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TranslatorBackend()).checkLanguage();
    Get.put(ProfileBackend()).fetchProfileData();
    var programBackend = Get.put(ProgramBackend());
    var resturantBackend = Get.put(RestaurantBackend());
    programBackend.fetchAllPrograms();
    resturantBackend.fetchAllRestaurants();
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(LoginScreen());
        return false;
      },
      child: SafeArea(
        child: GetBuilder<TranslatorBackend>(builder: (controller) {
          return Scaffold(
            backgroundColor: AppColor.pimaryColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
                    .copyWith(top: 20),
                child: Column(
                  children: [
                    CustomAppBar(
                        text: controller.lang == 'en'
                            ? AppText.homeHeadingEn
                            : AppText.homeHeadingAr),
                    heightBox(20),
                    heightBox(20),
                    HomeScreenBanner(),
                    heightBox(15),
                    ProfileCompleteBanner(),
                    heightBox(15),
                    HomeScreenProgramWidget(),
                    heightBox(20),
                    HomeScreenRestaurantWidget(),
                    // Obx(() => Skeletonizer(
                    //     enabled: programBackend.isLoading.value,
                    //     child: HomeScreenBanner())),

                    // heightBox(15),
                    // Obx(() => Skeletonizer(
                    //     enabled: programBackend.isLoading.value,
                    //     child: ProfileCompleteBanner())),

                    // heightBox(15),
                    // Obx(
                    //   () => Skeletonizer(
                    //       enabled: programBackend.isLoading.value,
                    //       child: HomeScreenProgramWidget()),
                    // ),

                    // heightBox(20),
                    // Obx(
                    //   () => Skeletonizer(
                    //       enabled: resturantBackend.isLoading.value,
                    //       child: HomeScreenRestaurantWidget()),
                    // ),

                    // // heightBox(20),
                    // //HomeScreenSuccessStoryWidget(),
                    // heightBox(200),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
