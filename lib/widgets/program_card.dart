import 'dart:developer';

import 'package:eight_hundred_cal/model/program/program_model.dart';
import 'package:eight_hundred_cal/screens/login/login_screen.dart';
import 'package:eight_hundred_cal/screens/subscription/program_details_page.dart';
import 'package:eight_hundred_cal/services/storage_service.dart';
import 'package:eight_hundred_cal/utils/db_keys.dart';
import 'package:eight_hundred_cal/widgets/subscription_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../backend/bottom_bar/bottom_bar_backend.dart';
import '../screens/guestmode/guest_dialog.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class ProgramsCard extends StatelessWidget {
  final ProgramModel model;
  const ProgramsCard({
    super.key,
    required this.model,
  });
  Future<bool> _isAccessTokenAvailable() async {
    String? token = await StorageService().read(DbKeys.authToken);
    return token != null && token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      Get.put(BottomBarBackend()).updateIndex(0);
      return Future.value(false);
    }

    void _handleProgramTap() async {
      if (await _isAccessTokenAvailable()) {
        subscriptionModel.program = model;
        showSubsriptionPopup(context, model.id);
      } else {
        Get.dialog(
          GuestDialog(),
        );
      }
    }

    void _handleImageTap() async {
      if (await _isAccessTokenAvailable()) {
        Get.put(BottomBarBackend()).updateIndex(15);
        programModel = model;
      } else {
        Get.dialog(
          //barrierDismissible: false,
          GuestDialog(),
        );
      }
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: InkWell(
        onTap: _handleProgramTap,
        // onTap: () {
        //   subscriptionModel.program = model;
        //   showSubsriptionPopup(context, model.id);
        // },
        child: Container(
          width: 180,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 28),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: AppColor.inputBoxBGColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Column(children: [
            Flexible(
              flex: 2,
              child: InkWell(
                onTap: _handleImageTap,
                // onTap: () {
                //   Get.put(BottomBarBackend()).updateIndex(15);
                //   programModel = model;
                // },
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      model.logo,
                      width: 180,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 1,
              child: Container(
                child: Text(
                  model.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ]),
          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     InkWell(
          //       onTap: () {
          //         Get.put(BottomBarBackend()).updateIndex(15);
          //         programModel = model;
          //       },
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.circular(10),
          //         child: Image.network(
          //           model.logo,
          //           width: 90,
          //           height: 90,
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //     ),
          //     heightBox(15),
          //     Flexible(
          //       flex: 1,
          //       fit: FlexFit.tight,
          //       child: Text(
          //         model.name,
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           color: AppColor.whiteColor,
          //           fontSize: 16,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //     )
          //   ],
          // ),
        ),
      ),
    );
  }
}
