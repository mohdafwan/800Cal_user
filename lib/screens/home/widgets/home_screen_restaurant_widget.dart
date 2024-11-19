// import 'dart:developer';

// import 'package:eight_hundred_cal/backend/restaurant/restaurant_backend.dart';
// import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
// import 'package:eight_hundred_cal/screens/guestmode/guest_dialog.dart';
// import 'package:eight_hundred_cal/services/storage_service.dart';
// import 'package:eight_hundred_cal/utils/app_text.dart';
// import 'package:eight_hundred_cal/utils/db_keys.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../backend/bottom_bar/bottom_bar_backend.dart';
// import '../../../utils/colors.dart';
// import '../../../utils/constants.dart';
// import '../../../widgets/restaurant_card.dart';
// import '../restaurant_detail_page.dart';

// class HomeScreenRestaurantWidget extends StatelessWidget {
//   const HomeScreenRestaurantWidget({
//     super.key,
//   });
//   Future<bool> _isAccesstokenAvailable() async {
//     String? token = await StorageService().read(DbKeys.authToken);
//     return token != null && token.isNotEmpty;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Get.put(RestaurantBackend()).fetchAllRestaurants();
//     var c = Get.put(TranslatorBackend());
//     void _handleonviewmoretap() async {
//       if (await _isAccesstokenAvailable()) {
//         Get.put(BottomBarBackend()).updateIndex(5);
//       } else {
//         Get.dialog(
//           GuestDialog(),
//         );
//       }
//     }

//     // void _handleonResturant() async {
//     //   if (await _isAccesstokenAvailable()) {
//     //     Get.put(BottomBarBackend()).updateIndex(8);
//     //     restaurantId = controller.restaurants[index].id;
//     //   } else {
//     //     Get.dialog(
//     //       GuestDialog(),
//     //     );
//     //   }
//     // }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               c.lang == 'en'
//                   ? AppText.ourRestaurantsEn
//                   : AppText.ourRestaurantsAr,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: AppColor.whiteColor,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             InkWell(
//               // onTap: () {
//               //   Get.put(BottomBarBackend()).updateIndex(5);
//               // },
//               onTap: _handleonviewmoretap,
//               child: Text(
//                 c.lang == "en" ? AppText.viewMoreEn : AppText.viewMoreAr,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: AppColor.secondaryColor,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             )
//           ],
//         ),
//         heightBox(15),
//         SizedBox(
//           height: 196,
//           child: GetBuilder<RestaurantBackend>(builder: (controller) {
//             log(controller.restaurants.toString());
//             return ListView.separated(
//               //itemCount: controller.restaurants.length,
//               itemCount: controller.restaurants.length < 5
//                   ? controller.restaurants.length
//                   : 5,
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   // onTap: () {
//                   //   Get.put(BottomBarBackend()).updateIndex(8);
//                   //   restaurantId = controller.restaurants[index].id;
//                   // },
//                   onTap: () async {
//                     if (await _isAccesstokenAvailable()) {
//                       Get.put(BottomBarBackend()).updateIndex(8);
//                       restaurantId = controller.restaurants[index].id;
//                     } else {
//                       Get.dialog(
//                         GuestDialog(),
//                       );
//                     }
//                   },
//                   child: RestaurantCard(
//                     model: controller.restaurants[index],
//                   ),
//                 );
//               },
//               separatorBuilder: (context, index) => widthBox(18),
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }
import 'dart:developer';

import 'package:eight_hundred_cal/backend/restaurant/restaurant_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/guestmode/guest_dialog.dart';
import 'package:eight_hundred_cal/services/storage_service.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/db_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../backend/bottom_bar/bottom_bar_backend.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../widgets/restaurant_card.dart';
import '../restaurant_detail_page.dart';

class HomeScreenRestaurantWidget extends StatelessWidget {
  const HomeScreenRestaurantWidget({
    super.key,
  });

  Future<bool> _isAccesstokenAvailable() async {
    String? token = await StorageService().read(DbKeys.authToken);
    return token != null && token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RestaurantBackend()).fetchAllRestaurants();
    var c = Get.put(TranslatorBackend());

    void _handleonviewmoretap() async {
      if (await _isAccesstokenAvailable()) {
        Get.put(BottomBarBackend()).updateIndex(5);
      } else {
        Get.dialog(
          GuestDialog(),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              c.lang == 'en'
                  ? AppText.ourRestaurantsEn
                  : AppText.ourRestaurantsAr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              onTap: _handleonviewmoretap,
              child: Text(
                c.lang == "en" ? AppText.viewMoreEn : AppText.viewMoreAr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.secondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
        heightBox(15),
        SizedBox(
          height: 196,
          child: GetBuilder<RestaurantBackend>(builder: (controller) {
            if (controller.restaurants.isEmpty) {
              return Center(
                child: SpinKitThreeInOut(color: AppColor.greenColor),
              );
              // return Skeletonizer(
              //   enabled: controller.restaurants.isEmpty,
              //   child: ListView.separated(
              //     itemCount: 5,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         width: 160,
              //         height: 196,
              //         decoration: BoxDecoration(
              //           color: Colors.grey.shade300,
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //       );
              //     },
              //     separatorBuilder: (context, index) => widthBox(18),
              //   ),
              // );
            } else {
              return ListView.separated(
                itemCount: controller.restaurants.length < 5
                    ? controller.restaurants.length
                    : 5,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      if (await _isAccesstokenAvailable()) {
                        Get.put(BottomBarBackend()).updateIndex(8);
                        restaurantId = controller.restaurants[index].id;
                      } else {
                        Get.dialog(
                          GuestDialog(),
                        );
                      }
                    },
                    child: RestaurantCard(
                      model: controller.restaurants[index],
                    ),
                  );
                },
                separatorBuilder: (context, index) => widthBox(18),
              );
            }
          }),
        ),
      ],
    );
  }
}
