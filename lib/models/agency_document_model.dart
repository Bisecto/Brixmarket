class AgencyDocument {
  String? agency;
  String? legalName;
  String? rcNumber;
  String? certPhoto;
  String? id;

  AgencyDocument({this.agency, this.legalName, this.rcNumber, this.certPhoto, this.id});

  AgencyDocument.fromJson(Map<String, dynamic> json) {
    agency = json['agency'];
    legalName = json['legal_name'];
    rcNumber = json['rc_number'];
    certPhoto = json['cert_photo'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['agency'] = agency;
    data['legal_name'] = legalName;
    data['rc_number'] = rcNumber;
    data['cert_photo'] = certPhoto;
    data['id'] = id;
    return data;
  }
}
