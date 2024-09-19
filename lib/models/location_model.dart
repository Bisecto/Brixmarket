class Location {
  String? id;
  String? property;
  String? address;
  String? city;
  String? state;
  String? landmarks;
  String? longitude;
  String? latitude;

  Location({this.id, this.property, this.address, this.city, this.state, this.landmarks, this.longitude, this.latitude});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    property = json['property'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    landmarks = json['landmarks'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property'] = this.property;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['landmarks'] = this.landmarks;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}
