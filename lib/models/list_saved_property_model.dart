// To parse this JSON data, do
//
//     final listSavedPropertyId = listSavedPropertyIdFromJson(jsonString);

import 'dart:convert';

ListSavedPropertyId listSavedPropertyIdFromJson(String str) => ListSavedPropertyId.fromJson(json.decode(str));

String listSavedPropertyIdToJson(ListSavedPropertyId data) => json.encode(data.toJson());

class ListSavedPropertyId {
  bool status;
  String message;
  List<String> data;

  ListSavedPropertyId({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ListSavedPropertyId.fromJson(Map<String, dynamic> json) => ListSavedPropertyId(
    status: json["status"],
    message: json["message"],
    data: List<String>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
