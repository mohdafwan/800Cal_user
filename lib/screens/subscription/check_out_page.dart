// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
// import 'package:eight_hundred_cal/backend/order/order_backend.dart';
// import 'package:eight_hundred_cal/backend/otp/otp_backend.dart';
// import 'package:eight_hundred_cal/backend/payments/payment_gateway.dart';
// import 'package:eight_hundred_cal/backend/profile/profile_backend.dart';
// import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
// import 'package:eight_hundred_cal/screens/subscription/otp_page.dart';
// import 'package:eight_hundred_cal/utils/app_text.dart';
// import 'package:eight_hundred_cal/utils/colors.dart';
// import 'package:eight_hundred_cal/utils/constants.dart';
// import 'package:eight_hundred_cal/widgets/custom_button.dart';
// import 'package:eight_hundred_cal/widgets/login_dialog.dart';
// import 'package:eight_hundred_cal/widgets/show_loader_dialog.dart';
// import 'package:eight_hundred_cal/widgets/text_box_with_heading.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';

// import '../../services/storage_service.dart';
// import '../../utils/db_keys.dart';

// class CheckOutPage extends StatefulWidget {
//   const CheckOutPage({super.key});

//   @override
//   State<CheckOutPage> createState() => _CheckOutPageState();
// }

// class _CheckOutPageState extends State<CheckOutPage> {
//   final emailController = TextEditingController();
//   final phoneNumberController = TextEditingController();
//   final nameController = TextEditingController();
//   final districtController = TextEditingController();
//   final areaController = TextEditingController();
//   final blockController = TextEditingController();
//   final streetController = TextEditingController();
//   final houseNoController = TextEditingController();
//   final nicknameController = TextEditingController();
//   final noteController = TextEditingController();
//   bool acceptTerms = false;

//   @override
//   Widget build(BuildContext context) {
//     var c = Get.put(TranslatorBackend());
//     Future<bool> _onWillPop() {
//       Get.put(BottomBarBackend()).updateIndex(13);
//       return Future.value(false);
//     }

//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: SafeArea(
//           child: Scaffold(
//         backgroundColor: AppColor.pimaryColor,
//         body: GetBuilder<OrderBackend>(
//             init: OrderBackend(),
//             builder: (controller) {
//               return SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
//                       .copyWith(top: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: Image.asset(
//                           "assets/icons/logo.png",
//                           width: 90,
//                           height: 90,
//                         ),
//                       ),
//                       heightBox(20),
//                       CheckoutOrderSummaryCard(),
//                       heightBox(20),
//                       TextBoxWithHeading(
//                           inputType: TextInputType.emailAddress,
//                           controller: emailController,
//                           heading: c.lang == 'en'
//                               ? AppText.emailEn
//                               : AppText.emailAr),
//                       heightBox(20),
//                       TextBoxWithHeading(
//                           inputFormatters: LengthLimitingTextInputFormatter(8),
//                           inputType: TextInputType.phone,
//                           controller: phoneNumberController,
//                           heading: c.lang == 'en'
//                               ? AppText.phoneNumberEn
//                               : AppText.phoneNumberAr),
//                       heightBox(20),
//                       TextBoxWithHeading(
//                           controller: nameController,
//                           heading:
//                               c.lang == 'en' ? AppText.nameEn : AppText.nameAr),
//                       heightBox(20),
//                       Text(
//                         c.lang == 'en' ? AppText.addressEn : AppText.addressAr,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: AppColor.whiteColor,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       heightBox(10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(
//                             width: width(context) * .42,
//                             child: TextBoxWithHeading(
//                               heading: c.lang == 'en'
//                                   ? AppText.houseNoEn
//                                   : AppText.houseNoAr,
//                               controller: houseNoController,
//                             ),
//                           ),
//                           SizedBox(
//                             width: width(context) * .42,
//                             child: TextBoxWithHeading(
//                               heading: c.lang == 'en'
//                                   ? AppText.blockEn
//                                   : AppText.blockAr,
//                               controller: blockController,
//                             ),
//                           ),
//                         ],
//                       ),
//                       heightBox(10),
//                       TextBoxWithHeading(
//                         heading: c.lang == 'en'
//                             ? AppText.streetEn
//                             : AppText.streetAr,
//                         controller: streetController,
//                       ),
//                       heightBox(10),
//                       TextBoxWithHeading(
//                         heading:
//                             c.lang == 'en' ? AppText.areaEn : AppText.areaAr,
//                         controller: areaController,
//                       ),
//                       heightBox(10),
//                       TextBoxWithHeading(
//                         heading: c.lang == 'en'
//                             ? AppText.districtEn
//                             : AppText.districtAr,
//                         controller: districtController,
//                       ),
//                       heightBox(10),
//                       TextBoxWithHeading(
//                         heading: c.lang == 'en'
//                             ? AppText.nicknameEn
//                             : AppText.nicknameAr,
//                         controller: nicknameController,
//                       ),
//                       heightBox(10),
//                       TextBoxWithHeading(
//                         heading:
//                             c.lang == 'en' ? AppText.noteEn : AppText.noteAr,
//                         controller: noteController,
//                       ),

