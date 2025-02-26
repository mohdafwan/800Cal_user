import 'dart:developer';

import 'package:eight_hundred_cal/backend/profile/profile_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/profile/update_profile.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_appbar.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../../backend/bottom_bar/bottom_bar_backend.dart';
import '../../backend/subscription/subscription_backend.dart';
import '../../model/profile/profile_model.dart';
import '../splash.dart';

class UploadProfilePhotoForRegister extends StatelessWidget {
  const UploadProfilePhotoForRegister({super.key});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(ProfileBackend());
    var t = Get.put(TranslatorBackend());
    // Future<bool> _onWillPop() {
    //   Get.put(BottomBarBackend()).updateIndex(11);
    //   return Future.value(false);
    // }

    final ProfileBackend controller = Get.put(ProfileBackend());
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: AppColor.pimaryColor,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
                  .copyWith(top: 20),
              child: Column(
                children: [
                  CustomAppBar(
                    text: t.lang == 'en'
                        ? AppText.uploadyourprofilephotoEn
                        : AppText.uploadyourprofilephotoAr,
                    showProfile: false,
                  ),
                  heightBox(8),
                  Text(
                    t.lang == 'en'
                        ? AppText.updateProfileDescEn
                        : AppText.updateProfileDescAr,
                    style: TextStyle(
                      color: AppColor.secondaryGreyColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  heightBox(20),
                  InkWell(
                    onTap: () async {
                      await Get.put(ProfileBackend())
                          .uploadImage(ImageSource.gallery, context);
                    },
                    child: Container(
                      width: width(context),
                      // height: 130,
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: AppColor.inputBoxBGColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/icons/gallery.png",
                            width: 50,
                            height: 50,
                          ),
                          heightBox(10),
                          Text(
                            t.lang == 'en'
                                ? AppText.fromgalleryEn
                                : AppText.fromgalleryAr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  heightBox(20),
                  InkWell(
                    onTap: () async {
                      await Get.put(ProfileBackend())
                          .uploadImage(ImageSource.camera, context);
                    },
                    child: Container(
                      width: width(context),
                      // height: 130,
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: AppColor.inputBoxBGColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/icons/camera.png",
                            width: 50,
                            height: 50,
                          ),
                          heightBox(10),
                          Text(
                            t.lang == 'en'
                                ? AppText.takephotoEn
                                : AppText.takephotoAr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  CustomButton(
                    text: t.lang == 'en' ? AppText.nextEn : AppText.nextAr,
                    onTap: () async {
                      // Get.put(BottomBarBackend()).updateIndex(11);
                      controller.isLoading.value = true;
                      await controller.fetchProfileData().then(
                        (value) async {
                          if (value) {
                            ProfileModel model =
                                Get.put(ProfileBackend()).model!;
                            await Get.put(SubscriptionBackend())
                                .fetchSubscriptionData(model.subscriptionId);
                            controller.isLoading.value = false;
                            Get.offAll(() => SplashScreen());
                          } else {
                            controller.isLoading.value = false;
                          }
                        },
                      );
                    },
                  ),
                  Gap(20),
                  GestureDetector(
                    onTap: () async {
                      controller.isLoading.value = true;
                      await controller.fetchProfileData().then(
                        (value) async {
                          if (value) {
                            ProfileModel model =
                                Get.put(ProfileBackend()).model!;
                            await Get.put(SubscriptionBackend())
                                .fetchSubscriptionData(model.subscriptionId);
                            controller.isLoading.value = false;
                            Get.offAll(() => SplashScreen());
                          } else {
                            controller.isLoading.value = false;
                          }
                        },
                      );
                    },
                    child: Shimmer.fromColors(
                      baseColor: AppColor.greenColor,
                      highlightColor: Colors.grey[100]!,
                      child: Text(
                        'Skip Now >>',
                        style: TextStyle(color: AppColor.greenColor),
                      ),
                    ),
                  ),
                  heightBox(50),
                ],
              ),
            ),
            Obx(
              () => controller.isLoading.value
                  ? Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      )),
    );
  }
}
