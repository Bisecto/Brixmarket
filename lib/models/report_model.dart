class Reports {
  String? user;
  String? property;
  String? subject;
  String? message;

  Reports({this.user, this.property, this.subject, this.message});

  Reports.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    property = json['property'];
    subject = json['subject'].toString().replaceAll('&#039;', '\'').replaceAll('&bull;', '.').replaceAll('&yen;', '¥').replaceAll('&pound;', '£').replaceAll('&euro;', '€').replaceAll('&lt;', '<').replaceAll('&gt;', '>').replaceAll('&amp;', '&').replaceAll('&ldquo;', '"').replaceAll('&rdquo;', '"').replaceAll('&lsquo;', '\'').replaceAll('&rsquo;', '\'');
    message = json['message'].toString().replaceAll('&#039;', '\'').replaceAll('&bull;', '.').replaceAll('&yen;', '¥').replaceAll('&pound;', '£').replaceAll('&euro;', '€').replaceAll('&lt;', '<').replaceAll('&gt;', '>').replaceAll('&amp;', '&').replaceAll('&ldquo;', '"').replaceAll('&rdquo;', '"').replaceAll('&lsquo;', '\'').replaceAll('&rsquo;', '\'');
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
