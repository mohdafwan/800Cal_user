// import 'dart:convert';
// import 'dart:developer';
// import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
// import 'package:eight_hundred_cal/model/restaurant/restaurant_model.dart';
// import 'package:eight_hundred_cal/services/http_service.dart';
// import 'package:eight_hundred_cal/utils/api_constants.dart';
// import 'package:eight_hundred_cal/utils/constants.dart';
// import 'package:get/get.dart';

// import '../../model/restaurant/group_restaurant_model.dart';
// import '../../model/restaurant/restaurant_detail_model.dart';

// class RestaurantBackend extends GetxController {
//   List<RestaurantModel> restaurants = [];
//   List<RestaurantModel> tempRestaurants = [];
//   List<RestaurantModel> subRestaurants = [];
//   RestaurantDetailModel? restaurantModel;
//   List<RestaurantModel> similarRestaurants = [];
//   List<GroupRestaurantModel> groupRestaurantModel = [];
//   Map menuDetail = {};
//   var c = Get.put(TranslatorBackend());
//   bool edit = false;

//   Future<bool> fetchAllRestaurants() async {
//     try {
//       final response = await HttpServices.get(ApiConstants.allRestaurant);
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
//         List restauList = data['restaurants'];
//         restaurants =
//             restauList.map((e) => RestaurantModel.fromJson(e)).toList();
//         for (int i = 0; i < restaurants.length; i++) {
//           restaurants[i].title = await c.translateText(restaurants[i].title);
//         }
//         tempRestaurants = restaurants;
//         log("restaurants");
//         update();
//       } else {
//         print("${response.statusCode}");
//       }
//       return true;
//     } catch (e) {
//       print("FETCH ALL RESTAURANT $e");
//       return false;
//     }
//   }

//   fetchSubscriptionRestaurant(List restauList) async {
//     try {
//       subRestaurants = [];
//       for (var item in restauList) {
//         final response =
//             await HttpServices.get(ApiConstants.restaurantDetails + item);
//         if (response.statusCode == 200) {
//           var data = jsonDecode(response.body);
//           RestaurantModel restaurant =
//               RestaurantModel.fromJson(data['restaurant']);
//           restaurant.title = await c.translateText(restaurant.title);
//           subRestaurants.add(restaurant);
//         } else {
//           print("${response.statusCode}");
//         }
//       }
//       update();
//     } catch (e) {
//       print('Fetch Subscription Restaurant $e');
//     }
//   }

//   fetchRestaurantDetails(String id) async {
//     try {
//       final response =
//           await HttpServices.get(ApiConstants.restaurantDetails + id);
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
//         RestaurantDetailModel restaurant =
//             RestaurantDetailModel.fromJson(data['restaurant']);
//         restaurantModel = restaurant;
//         update();
//         await fetchSimilarRestaurants(id);
//         for (int i = 0; i < restaurantModel!.tags.length; i++) {
//           restaurantModel!.tags[i] =
//               await c.translateText(restaurantModel!.tags[i]);
//         }
//         restaurantModel!.title = await c.translateText(restaurantModel!.title);
//         restaurantModel!.description =
//             await c.translateText(restaurantModel!.description);
//         update();
//       } else {
//         print("${response.statusCode}");
//       }
//     } catch (e) {
//       print("FETCH RESTAURANT DETAILS $e");
//     }
//   }

//   fetchSimilarRestaurants(String id) async {
//     similarRestaurants.clear();
//     restaurants.forEach((element) {
//       if (element.id != id) {
//         similarRestaurants.add(element);
//       }
//     });
//     update();
//   }

//   searchRestaurantsByName(String name) {
//     if (name != "") {
//       tempRestaurants = restaurants
//           .where((element) =>
//               element.title.toLowerCase().contains(name.toLowerCase()))
//           .toList();
//     } else {
//       tempRestaurants = restaurants;
//     }
//     update();
//   }

//   fetchGroupRestaurant() async {
//     try {
//       var response = await HttpServices.get(
//           "${ApiConstants.groupRestaurant}${subscriptionModel.meal.id}");

//       if (response.statusCode == 200) {
//         Map data = jsonDecode(response.body);

//         groupRestaurantModel = List<GroupRestaurantModel>.from(
//             data['info'].map((e) => GroupRestaurantModel.fromJson(e)));
//         log(data.toString());
//         update();
//       } else {
//         print("Fetching group restaurants error: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Fetching group restaurants error: $e");
//     }
//   }

//   addMenuDetails(Map data) {
//     menuDetail = data;
//     update();
//   }

//   Future<bool> fetchRestaurantMenu(String id) async {
//     try {
//       final response =
//           await HttpServices.get(ApiConstants.restaurantDetails + id);
//       log("${response.statusCode} $id");
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
//         RestaurantDetailModel restaurant =
//             RestaurantDetailModel.fromJson(data['restaurant']);
//         restaurantModel = restaurant;
//         for (int i = 0; i < restaurantModel!.tags.length; i++) {
//           restaurantModel!.tags[i] =
//               await c.translateText(restaurantModel!.tags[i]);
//         }
//         restaurantModel!.title = await c.translateText(restaurantModel!.title);
//         restaurantModel!.description =
//             await c.translateText(restaurantModel!.description);
//         update();
//       } else {
//         print("${response.statusCode}");
//       }
//       return true;
//     } catch (e) {
//       print("FETCH RESTAURANT DETAILS $e");
//       return false;
//     }
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/restaurant/restaurant_model.dart';
import 'package:eight_hundred_cal/services/http_service.dart';
import 'package:eight_hundred_cal/utils/api_constants.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:get/get.dart';

