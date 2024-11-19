import 'package:eight_hundred_cal/backend/profile/profile_backend.dart';
import 'package:eight_hundred_cal/model/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';

class ProfileWidget extends StatefulWidget {
  final String token;
  const ProfileWidget({super.key, required this.token});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  static const String defaultImageUrl =
      'https://cdn.pixabay.com/photo/2021/06/15/16/11/man-6339003_640.jpg';

  String profileImageUrl = '';
  bool isLoading = true;

  _fetchProfileData() async {
    try {
      ProfileModel model =
          await Get.put(ProfileBackend()).fetchProfileData2(widget.token);

      if (Uri.parse(model.image).isAbsolute) {
        setState(() {
          profileImageUrl = model.image;
          isLoading = false;
        });
      } else {
        setState(() {
          profileImageUrl = defaultImageUrl;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        profileImageUrl = defaultImageUrl;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(120),
        border: Border.all(color: AppColor.secondaryColor, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: isLoading
            ? Image.asset('assets/images/placeholder.png', fit: BoxFit.cover)
            : FadeInImage.assetNetwork(
                placeholder: 'assets/images/placeholder.png',
                image: profileImageUrl,
                fit: BoxFit.cover,
                fadeInDuration: Duration(milliseconds: 200),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/placeholder.png',
                    fit: BoxFit.cover,
                  );
                },
              ),
      ),
    );
  }
}
