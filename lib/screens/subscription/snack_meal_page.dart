// ignore_for_file: prefer_const_constructors

import 'package:eight_hundred_cal/backend/restaurant/restaurant_backend.dart';
import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/screens/subscription/widgets/meal_select_icon_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../backend/bottom_bar/bottom_bar_backend.dart';
import '../../backend/profile/profile_backend.dart';
import '../../backend/translator/translator_backend.dart';
import '../../utils/app_text.dart';
import '../../widgets/custom_button.dart';
import 'choose_your_meals_page.dart';

class SnackSoupMealPageScreen extends StatelessWidget {
  final List menu;
  final TabController? tabController;
  const SnackSoupMealPageScreen(
      {super.key, required this.menu, this.tabController});

  @override
  Widget build(BuildContext context) {
    List sList = menu.where((e) => e['category'] == 'snack').toList();
    var c = Get.find<TranslatorBackend>();
    return GetBuilder<SubscriptionBackend>(builder: (controller) {
      return Stack(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.78,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: sList.length,
            padding: EdgeInsets.only(bottom: 120),
            itemBuilder: (context, index) {
              return MealSelectIconCard(
                data: sList[index],
                index: 2,
              );
            },
          ),
          controller.dateMealList[DateFormat('dd-MMM-yyyy').format(mealDate)] !=
                      null &&
                  controller
                          .dateMealList[DateFormat('dd-MMM-yyyy')
                              .format(mealDate)]['food']
                          .length >
                      2
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 120),
                    child: CustomButton(
                      onTap: () async {
                        if (Get.put(RestaurantBackend()).edit) {
                          await Get.put(SubscriptionBackend()).updateCalendar();
                        } else {
                          await Get.put(SubscriptionBackend())
                              .addCalendarMeal();
                        }
                        if (Get.put(ProfileBackend()).model?.isSubscribed ??
                            false) {
                          Get.put(BottomBarBackend()).updateIndex(3);
                        } else {
                          Get.put(BottomBarBackend()).updateIndex(16);
                        }
                      },
                      text: c.lang == 'en'
                          ? AppText.confirmEn
                          : AppText.confirmAr,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      );
    });
  }
}
