import 'dart:io';

import 'package:eight_hundred_cal/firebase_options.dart';
import 'package:eight_hundred_cal/screens/splash.dart';
import 'package:eight_hundred_cal/services/http_global.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColor.pimaryColor,
    ));
    return GetMaterialApp(
      title: '800 Cal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColor.pimaryColor,
        fontFamily: GoogleFonts.lexend().fontFamily,
        toggleButtonsTheme:
            ToggleButtonsThemeData(disabledColor: AppColor.inputBoxBGColor),
      ),
      // home: SplashScreen(),
      home: SplashScreen(),
    );
  }
}
