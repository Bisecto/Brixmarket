class Reports {
  String? user;
  String? property;
  String? subject;
  String? message;

  Reports({this.user, this.property, this.subject, this.message});

  Reports.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    property = json['property'];
    subject = json['subject'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['property'] = this.property;
    data['subject'] = this.subject;
    data['message'] = this.message;
    return data;
  }
}