//                       Row(
//                         children: [
//                           Checkbox(
//                             value: acceptTerms,
//                             onChanged: (value) {
//                               setState(() {
//                                 acceptTerms = value!;
//                               });
//                             },
//                             fillColor: MaterialStateProperty.all(
//                                 AppColor.secondaryColor),
//                             activeColor: AppColor.secondaryColor,
//                           ),
//                           Text(
//                             c.lang == 'en'
//                                 ? AppText.iAcceptTermsAndConditionsEn
//                                 : AppText.iAcceptTermsAndConditionsAr,
//                             style: TextStyle(color: AppColor.whiteColor),
//                           ),
//                         ],
//                       ),
//                       // heightBox(20),
//                       CustomButton(
//                         text: c.lang == 'en'
//                             ? AppText.payNowEn
//                             : AppText.payNowAr,
//                         width: width(context),
//                         onTap: () async {
//                           String userId =
//                               await StorageService().read(DbKeys.authToken);
//                           if (userId != null) {
//                             if (emailController.text.isNotEmpty &&
//                                 phoneNumberController.text.isNotEmpty &&
//                                 nameController.text.isNotEmpty &&
//                                 districtController.text.isNotEmpty &&
//                                 areaController.text.isNotEmpty &&
//                                 blockController.text.isNotEmpty &&
//                                 streetController.text.isNotEmpty &&
//                                 houseNoController.text.isNotEmpty &&
//                                 noteController.text.isNotEmpty &&
//                                 nicknameController.text.isNotEmpty &&
//                                 acceptTerms) {
//                               Map data = {
//                                 'startDate': subscriptionModel
//                                     .startDate.millisecondsSinceEpoch,
//                                 'endDate': subscriptionModel
//                                     .endDate.millisecondsSinceEpoch,
//                                 'duration': (int.parse(subscriptionModel
//                                             .duration
//                                             .split(" ")[0]) *
//                                         7)
//                                     .toInt(),
//                                 'includeFridays':
//                                     subscriptionModel.includeFriday,
//                                 'discount': controller.discountId != ""
//                                     ? controller.discountId
//                                     : null,
//                                 'subtotal': subscriptionModel
//                                             .groupRestaurantCategory ==
//                                         'Silver'
//                                     ? subscriptionModel.meal.silverprice
//                                     : subscriptionModel
//                                                 .groupRestaurantCategory ==
//                                             'Gold'
//                                         ? subscriptionModel.meal.goldprice
//                                         : subscriptionModel.meal.platinumprice,
//                                 'shippingcost': 0,
//                                 'total': (subscriptionModel
//                                                 .groupRestaurantCategory ==
//                                             'Silver'
//                                         ? subscriptionModel.meal.silverprice
//                                         : subscriptionModel
//                                                     .groupRestaurantCategory ==
//                                                 'Gold'
//                                             ? subscriptionModel.meal.goldprice
//                                             : subscriptionModel
//                                                 .meal.platinumprice) -
//                                     controller.discountAmount,
//                                 'category': subscriptionModel
//                                     .groupRestaurantCategory
//                                     .toLowerCase(),
//                                 'choosenprice': subscriptionModel
//                                             .groupRestaurantCategory ==
//                                         'Silver'
//                                     ? subscriptionModel.meal.silverprice
//                                     : subscriptionModel
//                                                 .groupRestaurantCategory ==
//                                             'Gold'
//                                         ? subscriptionModel.meal.goldprice
//                                         : subscriptionModel.meal.platinumprice,
//                                 'listofrestaurants': subscriptionModel
//                                     .restaurant
//                                     .map((e) => e.restaurant.id)
//                                     .toList(),
//                                 'email': emailController.text,
//                                 'phone': phoneNumberController.text,
//                                 'name': nameController.text,
//                                 'address':
//                                     "${nicknameController.text}, ${houseNoController.text}-${blockController.text}, ${streetController.text}, ${areaController.text}, ${districtController.text}, ${noteController.text}",
//                                 // 'order_status': "processing",
//                                 'program': subscriptionModel.program.id,
//                                 'meals': subscriptionModel.meal.id,
//                               };
//                               // Get.put(PaymentGateway())
//                               //     .orderPayments(context, data);
//                               Get.put(OtpBackend())
//                                   .sendOtpSms(phoneNumberController.text);
//                               Get.to(() => OtpPageScreen(
//                                   phoneNumber: phoneNumberController.text,
//                                   data: data));
//                               // Map<String, dynamic> data2 = {
//                               //   'TranID': [
//                               //     'Trx233424d',
//                               //   ],
//                               // };
//                               // Get.put(PaymentGateway()).successOrder(
//                               //   context,
//                               //   data,
//                               //   data2,
//                               // );
//                             } else {
//                               Fluttertoast.showToast(
//                                   msg: "Please fill all fields");
//                             }
//                           } else {
//                             showLoginDialog(context);
//                           }
//                           // Get.to(() => PaymentFailedPage());
//                         },
//                       ),
//                       heightBox(120),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//       )),
//     );
//   }
// }
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/order/order_backend.dart';
import 'package:eight_hundred_cal/backend/otp/otp_backend.dart';
import 'package:eight_hundred_cal/backend/payments/payment_gateway.dart';
import 'package:eight_hundred_cal/backend/profile/profile_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/subscription/otp_page.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:eight_hundred_cal/widgets/ios_custom_appbar.dart';
import 'package:eight_hundred_cal/widgets/login_dialog.dart';
import 'package:eight_hundred_cal/widgets/show_loader_dialog.dart';
import 'package:eight_hundred_cal/widgets/text_box_with_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../services/storage_service.dart';
import '../../utils/db_keys.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final nameController = TextEditingController();
  final districtController = TextEditingController();
  final areaController = TextEditingController();
  final blockController = TextEditingController();
  final streetController = TextEditingController();
  final houseNoController = TextEditingController();
  final nicknameController = TextEditingController();
  final noteController = TextEditingController();
  bool acceptTerms = false;

  // Error flags for validation
  bool emailError = false;
  bool phoneError = false;
  bool nameError = false;
  bool districtError = false;
  bool areaError = false;
  bool blockError = false;
  bool streetError = false;
  bool houseNoError = false;
  bool nicknameError = false;
  bool noteError = false;

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    Future<bool> _onWillPop() {
      Get.put(BottomBarBackend()).updateIndex(13);
      return Future.value(false);
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.put(BottomBarBackend()).updateIndex(13);
                  },
                  icon: Platform.isIOS
                      ? Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: AppColor.whiteColor,
                          size: 30,
                        )
                      : Icon(Icons.arrow_back,
                          color: AppColor.whiteColor, size: 30),
                ),
                Gap(100),
                Image.asset(
                  "assets/icons/logo.png",
                  width: 90,
                  height: 90,
                ),
              ],
            ),
          ),
          backgroundColor: AppColor.pimaryColor,
          body: GetBuilder<OrderBackend>(
            init: OrderBackend(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
                      .copyWith(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Center(
                      //   child: Image.asset(
                      //     "assets/icons/logo.png",
                      //     width: 90,
                      //     height: 90,
                      //   ),
                      // ),
                      heightBox(20),
                      CheckoutOrderSummaryCard(),
                      heightBox(20),
                      TextBoxWithHeading(
                        inputType: TextInputType.emailAddress,
                        controller: emailController,
                        heading:
                            c.lang == 'en' ? AppText.emailEn : AppText.emailAr,
                        error: emailError,
                      ),
                      heightBox(20),
                      TextBoxWithHeading(
                        inputFormatters: LengthLimitingTextInputFormatter(8),
                        inputType: TextInputType.phone,
                        controller: phoneNumberController,
                        heading: c.lang == 'en'
                            ? AppText.phoneNumberEn
                            : AppText.phoneNumberAr,
                        error: phoneError,
                      ),
                      heightBox(20),
                      TextBoxWithHeading(
                        controller: nameController,
                        heading:
                            c.lang == 'en' ? AppText.nameEn : AppText.nameAr,
                        error: nameError,
                      ),
                      heightBox(20),
                      Text(
                        c.lang == 'en' ? AppText.addressEn : AppText.addressAr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      heightBox(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width(context) * .42,
                            child: TextBoxWithHeading(
                              heading: c.lang == 'en'
                                  ? AppText.houseNoEn
                                  : AppText.houseNoAr,
                              controller: houseNoController,
                              error: houseNoError,
                            ),
                          ),
                          SizedBox(
                            width: width(context) * .42,
                            child: TextBoxWithHeading(
                              heading: c.lang == 'en'
                                  ? AppText.blockEn
                                  : AppText.blockAr,
                              controller: blockController,
                              error: blockError,
                            ),
                          ),
                        ],
                      ),
                      heightBox(10),
                      TextBoxWithHeading(
                        heading: c.lang == 'en'
                            ? AppText.streetEn
                            : AppText.streetAr,
                        controller: streetController,
                        error: streetError,
                      ),
                      heightBox(10),
                      TextBoxWithHeading(
                        heading:
                            c.lang == 'en' ? AppText.areaEn : AppText.areaAr,
                        controller: areaController,
                        error: areaError,
                      ),
                      heightBox(10),
                      TextBoxWithHeading(
                        heading: c.lang == 'en'
                            ? AppText.districtEn
                            : AppText.districtAr,
                        controller: districtController,
                        error: districtError,
                      ),
                      heightBox(10),
                      TextBoxWithHeading(
                        heading: c.lang == 'en'
                            ? AppText.nicknameEn
                            : AppText.nicknameAr,
                        controller: nicknameController,
                        error: nicknameError,
                      ),
                      heightBox(10),
                      TextBoxWithHeading(
                        heading:
                            c.lang == 'en' ? AppText.noteEn : AppText.noteAr,
                        controller: noteController,
                        error: noteError,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: acceptTerms,
                            onChanged: (value) {
                              setState(() {
                                acceptTerms = value!;
                              });
                            },
                            fillColor: MaterialStateProperty.all(
                                AppColor.secondaryColor),
                            activeColor: AppColor.secondaryColor,
                          ),
                          Text(
                            c.lang == 'en'
                                ? AppText.iAcceptTermsAndConditionsEn
                                : AppText.iAcceptTermsAndConditionsAr,
                            style: TextStyle(color: AppColor.whiteColor),
                          ),
                        ],
                      ),
                      CustomButton(
                        text: c.lang == 'en'
                            ? AppText.payNowEn
                            : AppText.payNowAr,
                        width: width(context),
                        onTap: () async {
                          setState(() {
                            emailError = emailController.text.isEmpty;
                            phoneError = phoneNumberController.text.isEmpty;
                            nameError = nameController.text.isEmpty;
                            districtError = districtController.text.isEmpty;
                            areaError = areaController.text.isEmpty;
                            blockError = blockController.text.isEmpty;
                            streetError = streetController.text.isEmpty;
                            houseNoError = houseNoController.text.isEmpty;
                            nicknameError = nicknameController.text.isEmpty;
                            noteError = noteController.text.isEmpty;
                          });

                          String userId =
                              await StorageService().read(DbKeys.authToken);
                          if (userId != null) {
                            if (!emailError &&
                                !phoneError &&
                                !nameError &&
                                !districtError &&
                                !areaError &&
                                !blockError &&
                                !streetError &&
                                !houseNoError &&
                                !nicknameError &&
                                !noteError &&
                                acceptTerms) {
                              Map data = {
                                'startDate': subscriptionModel
                                    .startDate.millisecondsSinceEpoch,
                                'endDate': subscriptionModel
                                    .endDate.millisecondsSinceEpoch,
                                'duration': (int.parse(subscriptionModel
                                            .duration
                                            .split(" ")[0]) *
                                        7)
                                    .toInt(),
                                'includeFridays':
                                    subscriptionModel.includeFriday,
                                'discount': controller.discountId != ""
                                    ? controller.discountId
                                    : null,
                                'subtotal': subscriptionModel
                                            .groupRestaurantCategory ==
                                        'Silver'
                                    ? subscriptionModel.meal.silverprice
                                    : subscriptionModel
                                                .groupRestaurantCategory ==
                                            'Gold'
                                        ? subscriptionModel.meal.goldprice
                                        : subscriptionModel.meal.platinumprice,
                                'shippingcost': 0,
                                'total': (subscriptionModel
                                                .groupRestaurantCategory ==
                                            'Silver'
                                        ? subscriptionModel.meal.silverprice
                                        : subscriptionModel
                                                    .groupRestaurantCategory ==
                                                'Gold'
                                            ? subscriptionModel.meal.goldprice
                                            : subscriptionModel
                                                .meal.platinumprice) -
                                    controller.discountAmount,
                                'category': subscriptionModel
                                    .groupRestaurantCategory
                                    .toLowerCase(),
                                'choosenprice': subscriptionModel
                                            .groupRestaurantCategory ==
                                        'Silver'
                                    ? subscriptionModel.meal.silverprice
                                    : subscriptionModel
                                                .groupRestaurantCategory ==
                                            'Gold'
                                        ? subscriptionModel.meal.goldprice
                                        : subscriptionModel.meal.platinumprice,
                                'listofrestaurants': subscriptionModel
                                    .restaurant
                                    .map((e) => e.restaurant.id)
                                    .toList(),
                                'email': emailController.text,
                                'phone': phoneNumberController.text,
                                'name': nameController.text,
                                'address':
                                    "${nicknameController.text}, ${houseNoController.text}-${blockController.text}, ${streetController.text}, ${areaController.text}, ${districtController.text}, ${noteController.text}",
                                // 'order_status': "processing",
                                'program': subscriptionModel.program.id,
                                'meals': subscriptionModel.meal.id,
                              };
                              Get.put(OtpBackend())
                                  .sendOtpSms(phoneNumberController.text);
                              Get.to(() => OtpPageScreen(
                                  phoneNumber: phoneNumberController.text,
                                  data: data));
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please fill all fields");
                            }
                          } else {
                            showLoginDialog(context);
                          }
                        },
                      ),
                      heightBox(120),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CheckoutPaymentMethodWidget extends StatelessWidget {
  const CheckoutPaymentMethodWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Payment method',
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '+ Add new',
              style: TextStyle(
                color: AppColor.secondaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        heightBox(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CheckoutPaymentCard(isSelected: true),
            CheckoutPaymentCard(isSelected: false),
          ],
        ),
      ],
    );
  }
}

