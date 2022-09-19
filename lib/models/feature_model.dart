class Features {
  String? property;
  String? feature;
  String? featureValue;

  Features({this.property, this.feature, this.featureValue});

  Features.fromJson(Map<String, dynamic> json) {
    property = json['property'];
    feature = json['feature'];
    featureValue = json['feature_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property'] = this.property;
    data['feature'] = this.feature;
    data['feature_value'] = this.featureValue;
    return data;
  }
}
