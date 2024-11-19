class RestaurantDetailModel {
  final String id;
  String title;
  List tags;
  final String username;
  final String email;
  final bool verified;
  final bool closed;
  final String createdAt;
  String description;
  final String logo;
  final num rating;
  final String image;
  final List comments;
  final List menu;

  RestaurantDetailModel({
    required this.id,
    required this.title,
    required this.tags,
    required this.username,
    required this.email,
    required this.verified,
    required this.closed,
    required this.createdAt,
    required this.description,
    required this.logo,
    required this.rating,
    required this.image,
    required this.comments,
    required this.menu,
  });

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      tags: json['tags'] ?? [],
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      verified: json['verified'] ?? false,
      closed: json['closed'] ?? false,
      createdAt: json['created_at'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'] ?? '',
      rating: json['rating'] ?? 0,
      image: json['image'] ??
          "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      comments: json['comments'] ?? [],
      menu: json['menu'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'tags': tags,
      'username': username,
      'email': email,
      'verified': verified,
      'closed': closed,
      'created_at': createdAt,
      'description': description,
      'logo': logo,
      'rating': rating,
      'image': image,
      'comments': comments,
      'menu': menu,
    };
  }
}
