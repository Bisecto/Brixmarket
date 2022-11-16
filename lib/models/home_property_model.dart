// To parse this JSON data, do
//
//     final homeProperty = homePropertyFromJson(jsonString);

import 'dart:convert';
class Latest {
  Latest({
    required this.user,
    required this.title,
    required this.description,
    required this.price,
    required this.priceDuration,
    required this.reference,
    required this.category,
    required this.type,
    required this.status,
    required this.publishState,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.property,
    required this.location,
    required this.media,
  });

  User user;
  String title;
  String description;
  int price;
  String priceDuration;
  String reference;
  String category;
  String type;
  String status;
  String publishState;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String property;
  Location location;
  List<Media> media;

  factory Latest.fromJson(Map<String, dynamic> json) => Latest(
    user: User.fromJson(json["user"]),
    title: json["title"],
    description: json["description"],
    price: json["price"],
    priceDuration: json["price_duration"],
    reference: json["reference"],
    category: json["category"],
    type: json["type"],
    status: json["status"],
    publishState: json["publish_state"],
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    property: json["property"],
    location: Location.fromJson(json["location"]),
    media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "title": title,
    "description": description,
    "price": price,
    "price_duration": priceDuration,
    "reference": reference,
    "category": category,
    "type": type,
    "status": status,
    "publish_state": publishState,
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "property": property,
    "location": location.toJson(),
    "media": List<dynamic>.from(media.map((x) => x.toJson())),
  };
}

class Location {
  Location({
    required this.property,
    required this.address,
    required this.city,
    required this.state,
    required this.longitude,
    required this.latitude,
    required this.landmarks,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  String property;
  String address;
  String city;
  String state;
  String longitude;
  String latitude;
  String landmarks;
  String id;
  DateTime createdAt;
  DateTime updatedAt;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    property: json["property"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    landmarks: json["landmarks"],
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "property": property,
    "address": address,
    "city": city,
    "state": state,
    "longitude": longitude,
    "latitude": latitude,
    "landmarks": landmarks,
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Media {
  Media({
    required this.property,
    required this.type,
    required this.media,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  String property;
  String type;
  String media;
  String id;
  DateTime createdAt;
  DateTime updatedAt;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    property: json["property"],
    type: json["type"],
    media: json["media"],
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "property": property,
    "type": type,
    "media": media,
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}



class User {
  User({
    required this.surname,
    required this.firstName,
    required this.phoneNumber,
    required this.emailAddress,
    required this.refId,
    required this.image,
    required this.location,
    required this.longitude,
    required this.latitude,
    required this.city,
    required this.state,
    required this.country,
    required this.address,
    required this.password,
    required this.isAdmin,
    required this.isActive,
    required this.isAgency,
    required this.isAgent,
    required this.isUser,
    required this.isVerified,
    required this.verifiedAgent,
    required this.isPremium,
    required this.isBlocked,
    required this.otp,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  String surname;
  String firstName;
  String phoneNumber;
  String emailAddress;
  String refId;
  String image;
  dynamic location;
  dynamic longitude;
  dynamic latitude;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic address;
  dynamic password;
  int isAdmin;
  int isActive;
  int isAgency;
  int isAgent;
  int isUser;
  int isVerified;
  int verifiedAgent;
  int isPremium;
  int isBlocked;
  dynamic otp;
  String id;
  DateTime createdAt;
  dynamic updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    surname: json["surname"],
    firstName: json["first_name"],
    phoneNumber: json["phone_number"],
    emailAddress: json["email_address"],
    refId: json["ref_id"],
    image: json["image"],
    location: json["location"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    address: json["address"],
    password: json["password"],
    isAdmin: json["is_admin"],
    isActive: json["is_active"],
    isAgency: json["is_agency"],
    isAgent: json["is_agent"],
    isUser: json["is_user"],
    isVerified: json["is_verified"],
    verifiedAgent: json["verified_agent"],
    isPremium: json["is_premium"],
    isBlocked: json["is_blocked"],
    otp: json["otp"],
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "surname": surname,
    "first_name": firstName,
    "phone_number": phoneNumber,
    "email_address": emailAddress,
    "ref_id": refId,
    "image": image,
    "location": location,
    "longitude": longitude,
    "latitude": latitude,
    "city": city,
    "state": state,
    "country": country,
    "address": address,
    "password": password,
    "is_admin": isAdmin,
    "is_active": isActive,
    "is_agency": isAgency,
    "is_agent": isAgent,
    "is_user": isUser,
    "is_verified": isVerified,
    "verified_agent": verifiedAgent,
    "is_premium": isPremium,
    "is_blocked": isBlocked,
    "otp": otp,
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
  };
}




