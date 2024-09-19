// To parse this JSON data, do
//
//     final userProperty = userPropertyFromJson(jsonString);

import 'dart:convert';

import 'package:brixmarket/models/property_model.dart';

UserProperty userPropertyFromJson(String str) => UserProperty.fromJson(json.decode(str));

String userPropertyToJson(UserProperty data) => json.encode(data.toJson());

class UserProperty {
  UserProperty({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory UserProperty.fromJson(Map<String, dynamic> json) => UserProperty(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}

class Data {
  Data({
    this.property,
    this.pages,
  });

  List<Property>? property;
  int? pages;

   Data.fromJson(json) {
     //property: List<P>.from(json["properties"].map((x) => x)),
     property =
     json['properties'].isNotEmpty ? (json['properties'] as List).map((v) => Property.fromJson(v)).toList() : <Property>[];

     pages = json["pages"];
   }

}