class CheckoutPaymentCard extends StatelessWidget {
  final bool isSelected;
  const CheckoutPaymentCard({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * .43,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.inputBoxBGColor,
        border: Border.all(
            width: 1,
            color:
                isSelected ? AppColor.secondaryColor : AppColor.dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio(
                    value: true,
                    activeColor: AppColor.secondaryColor,
                    groupValue: isSelected,
                    onChanged: (value) {}),
                Text(
                  '**** 8304',
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                children: [
                  Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/RuPay.svg/2560px-RuPay.svg.png",
                    width: 35,
                    fit: BoxFit.fill,
                  ),
                  widthBox(8),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: ShapeDecoration(
                      color: AppColor.dotColor,
                      shape: OvalBorder(),
                    ),
                  ),
                  widthBox(8),
                  Text(
                    'Edit',
                    style: TextStyle(
                      color: AppColor.textgrey2Color,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckoutOrderSummaryCard extends StatelessWidget {
  const CheckoutOrderSummaryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Container(
      width: width(context),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.inputBoxBGColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                c.lang == 'en'
                    ? AppText.showOrderSummaryEn
                    : AppText.showOrderSummaryAr,
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${subscriptionModel.groupRestaurantCategory == 'Silver' ? subscriptionModel.meal.silverprice : subscriptionModel.groupRestaurantCategory == 'Gold' ? subscriptionModel.meal.goldprice : subscriptionModel.meal.platinumprice}${c.lang == 'en' ? AppText.kdEn : AppText.kdAr}',
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          heightBox(12),
          CheckoutDetailCard(),
          heightBox(16),
          CheckoutDiscountBox(),
          heightBox(24),
          Divider(
            color: AppColor.dividerColor,
          ),
          heightBox(16),
          CheckOutPriceWidget(),
        ],
      ),
    );
  }
}

class CheckOutPriceWidget extends StatelessWidget {
  const CheckOutPriceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrderBackend());
    var c = Get.put(TranslatorBackend());
    return Column(
      children: [
        TextWithPrice(
            text: c.lang == 'en' ? AppText.subTotalEn : AppText.subTotalAr,
            price:
                "${subscriptionModel.groupRestaurantCategory == 'Silver' ? subscriptionModel.meal.silverprice : subscriptionModel.groupRestaurantCategory == 'Gold' ? subscriptionModel.meal.goldprice : subscriptionModel.meal.platinumprice}${c.lang == 'en' ? AppText.kdEn : AppText.kdAr}"),
        heightBox(8),
        // TextWithPrice(
        //     text: c.lang == 'en'
        //         ? AppText.shippingCostEn
        //         : AppText.shippingCostAr,
        //     price: "8.00${c.lang == 'en' ? AppText.kdEn : AppText.kdAr}"),
        // heightBox(8),
        controller.discountId != ''
            ? TextWithPrice(
                text:
                    "${c.lang == 'en' ? AppText.discountEn : AppText.discountAr} (${controller.discountPercentage}%)",
                price:
                    "- ${controller.discountAmount}${c.lang == 'en' ? AppText.kdEn : AppText.kdAr}")
            : SizedBox(),
        heightBox(16),
        Divider(
          color: AppColor.dividerColor,
        ),
        heightBox(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              c.lang == 'en' ? AppText.totalEn : AppText.totalAr,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${(subscriptionModel.groupRestaurantCategory == 'Silver' ? subscriptionModel.meal.silverprice : subscriptionModel.groupRestaurantCategory == 'Gold' ? subscriptionModel.meal.goldprice : subscriptionModel.meal.platinumprice) - controller.discountAmount}${c.lang == 'en' ? AppText.kdEn : AppText.kdAr}',
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class TextWithPrice extends StatelessWidget {
  final String text;
  final String price;
  const TextWithPrice({super.key, required this.text, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            color: AppColor.textgrey2Color,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}

class CheckoutDiscountBox extends StatelessWidget {
  const CheckoutDiscountBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    var controller = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          c.lang == 'en' ? AppText.discountCodeEn : AppText.discountCodeAr,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        heightBox(8),
        Container(
          width: width(context),
          padding: EdgeInsets.symmetric(
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColor.secondaryColor,
              width: 0.5,
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                "assets/icons/coupon.png",
                width: 20,
                height: 20,
              ),
              widthBox(8),
              SizedBox(
                width: width(context) * .55,
                child: TextFormField(
                  controller: controller,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: c.lang == 'en'
                        ? AppText.enterYourCodeEn
                        : AppText.enterYourCodeAr,
                    hintStyle: TextStyle(
                      color: AppColor.textgreyColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () async {
                  showLoaderDialog(context);
                  await Get.put(OrderBackend()).applyDiscount(
                      controller.text,
                      (subscriptionModel.groupRestaurantCategory == 'Silver'
                          ? subscriptionModel.meal.silverprice
                          : subscriptionModel.groupRestaurantCategory == 'Gold'
                              ? subscriptionModel.meal.goldprice
                              : subscriptionModel.meal.platinumprice));
                },
                child: Text(
                  c.lang == 'en' ? AppText.applyEn : AppText.applyAr,
                  style: TextStyle(
                    color: AppColor.secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CheckoutDetailCard extends StatelessWidget {
  const CheckoutDetailCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Container(
      width: width(context),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.whiteColor,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    subscriptionModel.program.logo,
                    width: 58,
                    height: 58,
                    fit: BoxFit.cover,
                  ),
                ),
                widthBox(12),
                SizedBox(
                  width: width(context) * .54,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subscriptionModel.program.name,
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      heightBox(5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${c.lang == 'en' ? AppText.daysEn : AppText.daysAr}:',
                            style: TextStyle(
                              color: AppColor.textgrey2Color,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${int.parse(subscriptionModel.duration.split(" ")[0]) * 7}',
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '${c.lang == 'en' ? AppText.mealsEn : AppText.mealsAr}:',
                            style: TextStyle(
                              color: AppColor.textgrey2Color,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${subscriptionModel.meal.name} / ${c.lang == 'en' ? AppText.dayEn : AppText.dayAr}',
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      heightBox(5),
                      Text(
                        '${c.lang == 'en' ? AppText.fridaysEn : AppText.fridaysAr} ${subscriptionModel.includeFriday ? c.lang == 'en' ? AppText.includedEn : AppText.includedAr : c.lang == 'en' ? AppText.notIncludedEn : AppText.notIncludedAr}',
                        style: TextStyle(
                          color: AppColor.reviewCardTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          heightBox(5),
          Divider(
            color: AppColor.whiteColor,
          ),
          heightBox(5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/plates.png",
                  width: 67,
                  height: 50,
                ),
                widthBox(12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${subscriptionModel.groupRestaurantCategory == 'Silver' ? c.lang == 'en' ? AppText.silverEn : AppText.silverAr : subscriptionModel.groupRestaurantCategory == 'Gold' ? c.lang == 'en' ? AppText.goldEn : AppText.goldAr : c.lang == 'en' ? AppText.platinumEn : AppText.platinumAr} ${c.lang == 'en' ? AppText.restoEn : AppText.restoAr}',
                      style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    heightBox(5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${c.lang == 'en' ? AppText.restosEn : AppText.restosAr}:',
                          style: TextStyle(
                            color: AppColor.textgrey2Color,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '${subscriptionModel.restaurant.length}',
                          style: TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
