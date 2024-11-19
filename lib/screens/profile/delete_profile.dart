import 'dart:developer';
import 'dart:ui';

import 'package:eight_hundred_cal/backend/deleteprofile/delete_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../backend/translator/translator_backend.dart';
import '../../services/storage_service.dart';
import '../../utils/colors.dart';
import '../../utils/db_keys.dart';

class DeleteProfile extends StatelessWidget {
  const DeleteProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountController accountController = Get.put(AccountController());
    final TranslatorBackend translatorBackend = Get.put(TranslatorBackend());

    return GestureDetector(
      onTap: () {
        if (Theme.of(context).platform == TargetPlatform.iOS) {
          Get.dialog(
            barrierDismissible: false,
            Stack(
              children: [
                CupertinoAlertDialog(
                  title: Text(
                    translatorBackend.lang == 'en'
                        ? 'Are you sure?'
                        : 'هل أنت متأكد؟',
                  ),
                  content: Column(
                    children: [
                      Gap(10),
                      SvgPicture.asset(
                        'assets/images/question.svg',
                        height: 100,
                      ),
                      Gap(10),
                      Text(
                        translatorBackend.lang == 'en'
                            ? 'Do you really want to delete your account? This action cannot be undone.'
                            : 'هل تريد حقًا حذف حسابك؟ لا يمكن التراجع عن هذا الإجراء.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: Text(translatorBackend.lang == 'en' ? 'No' : 'لا'),
                      onPressed: () {
                        Get.back();
                      },
                      isDefaultAction: true,
                    ),
                    CupertinoDialogAction(
                      child: Obx(() {
                        return Text(
                          accountController.isDeleting.value
                              ? translatorBackend.lang == 'en'
                                  ? 'Deleting...'
                                  : 'جاري الحذف...'
                              : translatorBackend.lang == 'en'
                                  ? 'Yes'
                                  : 'نعم',
                          style: TextStyle(color: Colors.red),
                        );
                      }),
                      onPressed: accountController.isDeleting.value
                          ? null
                          : () async {
                              try {
                                String accessToken = await StorageService()
                                    .read(DbKeys.authToken);

                                await accountController
                                    .deleteAccount(accessToken);

                                if (accountController.deleteSuccess.value) {
                                  Get.back();
                                  Get.snackbar(
                                    translatorBackend.lang == 'en'
                                        ? 'Success'
                                        : 'تم بنجاح',
                                    translatorBackend.lang == 'en'
                                        ? 'Account deleted successfully.'
                                        : 'تم حذف الحساب بنجاح.',
                                    backgroundColor: AppColor.whiteColor,
                                  );
                                } else {
                                  Get.snackbar(
                                    translatorBackend.lang == 'en'
                                        ? 'Error'
                                        : 'خطأ',
                                    translatorBackend.lang == 'en'
                                        ? 'Failed to delete account.'
                                        : 'فشل في حذف الحساب.',
                                  );
                                }
                              } catch (e) {
                                log("Error retrieving access token: $e");
                                Get.snackbar(
                                  translatorBackend.lang == 'en'
                                      ? 'Error'
                                      : 'خطأ',
                                  translatorBackend.lang == 'en'
                                      ? 'Failed to delete account.'
                                      : 'فشل في حذف الحساب.',
                                );
                              }
                            },
                    ),
                  ],
                ),
                Obx(() {
                  if (accountController.isDeleting.value) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }),
              ],
            ),
          );
        } else {
          Get.dialog(
            barrierDismissible: false,
            Stack(
              children: [
                Dialog(
                  backgroundColor: AppColor.pimaryColor,
                  elevation: 5,
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Gap(10),
                        Flexible(
                          flex: 1,
                          child: SvgPicture.asset(
                            'assets/images/question.svg',
                          ),
                        ),
                        Gap(10),
                        Flexible(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(
                                translatorBackend.lang == 'en'
                                    ? 'Are you sure?'
                                    : 'هل أنت متأكد؟',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                translatorBackend.lang == 'en'
                                    ? 'Do you really want to delete\nYour account? You will not be\n    able to undo this action'
                                    : 'هل تريد حقًا حذف حسابك؟\nلن تتمكن من التراجع عن هذا الإجراء.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 16,
                                ),
                              ),
                              Gap(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                AppColor.pimaryColor),
                                        side: MaterialStateProperty.all(
                                          BorderSide(
                                            color: AppColor.greenShadeColor,
                                            width: 3.0,
                                          ),
                                        ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        translatorBackend.lang == 'en'
                                            ? 'No'
                                            : 'لا',
                                        style: TextStyle(
                                          color: AppColor.greenShadeColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gap(20),
                                  SizedBox(
                                    width: 120,
                                    child: Obx(() {
                                      return OutlinedButton(
                                        onPressed: accountController
                                                .isDeleting.value
                                            ? null
                                            : () async {
                                                try {
                                                  String accessToken =
                                                      await StorageService()
                                                          .read(
                                                              DbKeys.authToken);

                                                  await accountController
                                                      .deleteAccount(
                                                          accessToken);

                                                  if (accountController
                                                      .deleteSuccess.value) {
                                                    Get.back();
                                                    Get.snackbar(
                                                      translatorBackend.lang ==
                                                              'en'
                                                          ? 'Success'
                                                          : 'تم بنجاح',
                                                      translatorBackend.lang ==
                                                              'en'
                                                          ? 'Account deleted successfully.'
                                                          : 'تم حذف الحساب بنجاح.',
                                                      backgroundColor:
                                                          AppColor.whiteColor,
                                                    );
                                                  } else {
                                                    Get.snackbar(
                                                      translatorBackend.lang ==
                                                              'en'
                                                          ? 'Error'
                                                          : 'خطأ',
                                                      translatorBackend.lang ==
                                                              'en'
                                                          ? 'Failed to delete account.'
                                                          : 'فشل في حذف الحساب.',
                                                    );
                                                  }
                                                } catch (e) {
                                                  log("Error retrieving access token: $e");
                                                  Get.snackbar(
                                                    translatorBackend.lang ==
                                                            'en'
                                                        ? 'Error'
                                                        : 'خطأ',
                                                    translatorBackend.lang ==
                                                            'en'
                                                        ? 'Failed to delete account.'
                                                        : 'فشل في حذف الحساب.',
                                                  );
                                                }
                                              },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.red),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          translatorBackend.lang == 'en'
                                              ? 'Yes'
                                              : 'نعم',
                                          style: TextStyle(
                                            color: AppColor.whiteColor,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(() {
                  if (accountController.isDeleting.value) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.whiteColor,
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }),
              ],
            ),
          );
        }
      },
      child: Row(
        children: [
          Text(
            translatorBackend.lang == 'en' ? 'Delete Profile' : 'حذف الحساب',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
