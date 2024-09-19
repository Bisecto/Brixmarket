class Amenities {
  String? property;
  String? amenity;
  String? amenityValue;

  Amenities({this.property, this.amenity, this.amenityValue});

  Amenities.fromJson(Map<String, dynamic> json) {
    property = json['property']??" ";
    amenity = json['amenity']??" ";
    amenityValue = json['amenity_value']??" ";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property'] = this.property;
    data['amenity'] = this.amenity;
    data['amenity_value'] = this.amenityValue;
    return data;
  }
}
