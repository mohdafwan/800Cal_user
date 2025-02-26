import 'dart:io';

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/order/order_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/dashboard/widgets/past_subscription_card.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_appbar.dart';
import 'package:eight_hundred_cal/widgets/custom_text_box.dart';
import 'package:eight_hundred_cal/widgets/ios_custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YourOrdersPage extends StatelessWidget {
  const YourOrdersPage({super.key});
  Future<bool> _onWillPop() {
    Get.put(BottomBarBackend()).updateIndex(4);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(OrderBackend()).fetchOrder();
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
                      ? AppText.yourOrdersEn
                      : AppText.yourOrdersAr,
                  onPressesd: () {
                    Get.put(BottomBarBackend()).updateIndex(4);
                  })
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
                      .copyWith(top: 20),
                  child: CustomAppBar(
                      text: c.lang == 'en'
                          ? AppText.yourOrdersEn
                          : AppText.yourOrdersAr),
                ),
        ),
        backgroundColor: AppColor.pimaryColor,
        body: GetBuilder<OrderBackend>(builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
                  .copyWith(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CustomAppBar(
                  //     text: c.lang == 'en'
                  //         ? AppText.yourOrdersEn
                  //         : AppText.yourOrdersAr),
                  heightBox(20),
                  CustomTextBox(
                    hintText:
                        '${c.lang == 'en' ? AppText.programSearchEn : AppText.programSearchAr}...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColor.whiteColor,
                    ),
                    onChanged: (p0) {
                      controller.searchOrder(p0);
                    },
                  ),
                  heightBox(20),
                  Text(
                    c.lang == 'en'
                        ? AppText.pastSubscriptionsEn
                        : AppText.pastSubscriptionsAr,
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  heightBox(10),
                  ListView.separated(
                    itemCount: controller.orderList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PastSubscriptionCard(
                        model: controller.orderList[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return heightBox(10);
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
