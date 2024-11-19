// import 'package:eight_hundred_cal/services/storage_service.dart';
// import 'package:eight_hundred_cal/utils/db_keys.dart';
// import 'package:get/get.dart';
// import 'package:translator/translator.dart';

// class TranslatorBackend extends GetxController {
//   String lang = 'en';

//   changeLanguage(String upLang) {
//     lang = upLang;
//     StorageService().write(DbKeys.lang, upLang);
//     update();
//   }

//   checkLanguage() async {
//     lang = await StorageService().read(DbKeys.lang) ?? 'en';
//     update();
//   }

//   Future<String> translateText(String text) async {
//     var data = await GoogleTranslator()
//         .translate(text != "" ? text : "dummy", to: lang);
//     return data.text;
//   }

//   Future<String> translateTextInEn(String text) async {
//     var data = await GoogleTranslator()
//         .translate(text != "" ? text : "dummy", to: 'en');
//     return data.text;
//   }
// }
import 'package:eight_hundred_cal/services/storage_service.dart';
import 'package:eight_hundred_cal/utils/db_keys.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

class TranslatorBackend extends GetxController {
  String lang = 'en';

  @override
  void onInit() {
    super.onInit();
    checkLanguage();
  }

  void changeLanguage(String upLang) {
    lang = upLang;
    StorageService().write(DbKeys.lang, upLang);
    update();
  }

  Future<void> checkLanguage() async {
    lang = await StorageService().read(DbKeys.lang) ?? 'en';
    update();
  }

  Future<String> translateText(String? text) async {
    if (text == null || text.isEmpty) return 'dummy';
    try {
      var data = await GoogleTranslator().translate(text, to: lang);
      return data.text;
    } catch (e) {
      print("Translation failed: $e");
      return text;
    }
  }

  Future<String> translateTextInEn(String? text) async {
    if (text == null || text.isEmpty) return 'dummy';
    try {
      var data = await GoogleTranslator().translate(text, to: 'en');
      return data.text;
    } catch (e) {
      print("Translation to English failed: $e");
      return text;
    }
  }
}
