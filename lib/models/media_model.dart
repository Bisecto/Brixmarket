class Media {
  String? property;
  String? type;
  String? media;

  Media({this.property, this.type, this.media});

  Media.fromJson(Map<String, dynamic> json) {
    property = json['property'];
    type = json['type'];
    media = json['media'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property'] = this.property;
    data['type'] = this.type;
    data['media'] = this.media;
    return data;
  }
}
