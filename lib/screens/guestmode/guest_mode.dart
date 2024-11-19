// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:developer';

// import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
// import 'package:eight_hundred_cal/backend/profile/profile_backend.dart';
// import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
// import 'package:eight_hundred_cal/backend/theme/theme_backend.dart';
// import 'package:eight_hundred_cal/model/profile/profile_model.dart';
// import 'package:eight_hundred_cal/screens/bottom_bar/widgets/custom_bottom_bar.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../utils/colors.dart';
// import '../../utils/constants.dart';

// class BottomBarScreen extends StatelessWidget {
//   BottomBarScreen({
//     super.key,
//   });

//   ProfileModel model = Get.put(ProfileBackend()).model!;

//   @override
//   Widget build(BuildContext context) {
//     log('Profile Model: $model');
//     return SafeArea(
//         child: Scaffold(
//       backgroundColor: AppColor.pimaryColor,
//       // bottomNavigationBar: CustomBottomBar(),
//       body: Stack(
//         children: [
//           GetBuilder<BottomBarBackend>(
//             init: BottomBarBackend(),
//             builder: (controller) {
//               return model.isSubscribed ||
//                       !DateTime.now().isAfter(
//                           DateTime.fromMillisecondsSinceEpoch(
//                               model.subscriptionEndDate))
//                   ? subWidgetList[controller.gIndex]
//                   : widgetList[controller.gIndex];
//             },
//           ),
//           GetBuilder<ThemeBackend>(
//               init: ThemeBackend(),
//               builder: (controller) {
//                 return Align(
//                     alignment: Alignment.bottomCenter,
//                     child: CustomBottomBar());
//               }),
//         ],
//       ),
//     ));
//   }
// }
import 'dart:developer';

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/profile/profile_backend.dart';
import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/backend/theme/theme_backend.dart';
import 'package:eight_hundred_cal/model/profile/profile_model.dart';
import 'package:eight_hundred_cal/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:eight_hundred_cal/screens/bottom_bar/widgets/custom_bottom_bar.dart';
import 'package:eight_hundred_cal/screens/guestmode/guest_home.dart';
import 'package:eight_hundred_cal/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class GuestScreen extends StatelessWidget {
  GuestScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProfileBackend profileBackend = Get.put(ProfileBackend());
    BottomBarBackend bottomBarBackend = Get.put(BottomBarBackend());
    ThemeBackend themeBackend = Get.put(ThemeBackend());

    ProfileModel? model = profileBackend.model;
    log('gest:$model');
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.pimaryColor,
        body: model == null
            ? GuestHomeScreen()
            : Stack(
                children: [
                  GetBuilder<BottomBarBackend>(
                    builder: (controller) {
                      return model.isSubscribed ||
                              !DateTime.now().isAfter(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      model.subscriptionEndDate))
                          ? subWidgetList[controller.gIndex]
                          : widgetList[controller.gIndex];
                    },
                  ),
                  // GetBuilder<ThemeBackend>(
                  //   builder: (controller) {
                  //     return Align(
                  //       alignment: Alignment.bottomCenter,
                  //       child: CustomBottomBar(),
                  //     );
                  //   },
                  // ),
                ],
              ),
      ),
    );
  }
}
