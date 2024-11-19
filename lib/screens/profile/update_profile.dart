import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/profile/profile_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_appbar.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:eight_hundred_cal/widgets/custom_date_calendar_picker.dart';
import 'package:eight_hundred_cal/widgets/custom_text_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/profile/profile_model.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String dob = "";
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final dobController = TextEditingController();

  var selectedGender = '';
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final addressController = TextEditingController();

  var c = Get.put(TranslatorBackend());
  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? selectedValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileModel model = Get.put(ProfileBackend()).model!;
    nameController.text = model.firstname;
    surnameController.text = model.lastname;
    dob = model.dob;
    dobController.text =
        "${DateFormat('dd MMM, yyyy').format(DateTime.parse(model.dob))}";
    // genderController.text = model.gender;
    selectedGender = model.gender.capitalizeFirst!;
    selectedValue = model.gender.capitalizeFirst!;
    emailController.text = model.email;
    phoneNumberController.text = model.phonenumber;
    addressController.text = model.address;
    heightController.text = model.height.toString();
    weightController.text = model.weight.toString();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: AppColor.pimaryColor,
        appBar: AppBar(
          backgroundColor: AppColor.pimaryColor,
          leading: IconButton(
            onPressed: () {
              Get.put(BottomBarBackend()).updateIndex(10);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          title: Text(
            c.lang == 'en'
                ? AppText.updateYourProfileEn
                : AppText.updateYourProfileAr,
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: GetBuilder<ProfileBackend>(builder: (controller) {
          ProfileModel model = controller.model ?? dummyProfileModel;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
                  .copyWith(top: 20),
              child: Column(
                children: [
                  // CustomAppBar(
                  //   text: c.lang == 'en'
                  //       ? AppText.updateYourProfileEn
                  //       : AppText.updateYourProfileAr,
                  //   showProfile: false,
                  // ),
                  // heightBox(10),
                  Text(
                    c.lang == 'en'
                        ? AppText.updateProfileDescEn
                        : AppText.updateProfileDescAr,
                    style: TextStyle(
                      color: AppColor.textgreyColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  heightBox(20),
                  UpdateProfileImageWidget(
                    image: model.image,
                  ),
                  heightBox(20),
                  CustomTextBox(
                    hintText: "Name",
                    controller: nameController,
                  ),
                  heightBox(20),
                  CustomTextBox(
                    hintText: "Surname",
                    controller: surnameController,
                  ),
                  heightBox(20),
                  CustomTextBox(
                    hintText: "DOB",
                    controller: dobController,
                    readOnly: true,
                    onTap: () async {
                      DateTime value = await customDatePicker(
                          context, DateTime(1900), DateTime(2025));
                      dob = value.toString();
                      dobController.text =
                          "${DateFormat('dd MMM, yyyy').format(value)}";
                    },
                  ),
                  heightBox(20),
                  DropdownButtonFormField2(
                    isExpanded: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fillColor: AppColor.inputBoxBGColor,
                      filled: true,
                    ),
                    hint: Text(
                      "Gender",
                      style: TextStyle(color: Colors.white),
                    ),
                    items: genderItems
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                color: AppColor.whiteColor,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select gender';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value as String;
                      });
                    },
                    onSaved: (value) {
                      selectedGender = value.toString();
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        //color: Colors.black45,
                      ),
                      iconSize: 24,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColor.inputBoxBGColor,
                      ),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      // overlayColor: MaterialStateProperty.all(Colors.amber)
                    ),
                    value: selectedValue,
                  ),
                  // CustomTextBox(
                  //   hintText: "Gender",
                  //   controller: genderController,
                  //   readOnly: true,
                  //   onTap: () async {
                  //     String dropdownValue = 'Male';
                  //     var items = [
                  //       'Male',
                  //       'Female',
                  //       'Othres',
                  //     ];
                  //     DropdownButton(
                  //       value: dropdownValue,
                  //       items: items.map(
                  //         (String items) {
                  //           return DropdownMenuItem(
                  //             child: Text(items),
                  //             value: items,
                  //           );
                  //         },
                  //       ).toList(),
                  //       onChanged: (String? value) {
                  //         setState(() {
                  //           dropdownValue = value!;
                  //           genderController.text = value;
                  //         });
                  //       },
                  //     );
                  //   },
                  // ),
                  heightBox(20),
                  CustomTextBox(
                    hintText: "Email",
                    controller: emailController,
                  ),
                  heightBox(20),
                  CustomTextBox(
                    hintText: "Phone Number",
                    controller: phoneNumberController,
                  ),
                  heightBox(20),
                  CustomTextBox(
                    hintText: "Height",
                    controller: heightController,
                  ),
                  heightBox(20),
                  CustomTextBox(
                    hintText: "Address",
                    controller: addressController,
                  ),
                  heightBox(20),
                  CustomTextBox(
                    hintText: "Weight",
                    controller: weightController,
                  ),
                  heightBox(20),
                  CustomButton(
                    text: c.lang == 'en' ? AppText.updateEn : AppText.updateAr,
                    onTap: () async {
                      Get.put(ProfileBackend()).updateProfile(
                          ProfileModel(
                            username:
                                await c.translateTextInEn(emailController.text),
                            email:
                                await c.translateTextInEn(emailController.text),
                            password: model.password,
                            verified: model.verified,
                            role: model.role,
                            firstname:
                                await c.translateTextInEn(nameController.text),
                            lastname: await c
                                .translateTextInEn(surnameController.text),
                            dob: dob,
                            gender: await c.translateTextInEn(
                              selectedGender.toLowerCase(),
                            ),
                            weight: int.parse(weightController.text),
                            height: int.parse(heightController.text),
                            allergy: model.allergy,
                            dislikes: model.dislikes,
                            image: model.image,
                            phonenumber: await c
                                .translateTextInEn(phoneNumberController.text),
                            address: await c
                                .translateTextInEn(addressController.text),
                            balance: model.balance,
                            subscriptionId: model.subscriptionId,
                            subscriptionEndDate: model.subscriptionEndDate,
                            subscriptionStartDate: model.subscriptionStartDate,
                            isSubscribed: model.isSubscribed,
                            subusers: model.subusers,
                            referralcode: model.referralcode,
                            referralpoints: model.referralpoints,
                            referredby: model.referredby,
                          ),
                          context);
                    },
                  ),
                  heightBox(120),
                ],
              ),
            ),
          );
        }),
      )),
    );
  }
}

class UpdateProfileImageWidget extends StatelessWidget {
  final String image;
  const UpdateProfileImageWidget({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 114,
          height: 114,
          decoration: ShapeDecoration(
            shape: OvalBorder(
              side: BorderSide(width: 1, color: AppColor.secondaryColor),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              image != ""
                  ? image
                  : "https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 10,
          child: InkWell(
            onTap: () {
              Get.put(BottomBarBackend()).updateIndex(12);
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: ShapeDecoration(
                color: AppColor.pimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
              ),
              child: Center(
                child: Image.asset(
                  "assets/icons/camera.png",
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
