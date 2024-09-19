import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class Setting {
  var requestTourAlert = true.obs;
  var updateAlert = true.obs;
  var inAppAlert = true.obs;
  var emailAlert = true.obs;
  var smsAlert = true.obs;
  var subNewsletter = true.obs;

  Setting();

  Setting.fromJson(json) {
    requestTourAlert.value = json['request_tour_alert'].toString() == '1';
    updateAlert.value = json['update_alert'].toString() == '1';
    inAppAlert.value = json['in_app_alert'].toString() == '1';
    emailAlert.value = json['email_alert'].toString() == '1';
    smsAlert.value = json['sms_alert'].toString() == '1';
    subNewsletter.value = json['sub_newsletter'].toString() == '1';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (HomeController.userId.isNotEmpty) data['userId'] = HomeController.userId;
    data['request_tour_alert'] = requestTourAlert.value == true ? '1' : '0';
    data['update_alert'] = updateAlert.value == true ? '1' : '0';
    data['in_app_alert'] = inAppAlert.value == true ? '1' : '0';
    data['email_alert'] = emailAlert.value == true ? '1' : '0';
    data['sms_alert'] = smsAlert.value == true ? '1' : '0';
    data['sub_newsletter'] = subNewsletter.value == true ? '1' : '0';
    return data;
  }
}
