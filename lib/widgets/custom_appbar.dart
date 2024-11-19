import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/screens/guestmode/guest_dialog.dart';
import 'package:eight_hundred_cal/screens/home/home_screen.dart';
import 'package:eight_hundred_cal/services/storage_service.dart';
import 'package:eight_hundred_cal/utils/db_keys.dart';
import 'package:eight_hundred_cal/utils/text_constant.dart';
import 'package:eight_hundred_cal/widgets/login_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';

class CustomAppBar extends StatelessWidget {
  final String text;
  bool showProfile;
  CustomAppBar({
    super.key,
    required this.text,
    this.showProfile = true,
  });
  Future<bool> _isAceessTokenAvailable() async {
    String? token = await StorageService().read(DbKeys.authToken);
    return token != null && token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        // IconButton(
        //   onPressed: () {
        //     Get.to(HomeScreen());
        //   },
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: Colors.white,
        //   ),
        // ),
        Flexible(
          child: Text(text, style: appBarStyle()),
        ),
        showProfile
            ? InkWell(
                // onTap: () async {
                //   String token = await StorageService().read(DbKeys.authToken);
                //   if (token != null) {
                //     Get.put(BottomBarBackend()).updateIndex(10);
                //   } else {
                //     showLoginDialog(context);
                //   }
                // },
                onTap: () async {
                  bool isTokenAvailable = await _isAceessTokenAvailable();
                  if (isTokenAvailable) {
                    Get.put(BottomBarBackend()).updateIndex(10);
                  } else {
                    // showLoginDialog(context);
                    Get.dialog(
                      GuestDialog(),
                    );
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: AppColor.inputBoxBGColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      color: AppColor.secondaryColor,
                      size: 32,
                    ),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
