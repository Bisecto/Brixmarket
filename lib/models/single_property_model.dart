// To parse this JSON data, do
//
//     final singlePropertyModel = singlePropertyModelFromJson(jsonString);

import 'dart:convert';

SinglePropertyModel singlePropertyModelFromJson(String str) =>
    SinglePropertyModel.fromJson(json.decode(str));

String singlePropertyModelToJson(SinglePropertyModel data) =>
    json.encode(data.toJson());

class SinglePropertyModel {
  SinglePropertyModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory SinglePropertyModel.fromJson(Map<String, dynamic> json) =>
      SinglePropertyModel(
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
    required this.property,
  });

  Property property;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        property: Property.fromJson(json["property"]),
      );

  Map<String, dynamic> toJson() => {
        "property": property.toJson(),
      };
}

class Property {
  Property({
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
    required this.views,
    required this.location,
    required this.media,
    required this.features,
    required this.amenities,
    required this.reviews,
    // required this.contact,
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
  int views;
  Location location;
  List<Media> media;
  List<Feature> features;
  List<Amenity> amenities;
  List<Review> reviews;
  //List<Contact> contact;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        user: User.fromJson(json["user"]),
        title: json["title"]
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
            .replaceAll('&rsquo;', '\'')
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
        description: json["description"]
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
        price: json["price"] ?? 0,
        priceDuration: json["price_duration"] ?? ' ',
        reference: json["reference"] ?? ' ',
        category: json["category"] ?? ' ',
        type: json["type"] ?? ' ',
        status: json["status"] ?? ' ',
        publishState: json["publish_state"] ?? ' ',
        id: json["id"] ?? ' ',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        property: json["property"] ?? ' ',
        views: json["views"],
        location: Location.fromJson(json["location"]),
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        amenities: List<Amenity>.from(
            json["amenities"].map((x) => Amenity.fromJson(x))),
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        //contact: List<Contact>.from(json["contact"].map((x) => Contact.fromJson(x))) ??[],
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
        "views": views,
        "location": location.toJson(),
        "media": List<Media>.from(media.map((x) => x.toJson())),
        "features": List<Feature>.from(features.map((x) => x.toJson())),
        "amenities": List<Amenity>.from(amenities.map((x) => x.toJson())),
        "reviews": List<Review>.from(reviews.map((x) => x.toJson())),
        //"contact": List<dynamic>.from(contact.map((x) => x.toJson()))??[],
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
  Contact({
    required this.property,
    required this.emailAddress,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.address,
    required this.id,
  });

  String property;
  String emailAddress;
  String phoneNumber;
  String whatsappNumber;
  String address;
  String id;
  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        property: json["property"] ?? " ",
        emailAddress: json["email_address"] ?? " ",
        phoneNumber: json["phone_number"] ?? " ",
        whatsappNumber: json["whatsapp_number"] ?? " ",
        address: json["address"] ?? " ",
        id: json["id"] ?? " ",
      );

  Map<String, dynamic> toJson() => {
        "property": property,
        "email_address": emailAddress,
        "phone_number": phoneNumber,
        "whatsapp_number": whatsappNumber,
        "address": address,
        "id": id,
      };
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
        property: json["property"] ?? ' ',
        address: json["address"] ?? ' ',
        city: json["city"] ?? ' ',
        state: json["state"] ?? ' ',
        longitude: json["longitude"] ?? ' ',
        latitude: json["latitude"] ?? ' ',
        landmarks: json["landmarks"] ?? ' ',
        id: json["id"] ?? ' ',
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
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.media,
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

class Review {
  Review({
    required this.user,
    required this.property,
    required this.rating,
    required this.message,
    required this.deleted,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  String user;
  String property;
  int rating;
  String message;
  int deleted;
  String id;
  DateTime createdAt;
  DateTime updatedAt;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        user: json["user"] ?? ' ',
        property: json["property"] ?? ' ',
        rating: json["rating"] ?? 0,
        message: json["message"]
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
        deleted: json["deleted"],
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "property": property,
        "rating": rating,
        "message": message,
        "deleted": deleted,
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
    //required this.agency,
  });

  String surname;
  String firstName;
  String phoneNumber;
  String emailAddress;
  String refId;
  String image;
  String location;
  String longitude;
  String latitude;
  String city;
  String state;
  String country;
  String address;
  String password;
  int isAdmin;
  int isActive;
  int isAgency;
  int isAgent;
  int isUser;
  int isVerified;
  int verifiedAgent;
  int isPremium;
  int isBlocked;
  String otp;
  String id;
  DateTime createdAt;
  //Agency agency;

  factory User.fromJson(Map<String, dynamic> json) => User(
        surname: json["surname"] ?? ' ',
        firstName: json["first_name"] ?? ' ',
        phoneNumber: json["phone_number"] ?? ' ',
        emailAddress: json["email_address"],
        refId: json["ref_id"],
        image: json["image"] ?? '',
        location: json["location"] ?? ' ',
        longitude: json["longitude"] ?? ' ',
        latitude: json["latitude"] ?? ' ',
        city: json["city"] ?? ' ',
        state: json["state"] ?? ' ',
        country: json["country"] ?? ' ',
        address: json["address"] ?? ' ',
        password: json["password"] ?? ' ',
        isAdmin: json["is_admin"],
        isActive: json["is_active"],
        isAgency: json["is_agency"],
        isAgent: json["is_agent"],
        isUser: json["is_user"],
        isVerified: json["is_verified"],
        verifiedAgent: json["verified_agent"],
        isPremium: json["is_premium"],
        isBlocked: json["is_blocked"],
        otp: json["otp"] ?? ' ',
        id: json["id"] ?? ' ',
        createdAt: DateTime.parse(json["created_at"]),
        //agency: json['agency'] != null ? Agency.fromJson(json['agency']) : Agency.fromJson(json["agency"]),
      );

  Map<String, dynamic> toJson() => {
        "surname": surname,
        "first_name": firstName,
        "phone_number": phoneNumber,
        "email_address": emailAddress,
        "ref_id": refId,
        "image": image == null ? null : image,
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
        //"agency": agency == null ? null : agency.toJson(),
      };
}

// class Agency {
//   Agency({
//     required this.user,
//     required this.name,
//     required this.address,
//     required this.city,
//     required this.state,
//     required this.legalStatus,
//     required this.isVerified,
//     required this.id,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   String user;
//   String name;
//   String address;
//   String city;
//   String state;
//   String legalStatus;
//   int isVerified;
//   String id;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory Agency.fromJson(Map<String, dynamic> json) => Agency(
//         user: json["user"],
//         name: json["name"],
//         address: json["address"],
//         city: json["city"],
//         state: json["state"],
//         legalStatus: json["legal_status"],
//         isVerified: json["is_verified"],
//         id: json["id"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "user": user,
//         "name": name,
//         "address": address,
//         "city": city,
//         "state": state,
//         "legal_status": legalStatus,
//         "is_verified": isVerified,
//         "id": id,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }