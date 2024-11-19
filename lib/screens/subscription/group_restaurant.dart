// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/restaurant/restaurant_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/subscription/gold_restaurant.dart';
import 'package:eight_hundred_cal/screens/subscription/platinum_restaurant.dart';
import 'package:eight_hundred_cal/screens/subscription/silver_restaurant.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/ios_custom_appbar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_appbar.dart';

class GroupRestaurantPage extends StatefulWidget {
  const GroupRestaurantPage({super.key});

  @override
  State<GroupRestaurantPage> createState() => _GroupRestaurantPageState();
}

class _GroupRestaurantPageState extends State<GroupRestaurantPage>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Get.put(RestaurantBackend()).fetchGroupRestaurant();
  }

  Future<bool> _onWillPop() {
    Get.put(BottomBarBackend()).updateIndex(6);
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
                  onPressesd: () {
                    Get.put(BottomBarBackend()).updateIndex(6);
                  },
                  text: c.lang == 'en'
                      ? AppText.chooseYourGroupEnios
                      : AppText.chooseYourGroupArios,
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: CustomAppBar(
                    text: c.lang == 'en'
                        ? AppText.chooseYourGroupEn
                        : AppText.chooseYourGroupAr,
                  ),
                ),
        ),
        backgroundColor: AppColor.pimaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
              .copyWith(top: 20),
          child: Column(
            children: [
              // Platform.isIOS
              //     ? IosCustomAppBar(
              //         onPressesd: () {
              //           Get.put(BottomBarBackend()).updateIndex(6);
              //         },
              //         text: c.lang == 'en'
              //             ? AppText.chooseYourGroupEn
              //             : AppText.chooseYourGroupAr,
              //       )
              //     : CustomAppBar(
              //         text: c.lang == 'en'
              //             ? AppText.chooseYourGroupEn
              //             : AppText.chooseYourGroupAr,
              //       ),
              heightBox(20),
              GroupRestaurantTabBar(tabController: _tabController),
              heightBox(15),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SilverRestaurantScreen(),
                    GoldRestaurantScreen(),
                    PlatinumRestaurantScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class GroupRestaurantTabBar extends StatelessWidget {
  const GroupRestaurantTabBar({
    super.key,
    required TabController? tabController,
  }) : _tabController = tabController;

  final TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return TabBar(
        controller: _tabController,
        indicatorColor: AppColor.whiteColor,
        labelColor: AppColor.whiteColor,
        unselectedLabelColor: AppColor.reviewCardTextColor,
        tabs: [
          Tab(
            text: c.lang == 'en' ? AppText.silverEn : AppText.silverAr,
          ),
          Tab(
            text: c.lang == 'en' ? AppText.goldEn : AppText.goldAr,
          ),
          Tab(
            text: c.lang == 'en' ? AppText.platinumEn : AppText.platinumAr,
          ),
        ]);
  }
}
