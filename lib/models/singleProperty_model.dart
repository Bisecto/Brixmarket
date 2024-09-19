// To parse this JSON data, do
//
//     final singleProperty = singlePropertyFromJson(jsonString);
import 'package:brixmarket/controllers/instance.dart';

import '../controllers/home_controller.dart';
import '../utils/utils.dart';
import 'amenity_model.dart';
import 'contact_model.dart';
import 'feature_model.dart';
import 'location_model.dart';
import 'media_model.dart';
import 'report_model.dart';
import 'review_model.dart';
import 'user_model.dart';
import 'dart:convert';

class Property {
  String? id;
  User? user;
  String? title;
  String? description;
  int? price;
  String? priceDuration;
  String? reference;
  String? category;
  String? type;
  String? status;
  bool? available;
  String? publishState;
  bool? blocked;
  String? createdAt;
  int? views;
  double? averageRating;
  int? numberOfRatingUsers;
  Contact? contact;
  Location? location;
  List<Media>? media;
  List<Review>? reviews;
  List<Reports>? reports;
  List<Features>? features;
  List<Amenities>? amenities;

  Property({
    this.id,
    this.user,
    this.title,
    this.description,
    this.price,
    this.priceDuration,
    this.reference,
    this.category,
    this.type,
    this.status,
    this.available,
    this.publishState,
    this.blocked,
    this.createdAt,
    this.views,
    this.location,
    this.media,
    this.features,
    this.amenities,
    this.reviews,
    this.averageRating,
    this.reports,
    this.contact,
  });

  Property.fromJson(json) {
    id = json['id'];
    views=json['views'];
    title = json['title'].toString().replaceAll('&#039;', '\'').replaceAll('&bull;', '.').replaceAll('&yen;', '¥').replaceAll('&pound;', '£').replaceAll('&euro;', '€').replaceAll('&lt;', '<').replaceAll('&gt;', '>').replaceAll('&amp;', '&').replaceAll('&ldquo;', '"').replaceAll('&rdquo;', '"').replaceAll('&lsquo;', '\'').replaceAll('&rsquo;', '\'');
    description = json['description'].toString().replaceAll('&#039;', '\'').replaceAll('&bull;', '.').replaceAll('&yen;', '¥').replaceAll('&pound;', '£').replaceAll('&euro;', '€').replaceAll('&lt;', '<').replaceAll('&gt;', '>').replaceAll('&amp;', '&').replaceAll('&ldquo;', '"').replaceAll('&rdquo;', '"').replaceAll('&lsquo;', '\'').replaceAll('&rsquo;', '\'');
    price = json['price'] != null ? int.parse(json['price'].toString()) : 0;
    priceDuration = json['price_duration'];
    reference = json['reference'];
    category = json['category'];
    type = json['type'];
    status = json['status'];
    available = json['available'];
    publishState = json['publish_state'];
    blocked = json['blocked'].toString() == '1';
    createdAt = Utils.formatDateTime(json['created_at']); //views = json['views'] != null ? int.parse(json['views'].toString()) : 0;

    try {
      user = json['user'] != null ? User.fromJson(json['user']) : User();
      location = json['location'] != null ? Location.fromJson(json['location']) : Location();
      try {
        contact = json['contact'] != null ? Contact.fromJson(json['contact']) : Contact();
      } catch (e, t) {
        dnd(e);
        dnd(t);
      }

      media = json['media'].isNotEmpty ? (json['media'] as List).map((v) => Media.fromJson(v)).toList() : <Media>[];
      features = json['features'].isNotEmpty ? (json['features'] as List).map((v) => Features.fromJson(v)).toList() : <Features>[];
      amenities = json['amenities'].isNotEmpty ? (json['amenities'] as List).map((v) => Amenities.fromJson(v)).toList() : <Amenities>[];
      reviews = json['reviews'].isNotEmpty ? (json['reviews'] as List).map((v) => Review.fromJson(v)).toList() : <Review>[];
      reports = json['reports'].isNotEmpty ? (json['reports'] as List).map((v) => Reports.fromJson(v)).toList() : <Reports>[];

      averageRating = getAverageRating(reviews!);
    } catch (e) {
      dnd(e);
    }
  }

