import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../backend/translator/translator_backend.dart';
import '../../../utils/app_text.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

class ProfileCompleteBanner extends StatelessWidget {
  const ProfileCompleteBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Container(
      width: double.infinity,
      height: 70,
      decoration: ShapeDecoration(
        color: AppColor.inputBoxBGColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19),
        child: Row(
          children: [
            Icon(
              Icons.person,
              color: AppColor.secondaryColor,
              size: 32,
            ),
            widthBox(28),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  c.lang == 'en'
                      ? AppText.homeCompleteProfileEn
                      : AppText.homeCompleteProfileAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  c.lang == 'en'
                      ? AppText.betterRecommendationsEn
                      : AppText.betterRecommendationsAr,
                  style: TextStyle(
                    color: AppColor.secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
