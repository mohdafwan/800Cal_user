class GroupRestaurantModel {
  String id;
  int timestamp;
  Restaurant restaurant;
  Map meal;
  double price;
  String createdAt;
  String updatedAt;
  int v;
  bool approved;

  GroupRestaurantModel({
    required this.id,
    required this.timestamp,
    required this.restaurant,
    required this.meal,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.approved,
  });

  factory GroupRestaurantModel.fromJson(Map<String, dynamic> json) {
    return GroupRestaurantModel(
      id: json['_id'] ?? '',
      timestamp: json['timestamp'] ?? 0,
      restaurant: Restaurant.fromJson(json['restaurant'] ?? {}),
      meal: json['meal'] ?? {},
      price: (json['price'] ?? 0).toDouble(),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
      approved: json['approved'] ?? false,
    );
  }
}

class Restaurant {
  String id;
  String title;
  String logo;
  List<String> tags;
  String username;
  String email;
  bool verified;
  String role;
  bool closed;
  bool enabled;
  double rating;
  int ordersCanAccept;
  String createdAt;
  String updatedAt;
  int v;
  String contactemail;
  String contactname;
  String contactnumber;
  String manageremail;
  String managername;
  String managernumber;
  String owneremail;
  String ownername;
  String ownernumber;
  double wallet;

  Restaurant({
    required this.id,
    required this.title,
    required this.logo,
    required this.tags,
    required this.username,
    required this.email,
    required this.verified,
    required this.role,
    required this.closed,
    required this.enabled,
    required this.rating,
    required this.ordersCanAccept,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.contactemail,
    required this.contactname,
    required this.contactnumber,
    required this.manageremail,
    required this.managername,
    required this.managernumber,
    required this.owneremail,
    required this.ownername,
    required this.ownernumber,
    required this.wallet,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      logo: json['logo'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      verified: json['verified'] ?? false,
      role: json['role'] ?? '',
      closed: json['closed'] ?? false,
      enabled: json['enabled'] ?? false,
      rating: (json['rating'] ?? 0).toDouble(),
      ordersCanAccept: json['ordersCanAccept'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
      contactemail: json['contactemail'] ?? '',
      contactname: json['contactname'] ?? '',
      contactnumber: json['contactnumber'] ?? '',
      manageremail: json['manageremail'] ?? '',
      managername: json['managername'] ?? '',
      managernumber: json['managernumber'] ?? '',
      owneremail: json['owneremail'] ?? '',
      ownername: json['ownername'] ?? '',
      ownernumber: json['ownernumber'] ?? '',
      wallet: (json['wallet'] ?? 0).toDouble(),
    );
  }
}