  getAverageRating(List<Review> reviews) {
    if (reviews.isEmpty) return null;
    var numberOfUsers = 0;
    var totalStar = 0;
    for (var review in reviews) {
      numberOfUsers++;
      totalStar += review.rating!;
    }
    numberOfRatingUsers = reviews.length;
    return numberOfUsers == 0 ? null : (totalStar / numberOfUsers).toDouble();
  }

  static Map<String, dynamic> map({
    id,
    user,
    title,
    description,
    price,
    priceDuration,
    reference,
    category,
    type,
    status,
    available,
    views,
    address,
    city,
    state,
    publishState,
    landmarks,
    longitude,
    latitude,
    media,
    feature,
    featureValue,
    amenity,
    amenityValue,
    subject,
    message,
    rating,
    email,
    phone,
    whatsAppNumber,
    name,
    search,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null || propCtrl.property.id != null) data['property'] = id ?? propCtrl.property.id;
    if (user != null || HomeController.userId.isNotEmpty) data['user'] = data['userId'] = user ?? HomeController.userId;

    if (title != null) data['title'] = title;
    if (description != null) data['description'] = description;
    if (price != null) data['price'] = price;
    if (priceDuration != null) data['price_duration'] = priceDuration;
    if (reference != null) data['reference'] = reference;
    if (category != null) data['category'] = category;
    if (type != null) data['type'] = type;
    if (status != null) data['status'] = status;
    if (available != null) data['available'] = available;
    if (publishState != null) data['publish_state'] = publishState;

    if (views != null) data['views'] = views;

    if (address != null) data['address'] = address;
    if (city != null) data['city'] = city;
    if (state != null) data['state'] = state;
    if (landmarks != null) data['landmarks'] = landmarks;
    if (longitude != null) data['longitude'] = longitude;
    if (latitude != null) data['latitude'] = latitude;

    if (type != null) data['type'] = type;
    if (media != null) data['media'] = media;

    if (feature != null) data['feature'] = feature;
    if (featureValue != null) data['feature_value'] = featureValue;

    if (amenity != null) data['amenity'] = amenity;
    if (amenityValue != null) data['amenity_value'] = amenityValue;

    if (subject != null) data['subject'] = subject;
    if (message != null) data['message'] = message;

    if (rating != null) data['rating'] = rating;

    if (email != null) data['email_address'] = email;
    if (phone != null) data['phone_number'] = phone;
    if (whatsAppNumber != null) data['whatsapp_number'] = whatsAppNumber;
    if (name != null) data['name'] = name;

    if (search != null) data['search'] = search;
    return data;
  }
}

