import 'dart:developer';

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/restaurant/restaurant_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/restaurant/group_restaurant_model.dart';
import 'package:eight_hundred_cal/screens/subscription/widgets/group_restaurant_card.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_text.dart';
import '../../widgets/custom_button.dart';

class SilverRestaurantScreen extends StatelessWidget {
  const SilverRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return GetBuilder<RestaurantBackend>(builder: (controller) {
      List<GroupRestaurantModel> model = controller.groupRestaurantModel
          .where(
              (element) => element.price <= subscriptionModel.meal.silverprice)
          .toList();
      return Stack(
        children: [
          Column(
            children: [
              Text(
                '${model.length} ${c.lang == 'en' ? AppText.restaurantEn : AppText.restaurantAr}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightBox(15),
              Flexible(
                child: GridView.builder(
                  padding: const EdgeInsets.only(bottom: 180),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: model.length,
                  itemBuilder: (context, index) {
                    log('jj${model.length}');
                    return GroupRestaurantCard(
                      model: model[index],
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: SizedBox(
                width: 200,
                height: 50,
                child: CustomButton(
                  text:
                      "${c.lang == 'en' ? AppText.priceEn : AppText.priceAr} ${subscriptionModel.meal.silverprice}${c.lang == 'en' ? AppText.kdEn : AppText.kdAr}",
                  onTap: () {
                    subscriptionModel.restaurant = model;
                    subscriptionModel.groupRestaurantCategory = "Silver";
                    Get.put(BottomBarBackend()).updateIndex(13);
                  },
                )),
          ),
        ],
      );
    });
  }
}
