import 'dart:io';

import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:eight_hundred_cal/model/data/disclaimer_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';

class HealthInfoPage extends StatefulWidget {
  @override
  State<HealthInfoPage> createState() => _HealthInfoPageState();
}

class _HealthInfoPageState extends State<HealthInfoPage> {
  late Future<void> initOperation;

  @override
  void initState() {
    super.initState();
    initOperation = initHyphenation(DefaultResourceLoaderLanguage.de1996);
  }

  final isios = Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pimaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.pimaryColor,
        title: Padding(
          padding: const EdgeInsets.only(right: 70),
          child: Text(
            'View Source',
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leading: IconButton(
          icon: isios
              ? Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 30,
                )
              : Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<void>(
          future: initOperation,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return Center(child: Text('Error initializing hyphenation'));
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DisclaimerData[0].name,
                      style: TextStyle(
                        color: AppColor.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Gap(5),
                    AutoHyphenatingText(
                      DisclaimerData[2].description,
                      // textAlign: TextAlign.justify,
                      //softWrap: true,
                      // maxLines: null,
                      // overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 16,
                        letterSpacing: 0.5,
                        height: 1.5,
                      ),
                    ),
                    Gap(20),
                    Text(
                      DisclaimerData[1].name,
                      style: TextStyle(
                        color: AppColor.secondaryColor,
                        fontSize: 20,
                      ),
                    ),
                    Gap(5),
                    AutoHyphenatingText(
                      DisclaimerData[1].description,
                      style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                    Gap(20),
                    Text(
                      DisclaimerData[2].name,
                      style: TextStyle(
                        color: AppColor.secondaryColor,
                        fontSize: 20,
                      ),
                    ),
                    Gap(5),
                    AutoHyphenatingText(
                      DisclaimerData[2].description,
                      style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                    // Gap(20),
                    // Text(
                    //   DisclaimerData[3].name,
                    //   style: TextStyle(
                    //     color: AppColor.secondaryColor,
                    //     fontSize: 20,
                    //   ),
                    // ),
                    // Gap(5),
                    // AutoHyphenatingText(
                    //   DisclaimerData[3].description,
                    //   style: TextStyle(
                    //     color: AppColor.whiteColor,
                    //     fontSize: 16,
                    //   ),
                    // )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
