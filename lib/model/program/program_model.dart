class ProgramModel {
  final String id;
  String name;
  final String logo;
  String description;
  String tag;
  final int rating;
  final bool popular;

  ProgramModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.description,
    required this.tag,
    required this.rating,
    required this.popular,
  });

  factory ProgramModel.fromJSON(Map<String, dynamic> json) {
    return ProgramModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      description: json['description'] ?? '',
      tag: json['tag'] ?? '',
      rating: json['rating'] ?? 0,
      popular: json['popular'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'logo': logo,
      'description': description,
      'tag': tag,
      'rating': rating,
      'popular': popular,
    };
  }
}