// class Amenity {
//   Amenity({
//     this.property,
//     this.amenity,
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   Id property;
//   String amenity;
//   String id;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
//     property: idValues.map[json["property"]],
//     amenity: json["amenity"],
//     id: json["id"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "property": idValues.reverse[property],
//     "amenity": amenity,
//     "id": id,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }
//
// enum Id { MDM2_NZ_M1_OT_AY_N_TK5_MJ_E4 }
//
// final idValues = EnumValues({
//   "MDM2NzM1OTAyNTk5MjE4": Id.MDM2_NZ_M1_OT_AY_N_TK5_MJ_E4
// });
//
// class Contact {
//   Contact({
//     this.property,
//     this.emailAddress,
//     this.phoneNumber,
//     this.whatsappNumber,
//     this.address,
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   Id property;
//   String emailAddress;
//   String phoneNumber;
//   String whatsappNumber;
//   String address;
//   String id;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory Contact.fromJson(Map<String, dynamic> json) => Contact(
//     property: idValues.map[json["property"]],
//     emailAddress: json["email_address"],
//     phoneNumber: json["phone_number"],
//     whatsappNumber: json["whatsapp_number"],
//     address: json["address"],
//     id: json["id"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "property": idValues.reverse[property],
//     "email_address": emailAddress,
//     "phone_number": phoneNumber,
//     "whatsapp_number": whatsappNumber,
//     "address": address,
//     "id": id,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }
//
// class Feature {
//   Feature({
//     this.property,
//     this.feature,
//     this.featureValue,
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   Id property;
//   String feature;
//   String featureValue;
//   String id;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory Feature.fromJson(Map<String, dynamic> json) => Feature(
//     property: idValues.map[json["property"]],
//     feature: json["feature"],
//     featureValue: json["feature_value"],
//     id: json["id"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "property": idValues.reverse[property],
//     "feature": feature,
//     "feature_value": featureValue,
//     "id": id,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }
//
// class Location {
//   Location({
//     this.property,
//     this.address,
//     this.city,
//     this.state,
//     this.longitude,
//     this.latitude,
//     this.landmarks,
//     this.id,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   Id property;
//   String? address;
//   String? city;
//   String? state;
//   String? longitude;
//   String? latitude;
//   String? landmarks;
//   String? id;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory Location.fromJson(Map<String, dynamic> json) => Location(
//     property: idValues.map[json["property"]],
//     address: json["address"],
//     city: json["city"],
//     state: json["state"],
//     longitude: json["longitude"],
//     latitude: json["latitude"],
//     landmarks: json["landmarks"],
//     id: json["id"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "property": idValues.reverse[property],
//     "address": address,
//     "city": city,
//     "state": state,
//     "longitude": longitude,
//     "latitude": latitude,
//     "landmarks": landmarks,
//     "id": id,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }
//
// class Media {
//   Media({
//     this.property,
//     this.type,
//     this.media,
//     this.id,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   Id? property;
//   Type? type;
//   String? media;
//   String? id;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory Media.fromJson(Map<String, dynamic> json) => Media(
//     property: idValues.map[json["property"]],
//     type: json["type"],
//     media: json["media"],
//     id: json["id"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "property": idValues.reverse[property],
//     "type": type,
//     "media": media,
//     "id": id,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }
//
//
//
// class User {
//   User({
//     this.surname,
//     this.firstName,
//     this.phoneNumber,
//     this.emailAddress,
//     this.refId,
//     this.image,
//     this.location,
//     this.longitude,
//     this.latitude,
//     this.city,
//     this.state,
//     this.country,
//     this.address,
//     this.password,
//     this.isAdmin,
//     this.isActive,
//     this.isAgency,
//     this.isAgent,
//     this.isUser,
//     this.isVerified,
//     this.verifiedAgent,
//     this.isPremium,
//     this.isBlocked,
//     this.otp,
//     this.id,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.agency,
//     required this.settings,
//   });
//
//   String? surname;
//   String? firstName;
//   String? phoneNumber;
//   String? emailAddress;
//   String? refId;
//   String? image;
//   String? location;
//   String? longitude;
//   String? latitude;
//   String? city;
//   String? state;
//   String? country;
//   String? address;
//   String? password;
//   int? isAdmin;
//   int? isActive;
//   int? isAgency;
//   int? isAgent;
//   int? isUser;
//   int? isVerified;
//   int? verifiedAgent;
//   int? isPremium;
//   int? isBlocked;
//   String? otp;
//   String? id;
//   DateTime createdAt;
//   DateTime updatedAt;
//   Agency agency;
//   Settings settings;
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//     surname: json["surname"],
//     firstName: json["first_name"],
//     phoneNumber: json["phone_number"],
//     emailAddress: json["email_address"],
//     refId: json["ref_id"],
//     image: json["image"],
//     location: json["location"],
//     longitude: json["longitude"],
//     latitude: json["latitude"],
//     city: json["city"],
//     state: json["state"],
//     country: json["country"],
//     address: json["address"],
//     password: json["password"],
//     isAdmin: json["is_admin"],
//     isActive: json["is_active"],
//     isAgency: json["is_agency"],
//     isAgent: json["is_agent"],
//     isUser: json["is_user"],
//     isVerified: json["is_verified"],
//     verifiedAgent: json["verified_agent"],
//     isPremium: json["is_premium"],
//     isBlocked: json["is_blocked"],
//     otp: json["otp"],
//     id: json["id"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"],
//     agency: Agency.fromJson(json["agency"]),
//     settings: Settings.fromJson(json["settings"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "surname": surname,
//     "first_name": firstName,
//     "phone_number": phoneNumber,
//     "email_address": emailAddress,
//     "ref_id": refId,
//     "image": image,
//     "location": location,
//     "longitude": longitude,
//     "latitude": latitude,
//     "city": city,
//     "state": state,
//     "country": country,
//     "address": address,
//     "password": password,
//     "is_admin": isAdmin,
//     "is_active": isActive,
//     "is_agency": isAgency,
//     "is_agent": isAgent,
//     "is_user": isUser,
//     "is_verified": isVerified,
//     "verified_agent": verifiedAgent,
//     "is_premium": isPremium,
//     "is_blocked": isBlocked,
//     "otp": otp,
//     "id": id,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt,
//     "agency": agency.toJson(),
//     "settings": settings.toJson(),
//   };
// }
//
// class Agency {
//   Agency({
//     this.user,
//     this.name,
//     this.address,
//     this.city,
//     this.state,
//     this.legalStatus,
//     this.isVerified,
//     this.id,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.document,
//   });
//
//   String? user;
//   String? name;
//   String? address;
//   String? city;
//   String? state;
//   String? legalStatus;
//   int? isVerified;
//   String? id;
//   DateTime createdAt;
//   DateTime updatedAt;
//   Document document;
//
//   factory Agency.fromJson(Map<String, dynamic> json) => Agency(
//     user: json["user"],
//     name: json["name"],
//     address: json["address"],
//     city: json["city"],
//     state: json["state"],
//     legalStatus: json["legal_status"],
//     isVerified: json["is_verified"],
//     id: json["id"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     document: Document.fromJson(json["document"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "user": user,
//     "name": name,
//     "address": address,
//     "city": city,
//     "state": state,
//     "legal_status": legalStatus,
//     "is_verified": isVerified,
//     "id": id,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "document": document.toJson(),
//   };
// }
//
// class Document {
//   Document({
//     this.agency,
//     this.legalName,
//     this.rcNumber,
//     this.certPhoto,
//     this.id,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   String? agency;
//   String? legalName;
//   String? rcNumber;
//   String? certPhoto;
//   String? id;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory Document.fromJson(Map<String, dynamic> json) => Document(
//     agency: json["agency"],
//     legalName: json["legal_name"],
//     rcNumber: json["rc_number"],
//     certPhoto: json["cert_photo"],
//     id: json["id"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "agency": agency,
//     "legal_name": legalName,
//     "rc_number": rcNumber,
//     "cert_photo": certPhoto,
//     "id": id,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }
//
// class Settings {
//   Settings({
//     this.user,
//     this.requestTourAlert,
//     this.updateAlert,
//     this.inAppAlert,
//     this.emailAlert,
//     this.smsAlert,
//     this.subNewsletter,
//     this.id,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   String? user;
//   int? requestTourAlert;
//   int? updateAlert;
//   int? inAppAlert;
//   int? emailAlert;
//   int? smsAlert;
//   int? subNewsletter;
//   String? id;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory Settings.fromJson(Map<String, dynamic> json) => Settings(
//     user: json["user"],
//     requestTourAlert: json["request_tour_alert"],
//     updateAlert: json["update_alert"],
//     inAppAlert: json["in_app_alert"],
//     emailAlert: json["email_alert"],
//     smsAlert: json["sms_alert"],
//     subNewsletter: json["sub_newsletter"],
//     id: json["id"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "user": user,
//     "request_tour_alert": requestTourAlert,
//     "update_alert": updateAlert,
//     "in_app_alert": inAppAlert,
//     "email_alert": emailAlert,
//     "sms_alert": smsAlert,
//     "sub_newsletter": subNewsletter,
//     "id": id,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }
//