import '../../model/restaurant/group_restaurant_model.dart';
import '../../model/restaurant/restaurant_detail_model.dart';

class RestaurantBackend extends GetxController {
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> tempRestaurants = [];
  List<RestaurantModel> subRestaurants = [];
  RestaurantDetailModel? restaurantModel;
  List<RestaurantModel> similarRestaurants = [];
  List<GroupRestaurantModel> groupRestaurantModel = [];
  Map menuDetail = {};
  var c = Get.put(TranslatorBackend());
  bool edit = false;
  var isLoading = false.obs;

  Future<bool> fetchAllRestaurants() async {
    try {
      isLoading(true);
      final response = await HttpServices.get(ApiConstants.allRestaurant);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List restauList = data['restaurants'];
        restaurants =
            restauList.map((e) => RestaurantModel.fromJson(e)).toList();
        for (int i = 0; i < restaurants.length; i++) {
          restaurants[i].title = await c.translateText(restaurants[i].title);
        }
        tempRestaurants = restaurants;
        log("restaurants");
        update();
      } else {
        print("${response.statusCode}");
      }
      return true;
    } catch (e) {
      print("FETCH ALL RESTAURANT $e");
      return false;
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchSubscriptionRestaurant(List restauList) async {
    try {
      isLoading(true);
      subRestaurants = [];
      for (var item in restauList) {
        final response =
            await HttpServices.get(ApiConstants.restaurantDetails + item);
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          RestaurantModel restaurant =
              RestaurantModel.fromJson(data['restaurant']);
          restaurant.title = await c.translateText(restaurant.title);
          subRestaurants.add(restaurant);
        } else {
          print("${response.statusCode}");
        }
      }
      update();
    } catch (e) {
      print('Fetch Subscription Restaurant $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchRestaurantDetails(String id) async {
    try {
      isLoading(true);
      final response =
          await HttpServices.get(ApiConstants.restaurantDetails + id);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        RestaurantDetailModel restaurant =
            RestaurantDetailModel.fromJson(data['restaurant']);
        restaurantModel = restaurant;
        update();
        await fetchSimilarRestaurants(id);
        for (int i = 0; i < restaurantModel!.tags.length; i++) {
          restaurantModel!.tags[i] =
              await c.translateText(restaurantModel!.tags[i]);
        }
        restaurantModel!.title = await c.translateText(restaurantModel!.title);
        restaurantModel!.description =
            await c.translateText(restaurantModel!.description);
        update();
      } else {
        print("${response.statusCode}");
      }
    } catch (e) {
      print("FETCH RESTAURANT DETAILS $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchSimilarRestaurants(String id) async {
    similarRestaurants.clear();
    restaurants.forEach((element) {
      if (element.id != id) {
        similarRestaurants.add(element);
      }
    });
    update();
  }

  void searchRestaurantsByName(String name) {
    if (name != "") {
      tempRestaurants = restaurants
          .where((element) =>
              element.title.toLowerCase().contains(name.toLowerCase()))
          .toList();
    } else {
      tempRestaurants = restaurants;
    }
    update();
  }

  Future<void> fetchGroupRestaurant() async {
    try {
      isLoading(true);
      var response = await HttpServices.get(
          "${ApiConstants.groupRestaurant}${subscriptionModel.meal.id}");

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);

        groupRestaurantModel = List<GroupRestaurantModel>.from(
            data['info'].map((e) => GroupRestaurantModel.fromJson(e)));
        log(data.toString());
        update();
      } else {
        print("Fetching group restaurants error: ${response.statusCode}");
      }
    } catch (e) {
      print("Fetching group restaurants error: $e");
    } finally {
      isLoading(false);
    }
  }

  void addMenuDetails(Map data) {
    menuDetail = data;
    update();
  }

  Future<bool> fetchRestaurantMenu(String id) async {
    try {
      isLoading(true);
      final response =
          await HttpServices.get(ApiConstants.restaurantDetails + id);
      log("${response.statusCode} $id");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        RestaurantDetailModel restaurant =
            RestaurantDetailModel.fromJson(data['restaurant']);
        restaurantModel = restaurant;
        for (int i = 0; i < restaurantModel!.tags.length; i++) {
          restaurantModel!.tags[i] =
              await c.translateText(restaurantModel!.tags[i]);
        }
        restaurantModel!.title = await c.translateText(restaurantModel!.title);
        restaurantModel!.description =
            await c.translateText(restaurantModel!.description);
        update();
      } else {
        print("${response.statusCode}");
      }
      return true;
    } catch (e) {
      print("FETCH RESTAURANT DETAILS $e");
      return false;
    } finally {
      isLoading(false);
    }
  }
}
