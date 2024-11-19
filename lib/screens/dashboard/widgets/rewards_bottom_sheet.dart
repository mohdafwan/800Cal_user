import 'dart:io';

import 'package:eight_hundred_cal/backend/profile/profile_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/profile/profile_model.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/colors.dart';
import '../../../widgets/bottom_sheet_divider.dart';
import 'package:qr_flutter/qr_flutter.dart';

void showRewardBottomSheet(BuildContext context) {
  ProfileModel model = Get.put(ProfileBackend()).model!;
  var c = Get.put(TranslatorBackend());
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColor.pimaryColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    builder: (context) {
      return SingleChildScrollView(
        child: Container(
          width: width(context),
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: AppColor.pimaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: BottomSheetDivider()),
              Text(
                c.lang == 'en' ? AppText.shareEn : AppText.shareAr,
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightBox(20),
              Center(
                child: QrImageView(
                  data: model.referralcode,
                  version: QrVersions.auto,
                  backgroundColor: AppColor.calendarbgColor,
                  foregroundColor: AppColor.whiteColor,
                  size: 160.0,
                ),
              ),
              heightBox(20),
              RewardBottomSheetDataCard(
                  onTap: () {
                    if (Platform.isAndroid) {
                      Share.share(
                          "Unlock the power of 800 cal! Join now with my referral code: ${model.referralcode} for exclusive rewards. Don't miss out, download today. $playStoreUrl");
                    } else {
                      Share.share(
                          "Unlock the power of 800 cal! Join now with my referral code: ${model.referralcode} for exclusive rewards. Don't miss out, download today. $appStoreUrl");
                    }
                  },
                  text: c.lang == 'en'
                      ? AppText.shareYourProfileEn
                      : AppText.shareYourProfileAr),
              heightBox(20),
              RewardBottomSheetDataCard(
                text: c.lang == 'en'
                    ? AppText.inviteOthersEn
                    : AppText.inviteOthersAr,
                onTap: () {
                  if (Platform.isAndroid) {
                    Share.share(
                        "Unlock the power of 800 cal! Join now with my referral code: ${model.referralcode} for exclusive rewards. Don't miss out, download today. $playStoreUrl");
                  } else {
                    Share.share(
                        "Unlock the power of 800 cal! Join now with my referral code: ${model.referralcode} for exclusive rewards. Don't miss out, download today. $appStoreUrl");
                  }
                },
              ),
              heightBox(20),
              RewardBottomSheetDataCard(
                  text:
                      "${c.lang == 'en' ? AppText.referalPointsEn : AppText.referalPointsAr}: ${model.referralpoints}"),
              heightBox(20),
              RewardBottomSheetDataCard(
                  onTap: () {
                    if (Platform.isAndroid) {
                      Share.share(
                          "Unlock the power of 800 cal! Join now with my referral code: ${model.referralcode} for exclusive rewards. Don't miss out, download today. $playStoreUrl");
                    } else {
                      Share.share(
                          "Unlock the power of 800 cal! Join now with my referral code: ${model.referralcode} for exclusive rewards. Don't miss out, download today. $appStoreUrl");
                    }
                  },
                  text: c.lang == 'en'
                      ? AppText.yourUniqueLinkEn
                      : AppText.yourUniqueLinkAr),
            ],
          ),
        ),
      );
    },
  );
}

class RewardBottomSheetDataCard extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const RewardBottomSheetDataCard({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 380,
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColor.calendarbgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
