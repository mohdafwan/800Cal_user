// import 'dart:developer';

// import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
// import 'package:eight_hundred_cal/backend/program/program_backend.dart';
// import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
// import 'package:eight_hundred_cal/screens/guestmode/guest_dialog.dart';
// import 'package:eight_hundred_cal/screens/home/home_screen.dart';
// import 'package:eight_hundred_cal/services/storage_service.dart';
// import 'package:eight_hundred_cal/utils/app_text.dart';
// import 'package:eight_hundred_cal/utils/db_keys.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';

// import '../../../utils/colors.dart';
// import '../../../utils/constants.dart';
// import '../../../widgets/program_card.dart';

// class HomeScreenProgramWidget extends StatelessWidget {
//   const HomeScreenProgramWidget({
//     super.key,
//   });
//   Future<bool> _isAccessTokenAvailable() async {
//     String? token = await StorageService().read(DbKeys.authToken);
//     return token != null && token.isNotEmpty;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Get.put(ProgramBackend()).fetchAllPrograms();
//     var c = Get.put(TranslatorBackend());
//     void _handleViewMoreClick() async {
//       if (await _isAccessTokenAvailable()) {
//         Get.put(BottomBarBackend()).updateIndex(1);
//       } else {
//         Get.dialog(GuestDialog());
//       }
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               c.lang == 'en' ? AppText.programsEn : AppText.programsAr,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: AppColor.whiteColor,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             InkWell(
//               onTap: _handleViewMoreClick,
//               // onTap: () {
//               //   Get.put(BottomBarBackend()).updateIndex(1);
//               // },
//               child: Text(
//                 c.lang == 'en' ? AppText.viewMoreEn : AppText.viewMoreAr,
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
//           height: height(context) * .26,
//           child: GetBuilder<ProgramBackend>(builder: (controller) {
//             log(controller.programList.toString());
//             return ListView.separated(
//               itemCount: controller.programList.length,
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 return ProgramsCard(
//                   model: controller.programList[index],
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
import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/program/program_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/guestmode/guest_dialog.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../services/storage_service.dart';
import '../../../utils/db_keys.dart';
import '../../../widgets/program_card.dart';

class HomeScreenProgramWidget extends StatefulWidget {
  const HomeScreenProgramWidget({
    super.key,
  });

  @override
  State<HomeScreenProgramWidget> createState() =>
      _HomeScreenProgramWidgetState();
}

class _HomeScreenProgramWidgetState extends State<HomeScreenProgramWidget> {
  late ProgramBackend programBackend;
  bool _hasFetchedData = false;
  @override
  void initState() {
    super.initState();
    programBackend = Get.put(ProgramBackend());
    _fetchData();
  }

  void _fetchData() async {
    if (!_hasFetchedData) {
      await programBackend.fetchAllPrograms();
      setState(() {
        _hasFetchedData = true;
      });
    }
  }

  Future<bool> _isAccessTokenAvailable() async {
    String? token = await StorageService().read(DbKeys.authToken);
    return token != null && token.isNotEmpty;
  }

  void _handleViewMoreClick() async {
    if (await _isAccessTokenAvailable()) {
      Get.put(BottomBarBackend()).updateIndex(1);
    } else {
      Get.dialog(GuestDialog());
    }
  }

  @override
  Widget build(BuildContext context) {
    // var programBackend = Get.put(ProgramBackend());
    // programBackend.fetchAllPrograms();
    var c = Get.put(TranslatorBackend());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              c.lang == 'en' ? AppText.programsEn : AppText.programsAr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              onTap: _handleViewMoreClick,
              child: Text(
                c.lang == 'en' ? AppText.viewMoreEn : AppText.viewMoreAr,
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
          height: height(context) * .26,
          child: Obx(() {
            if (programBackend.isLoading.value && !_hasFetchedData) {
              return Center(
                child: SpinKitThreeInOut(
                  color: AppColor.greenColor,
                ),
              );
              // return Skeletonizer(
              //   enabled: programBackend.isLoading.value,
              //   child: ListView.separated(
              //     itemCount: 2,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         width: 180,
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 30, vertical: 28),
              //         clipBehavior: Clip.antiAlias,
              //         decoration: ShapeDecoration(
              //           color: AppColor.inputBoxBGColor,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(15),
              //           ),
              //         ),
              //       );
              //     },
              //     separatorBuilder: (context, index) => widthBox(18),
              //   ),
              // );
            } else if (programBackend.programList.isEmpty) {
              return Center(
                child: Text(
                  c.lang == 'en'
                      ? "No programs found"
                      : "لم يتم العثور على برامج",
                  style: TextStyle(color: AppColor.whiteColor),
                ),
              );
            } else {
              return ListView.separated(
                itemCount: programBackend.programList.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ProgramsCard(
                    model: programBackend.programList[index],
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
