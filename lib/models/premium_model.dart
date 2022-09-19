class PremiumDetail {
  String? user;
  String? address;
  String? city;
  String? state;
  String? idType;
  String? idNumber;
  String? idPhoto;
  bool? isVerified;
  String? id;

  PremiumDetail({this.user, this.address, this.city, this.state, this.idNumber, this.idType, this.idPhoto, this.isVerified, this.id});

  PremiumDetail.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    idType = json['id_type'];
    idNumber = json['id_number'];
    idPhoto = json['id_photo'];
    isVerified = json['is_verified'].toString() == '1';
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['id_number'] = idNumber;
    data['id_photo'] = idPhoto;
    data['id'] = id;
    return data;
  }
}
