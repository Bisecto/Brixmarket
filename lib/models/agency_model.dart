import 'agency_document_model.dart';

class Agency {
  String? user;
  String? name;
  String? address;
  String? city;
  String? state;
  String? legalStatus;
  bool? isVerified;
  String? id;
  AgencyDocument? document;

  Agency({this.user, this.name, this.address, this.city, this.state, this.legalStatus, this.isVerified, this.id, this.document});

  Agency.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    legalStatus = json['legal_status'];
    isVerified = json['is_verified'].toString() == '1';
    id = json['id'];
    document = json['document'] != null ? AgencyDocument.fromJson(json['document']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['name'] = name;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['legal_status'] = legalStatus;
    data['is_verified'] = isVerified;
    data['id'] = id;
    if (document != null) {
      data['document'] = document!.toJson();
    }
    return data;
  }
}
