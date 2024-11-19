// ignore_for_file: prefer_const_constructors

import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:eight_hundred_cal/widgets/custom_text_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/translator/translator_backend.dart';
import '../utils/app_text.dart';
import '../utils/colors.dart';

showAddNoteDialog(BuildContext context, DateTime dateTime, int index) {
  var c = Get.put(TranslatorBackend());
  var controller = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.all(10),
        backgroundColor: AppColor.inputBoxBGColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          height: height(context) * .4,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Column(
              children: [
                heightBox(20),
                Text(
                  "Add Note",
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                heightBox(20),
                CustomTextBox(
                  controller: controller,
                  hintText: 'Add Note',
                  showBorder: true,
                  maxLength: 40,
                ),
                heightBox(10),
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (value) {},
                      fillColor:
                          MaterialStateProperty.all(AppColor.secondaryColor),
                      activeColor: AppColor.secondaryColor,
                    ),
                    Flexible(
                      child: Text(
                        "I understand that not all restaurants accept notes per meal/personal request",
                        style: TextStyle(color: AppColor.whiteColor),
                      ),
                    ),
                  ],
                ),
                heightBox(20),
                CustomButton(
                    onTap: () {
                      Get.find<SubscriptionBackend>()
                          .addMealNote(dateTime, index, controller.text);
                      Get.back();
                    },
                    text: c.lang == 'en' ? AppText.okEn : AppText.okAr),
              ],
            ),
          ),
        ),
      );
    },
  );
}
