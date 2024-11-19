// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../utils/text_constant.dart';

class IosCustomAppBar extends StatelessWidget {
  final String text;
  final VoidCallback onPressesd;
  const IosCustomAppBar({
    Key? key,
    required this.text,
    required this.onPressesd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // mainAxisSize: MainAxisSize.max,
      children: [
        IconButton(
          onPressed: onPressesd,
          // onPressed: () {
          //   //Get.put(BottomBarBackend()).updateIndex(0);
          // },
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
            size: 30,
          ),
        ),
        Gap(10),
        Flexible(
          child: Text(
            text,
            style: appBarStyleios(),
          ),
        ),
      ],
    );
  }
}
