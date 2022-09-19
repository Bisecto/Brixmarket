import 'package:brixmarket/utils/utils.dart';

class Review {
  String? user;
  String? property;
  int? rating;
  String? message;
  bool? deleted;
  String? createdAt;

  Review({this.user, this.property, this.rating, this.message, this.deleted});

  Review.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    property = json['property'];
    rating = int.parse(json['rating'].toString());
    message = json['message'];
    deleted = json['deleted'].toString() == '1';
    createdAt = Utils.formatDateTime(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['property'] = property;
    data['rating'] = rating;
    data['message'] = message;
    data['deleted'] = deleted;
    return data;
  }
}
