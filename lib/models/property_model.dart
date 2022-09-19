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
    title = json['title'];
    description = json['description'];
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
