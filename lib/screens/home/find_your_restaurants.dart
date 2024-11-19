// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:eight_hundred_cal/backend/restaurant/restaurant_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/home/restaurant_detail_page.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_appbar.dart';
import 'package:eight_hundred_cal/widgets/custom_text_box.dart';
import 'package:eight_hundred_cal/widgets/ios_custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../backend/bottom_bar/bottom_bar_backend.dart';
import '../../utils/app_text.dart';
import '../../widgets/restaurant_card.dart';

class FindYourRestaurantsScreen extends StatelessWidget {
  const FindYourRestaurantsScreen({super.key});
  Future<bool> _onWillPop() async {
    Get.put(BottomBarBackend()).updateIndex(0);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final isIos = Platform.isIOS;
    return GetBuilder<TranslatorBackend>(builder: (controller) {
      return WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
            child: Scaffold(
          backgroundColor: AppColor.pimaryColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: isIos
                ? IosCustomAppBar(
                    text: controller.lang == 'en'
                        ? AppText.restaurantHeadingEnisios
                        : AppText.restaurantHeadingArisios,
                    onPressesd: (() {
                      Get.put(BottomBarBackend()).updateIndex(0);
                    }))
                : Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: horizontalPadding,
                      right: horizontalPadding,
                    ),
                    child: CustomAppBar(
                      text: controller.lang == 'en'
                          ? AppText.restaurantHeadingEn
                          : AppText.restaurantHeadingAr,
                    ),
                  ),
          ),
          body: Padding(
            padding: EdgeInsets.only(
                top: 20, left: horizontalPadding, right: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CustomAppBar(
                //   // text: controller.lang == 'en'
                //   //     ? AppText.restaurantEn
                //   //     : AppText.restaurantAr,
                //   text: controller.lang == 'en'
                //       ? AppText.restaurantHeadingEn
                //       : AppText.restaurantHeadingAr,
                // ),
                heightBox(20),
                CustomTextBox(
                  hintText:
                      "${controller.lang == 'en' ? AppText.programSearchEn : AppText.programSearchAr}...",
                  onChanged: (p0) {
                    Get.put(RestaurantBackend()).searchRestaurantsByName(p0);
                  },
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColor.whiteColor,
                  ),
                ),
                heightBox(20),
                Text(
                  controller.lang == 'en'
                      ? AppText.restaurantEn
                      : AppText.restaurantAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                heightBox(20),
                RestaurantCardWidget(),
              ],
            ),
          ),
        )),
      );
    });
  }
}

class RestaurantCardWidget extends StatelessWidget {
  const RestaurantCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantBackend>(builder: (controller) {
      return Flexible(
        child: GridView.builder(
          itemCount: controller.tempRestaurants.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 18,
            crossAxisSpacing: 15,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.put(BottomBarBackend()).updateIndex(8);
                restaurantId = controller.tempRestaurants[index].id;
              },
              child: RestaurantCard(
                model: controller.tempRestaurants[index],
                showBubble: false,
              ),
            );
          },
        ),
      );
    });
  }
}
