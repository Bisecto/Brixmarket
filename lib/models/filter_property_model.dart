// To parse this JSON data, do
//
//     final filterModel = filterModelFromJson(jsonString);

import 'dart:convert';

FilterModel filterModelFromJson(String str) =>
    FilterModel.fromJson(json.decode(str));

String filterModelToJson(FilterModel data) => json.encode(data.toJson());

class FilterModel {
  FilterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.properties,
    required this.pages,
  });

  List<Property> properties;
  int pages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        properties: List<Property>.from(
            json["properties"].map((x) => Property.fromJson(x))),
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "properties": List<dynamic>.from(properties.map((x) => x.toJson())),
        "pages": pages,
      };
}

class Property {
  Property({
    //required this.user,
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
    required this.views,
    required this.location,
    required this.media,
    required this.features,
    required this.amenities,
    required this.contact,
  });

 // User user;
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
  int views;
  Location location;
  List<Media> media;
  List<Feature> features;
  List<Amenity> amenities;
  Contact contact;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        //user: User.fromJson(json["user"]),
        title: json['title']
            .toString()
            .replaceAll('&#039;', '\'')
            .replaceAll('&bull;', '.')
            .replaceAll('&yen;', '¥')
            .replaceAll('&pound;', '£')
            .replaceAll('&euro;', '€')
            .replaceAll('&lt;', '<')
            .replaceAll('&gt;', '>')
            .replaceAll('&amp;', '&')
            .replaceAll('&ldquo;', '"')
            .replaceAll('&rdquo;', '"')
            .replaceAll('&lsquo;', '\'')
            .replaceAll('&rsquo;', '\''),
        description: json['description']
            .toString()
            .replaceAll('&#039;', '\'')
            .replaceAll('&bull;', '.')
            .replaceAll('&yen;', '¥')
            .replaceAll('&pound;', '£')
            .replaceAll('&euro;', '€')
            .replaceAll('&lt;', '<')
            .replaceAll('&gt;', '>')
            .replaceAll('&amp;', '&')
            .replaceAll('&ldquo;', '"')
            .replaceAll('&rdquo;', '"')
            .replaceAll('&lsquo;', '\'')
            .replaceAll('&rsquo;', '\''),
        price: json['price'] != null ? int.parse(json['price'].toString()) : 0,
        priceDuration: json["price_duration"]??' ',
        reference: json["reference"]??' ',
        category: json["category"]??' ',
        type: json["type"]??' ',
        status: json["status"]??' ',
        publishState: json["publish_state"]??' ',
        id: json["id"]??' ',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        property: json["property"]??' ',
        views: json["views"],
        location: Location.fromJson(json["location"]),
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        amenities: List<Amenity>.from(
            json["amenities"].map((x) => Amenity.fromJson(x))),
        contact: Contact.fromJson(json["contact"]),
      );

  Map<String, dynamic> toJson() => {
        //"user": user.toJson(),
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
        "views": views,
        //"location": location.toJson(),
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "amenities": List<dynamic>.from(amenities.map((x) => x.toJson())),
        "contact": contact.toJson(),
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
    property: json["property"]??' ',
    address: json["address"]??' ',
    city: json["city"]??' ',
    state: json["state"]??' ',
    longitude: json["longitude"]??' ',
    latitude: json["latitude"]??' ',
    landmarks: json["landmarks"]??' ',
    id: json["id"]??' ',
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
class Amenity {
  Amenity({
    required this.property,
    required this.amenity,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  String property;
  String amenity;
  String id;
  DateTime createdAt;
  DateTime updatedAt;

  factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
        property: json["property"],
        amenity: json["amenity"],
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "property": property,
        "amenity": amenity,
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Contact {
  Contact();

  factory Contact.fromJson(Map<String, dynamic> json) => Contact();

  Map<String, dynamic> toJson() => {};
}

class Feature {
  Feature({
    required this.property,
    required this.feature,
    required this.featureValue,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  String property;
  String feature;
  String featureValue;
  String id;
  DateTime createdAt;
  DateTime updatedAt;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        property: json["property"],
        feature: json["feature"],
        featureValue: json["feature_value"],
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "property": property,
        "feature": feature,
        "feature_value": featureValue,
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

// class User {
//   User({
//     required this.surname,
//     required this.firstName,
//     required this.phoneNumber,
//     required this.emailAddress,
//     required this.refId,
//     required this.image,
//     required this.location,
//     required this.longitude,
//     required this.latitude,
//     required this.city,
//     required this.state,
//     required this.country,
//     required this.address,
//     required this.password,
//     //required this.isAdmin,
//     required this.isActive,
//     required this.isAgency,
//     required this.isAgent,
//     required this.isUser,
//     required this.isVerified,
//     required this.verifiedAgent,
//     required this.isPremium,
//     required this.isBlocked,
//     required this.otp,
//     required this.id,
//   });
//
//   String surname;
//   String firstName;
//   String phoneNumber;
//   String emailAddress;
//   String refId;
//   String image;
//   String location;
//   String longitude;
//   String latitude;
//   String city;
//   String state;
//   String country;
//   String address;
//   String password;
//  // int isAdmin;
//   int isActive;
//   int isAgency;
//   int isAgent;
//   int isUser;
//   int isVerified;
//   int verifiedAgent;
//   int isPremium;
//   int isBlocked;
//   String otp;
//   String id;
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//         surname: json["surname"] ?? "null",
//         firstName: json["first_name"] ?? "null",
//         phoneNumber: json["phone_number"] ?? "null",
//         emailAddress: json["email_address"] ?? "null",
//         refId: json["ref_id"] ?? "null",
//         image: json["image"] ?? "null",
//         location: json["location"] ?? "null",
//         longitude: json["longitude"] ?? "null",
//         latitude: json["latitude"] ?? "null",
//         city: json["city"] ?? "null",
//         state: json["state"] ?? "null",
//         country: json["country"] ?? "null",
//         address: json["address"] ?? "null",
//         password: json["password"] ?? "null",
//         //isAdmin: json["is_admin"],
//         isActive: json["is_active"],
//         isAgency: json["is_agency"],
//         isAgent: json["is_agent"],
//         isUser: json["is_user"],
//         isVerified: json["is_verified"],
//         verifiedAgent: json["verified_agent"],
//         isPremium: json["is_premium"],
//         isBlocked: json["is_blocked"],
//         otp: json["otp"] ?? "null",
//         id: json["id"] ?? "null",
//       );
//
//   Map<String, dynamic> toJson() => {
//         "surname": surname,
//         "first_name": firstName,
//         "phone_number": phoneNumber,
//         "email_address": emailAddress,
//         "ref_id": refId,
//         "image": image,
//         "location": location,
//         "longitude": longitude,
//         "latitude": latitude,
//         "city": city,
//         "state": state,
//         "country": country,
//         "address": address,
//         "password": password,
//         //"is_admin": isAdmin,
//         "is_active": isActive,
//         "is_agency": isAgency,
//         "is_agent": isAgent,
//         "is_user": isUser,
//         "is_verified": isVerified,
//         "verified_agent": verifiedAgent,
//         "is_premium": isPremium,
//         "is_blocked": isBlocked,
//         "otp": otp,
//         "id": id,
//       };
// }
