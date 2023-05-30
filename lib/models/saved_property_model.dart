// To parse this JSON data, do
//
//     final savedProperty = savedPropertyFromJson(jsonString);

import 'dart:convert';

SavedProperty savedPropertyFromJson(String str) => SavedProperty.fromJson(json.decode(str));

String savedPropertyToJson(SavedProperty data) => json.encode(data.toJson());

class SavedProperty {
  bool status;
  String message;
  SavedPropertyData data;

  SavedProperty({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SavedProperty.fromJson(Map<String, dynamic> json) => SavedProperty(
    status: json["status"],
    message: json["message"],
    data: SavedPropertyData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class SavedPropertyData {
  int pages;
  int total;
  List<Property> properties;

  SavedPropertyData({
    required this.pages,
    required this.total,
    required this.properties,
  });

  factory SavedPropertyData.fromJson(Map<String, dynamic> json) => SavedPropertyData(
    pages: json["pages"],
    total: json["total"],
    properties: List<Property>.from(json["properties"].map((x) => Property.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pages": pages,
    "total": total,
    "properties": List<dynamic>.from(properties.map((x) => x.toJson())),
  };
}

class Property {
  String user;
  String property;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String propertyId;
  PropertyData data;
  Location location;
  List<Media> media;
  List<Feature> features;
  List<Amenity> amenities;
  List<dynamic> reviews;

  Property({
    required this.user,
    required this.property,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.propertyId,
    required this.data,
    required this.location,
    required this.media,
    required this.features,
    required this.amenities,
    required this.reviews,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
    user: json["user"],
    property: json["property"],
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    propertyId: json["propertyId"],
    data: PropertyData.fromJson(json["data"]),
    location: Location.fromJson(json["location"]),
    media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
    features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
    amenities: List<Amenity>.from(json["amenities"].map((x) => Amenity.fromJson(x))),
    reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "property": property,
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "propertyId": propertyId,
    "data": data.toJson(),
    "location": location.toJson(),
    "media": List<dynamic>.from(media.map((x) => x.toJson())),
    "features": List<dynamic>.from(features.map((x) => x.toJson())),
    "amenities": List<dynamic>.from(amenities.map((x) => x.toJson())),
    "reviews": List<dynamic>.from(reviews.map((x) => x)),
  };
}

class Amenity {
  String property;
  String amenity;
  String id;
  DateTime createdAt;
  DateTime updatedAt;

  Amenity({
    required this.property,
    required this.amenity,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

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

class PropertyData {
  String user;
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

  PropertyData({
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
  });

  factory PropertyData.fromJson(Map<String, dynamic> json) => PropertyData(
    user: json["user"],
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
  );

  Map<String, dynamic> toJson() => {
    "user": user,
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
  };
}

class Feature {
  String property;
  String feature;
  String featureValue;
  String id;
  DateTime createdAt;
  DateTime updatedAt;

  Feature({
    required this.property,
    required this.feature,
    required this.featureValue,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

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
  String property;
  String type;
  String media;
  String id;
  DateTime createdAt;
  DateTime updatedAt;

  Media({
    required this.property,
    required this.type,
    required this.media,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    property: json["property"],
    type: json["type"]!,
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


