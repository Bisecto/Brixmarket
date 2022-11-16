class Contact {
  String? property;
  String? emailAddress;
  String? phoneNumber;
  String? whatsAppNumber;
  String? address;

  Contact({this.property, this.emailAddress, this.phoneNumber, this.address});

  Contact.fromJson(json) {
    property = json['property']??' ';
    emailAddress = json['email_address']??' ';
    phoneNumber = json['phone_number']??' ';
    whatsAppNumber = json['whatsapp_number']??' ';
    address = json['address']??' ';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property'] = this.property;
    data['email_address'] = this.emailAddress;
    data['phone_number'] = this.phoneNumber;
    data['whatsapp_number'] = this.phoneNumber;
    data['address'] = this.address;
    return data;
  }
}
