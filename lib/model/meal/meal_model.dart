// class MealModel {
//   final String id;
//   String name;
//   final String logo;
//   final List tags;
//   String description;
//   final String programId;
//   final String kcal;
//   final List meals;
//   final num silverprice;
//   final num goldprice;
//   final num platinumprice;

//   MealModel({
//     required this.id,
//     required this.name,
//     required this.logo,
//     required this.tags,
//     required this.description,
//     required this.programId,
//     required this.kcal,
//     required this.meals,
//     required this.silverprice,
//     required this.goldprice,
//     required this.platinumprice,
//   });

//   factory MealModel.fromJson(Map<String, dynamic> json) {
//     return MealModel(
//       id: json['_id'],
//       name: json['name'],
//       logo: json['logo'],
//       tags: json['tags'],
//       description: json['description'],
//       programId: json['program'],
//       kcal: json['kcal'].toString(),
//       meals: (json['meals'] as List).map((e) => e).toList(),
//       silverprice: double.parse(json['silverprice'].toString()),
//       goldprice: double.parse(json['goldprice'].toString()),
//       platinumprice: double.parse(json['platinumprice'].toString()),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'name': name,
//       'logo': logo,
//       'tags': tags,
//       'description': description,
//       'program': programId,
//       'kcal': kcal,
//       'meals': meals,
//       'platinumprice': platinumprice,
//       'goldprice': goldprice,
//       'silverprice': silverprice,
//     };
//   }
// }

class MealModel {
  final String id;
  String name;
  final String logo;
  final List tags;
  String description;
  final String programId;
  final String kcal;
  final List meals;
  final num silverprice;
  final num goldprice;
  final num platinumprice;

  MealModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.tags,
    required this.description,
    required this.programId,
    required this.kcal,
    required this.meals,
    required this.silverprice,
    required this.goldprice,
    required this.platinumprice,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      tags: json['tags'] is List ? json['tags'] : [],
      description: json['description'] ?? '',
      programId: json['program'] ?? '',
      kcal: json['kcal'].toString(),
      meals: json['meals'] is List ? json['meals'] : [],
      silverprice: double.parse(json['silverprice'].toString()),
      goldprice: double.parse(json['goldprice'].toString()),
      platinumprice: double.parse(json['platinumprice'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'logo': logo,
      'tags': tags,
      'description': description,
      'program': programId,
      'kcal': kcal,
      'meals': meals,
      'platinumprice': platinumprice,
      'goldprice': goldprice,
      'silverprice': silverprice,
    };
  }
}
