import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../backend/translator/translator_backend.dart';
import '../../../utils/app_text.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

class HomeScreenSuccessStoryWidget extends StatelessWidget {
  const HomeScreenSuccessStoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              c.lang == 'en'
                  ? AppText.ourSuccessStoryEn
                  : AppText.ourSuccessStoryAr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            // Text(
            //   c.lang == 'en' ? AppText.viewMoreEn : AppText.viewMoreAr,
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     color: AppColor.secondaryColor,
            //     fontSize: 14,
            //     fontWeight: FontWeight.w500,
            //   ),
            // )
          ],
        ),
        heightBox(15),
        SizedBox(
          height: height(context) * .28,
          child: PageView.builder(
            itemCount: 5,
            controller: PageController(
              viewportFraction: 0.85,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: SizedBox(
                  height: height(context) * .28,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: width(context) * .8,
                          height: height(context) * .24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColor.inputBoxBGColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 45, left: 20, right: 20),
                            child: Column(
                              children: [
                                Text(
                                  'Dianne Russell',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.whiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                heightBox(5),
                                Text(
                                  'Customer service agent',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.reviewCardTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                heightBox(10),
                                Text(
                                  'This is great. So Delicious! You must come here with your family. This is great. So Delicious! You must come here with your family. This is great. So Delicious! You must come here with your family...',
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColor.textgreyColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60",
                            width: 76,
                            height: 76,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
