import 'dart:convert';
import 'dart:developer';

import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/meal/meal_model.dart';
import 'package:get/get.dart';

import '../../services/http_service.dart';
import '../../utils/api_constants.dart';

class MealBackend extends GetxController {
  List<MealModel> mealList = [];

  fetchAllMeals(String programId) async {
    try {
      var c = Get.put(TranslatorBackend());

      final response =
          await HttpServices.get("${ApiConstants.meals}$programId");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        log(data.toString());
        List mList = data['meal'];
        mealList = mList.map((e) => MealModel.fromJson(e)).toList();
        for (int i = 0; i < mealList.length; i++) {
          mealList[i].name = await c.translateText(mealList[i].name);

          mealList[i].description =
              await c.translateText(mealList[i].description);
        }
        update();
      } else {
        print("${response.statusCode}");
      }
    } catch (e) {
      print("FETCH ALL MEALS: $e");
    }
  }
}
