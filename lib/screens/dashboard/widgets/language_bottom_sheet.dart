import 'dart:developer';

import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';

void showLanguageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    constraints: BoxConstraints(maxHeight: 365),
    backgroundColor: AppColor.pimaryColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    builder: (context) {
      Get.put(TranslatorBackend()).checkLanguage();
      return GetBuilder<TranslatorBackend>(builder: (controller) {
        return Container(
          padding: EdgeInsets.all(30),
          width: width(context),
          child: Column(
            children: [
              Text(
                controller.lang == 'en'
                    ? AppText.chooseTheLanguageEn
                    : AppText.chooseTheLanguageAr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightBox(20),
              LanguageBottomSheetDataCard(
                image: 'assets/images/us_flag.jpg',
                language: controller.lang == 'en'
                    ? AppText.englishEn
                    : AppText.englishAr,
                isSelected: controller.lang == 'en',
                onTap: () {
                  controller.changeLanguage('en');
                },
              ),
              heightBox(20),
              LanguageBottomSheetDataCard(
                image: 'assets/images/kuwait_flag.png',
                language: controller.lang == 'en'
                    ? AppText.arabicEn
                    : AppText.arabicAr,
                isSelected: controller.lang == 'ar',
                onTap: () {
                  controller.changeLanguage('ar');
                },
              ),
              heightBox(20),
              CustomButton(
                text: controller.lang == 'en' ? AppText.doneEn : AppText.doneAr,
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
      });
    },
  );
}

class LanguageBottomSheetDataCard extends StatelessWidget {
  final String language;
  final bool isSelected;
  final Function()? onTap;
  final String image;
  const LanguageBottomSheetDataCard(
      {super.key,
      required this.language,
      required this.isSelected,
      this.onTap,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width(context),
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColor.calendarbgColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1,
                color:
                    isSelected ? AppColor.secondaryColor : AppColor.whiteColor),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              image,
              height: 50,
              width: 60,
            ),
            widthBox(20),
            Text(
              language,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                    isSelected ? AppColor.secondaryColor : AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
