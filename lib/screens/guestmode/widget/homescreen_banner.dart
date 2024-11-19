import 'package:eight_hundred_cal/utils/db_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../backend/translator/translator_backend.dart';
import '../../../services/storage_service.dart';
import '../../../utils/app_text.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/text_constant.dart';
import '../guest_dialog.dart';

class HomeScreenBanner extends StatelessWidget {
  const HomeScreenBanner({
    super.key,
  });
  Future<bool> _isTokenAvilable() async {
    String? token = StorageService().read(DbKeys.authToken);
    return token != null && token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Container(
      width: double.infinity,
      height: height(context) * .206,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(1.00, 0.00),
          end: Alignment(-1, 0),
          colors: [AppColor.secondaryColor, AppColor.greenColor],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Stack(
        children: [
          Image.asset("assets/images/snacks_bowl.png"),
          Positioned(
            top: 28,
            left: 170,
            child: Column(
              children: [
                Text(
                  c.lang == 'en'
                      ? AppText.homeSubscriptionBannerEn
                      : AppText.homeSubscriptionBannerAr,
                  style: bodyText20(FontWeight.w600, AppColor.whiteColor),
                ),
                heightBox(16),
                Container(
                  width: 106,
                  height: 39,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  decoration: ShapeDecoration(
                    color: AppColor.whiteColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: InkWell(
                    onTap: () async {
                      if (await _isTokenAvilable()) {
                        Get.dialog(GuestDialog());
                      } else {
                        return null;
                      }
                    },
                    child: Center(
                      child: Text(
                        c.lang == 'en'
                            ? AppText.exploreNowEn
                            : AppText.exploreNowAr,
                        style: bodyText12(
                            FontWeight.w700, AppColor.secondaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
