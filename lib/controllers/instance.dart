import 'package:brixmarket/controllers/create_property_controller.dart';
import 'package:brixmarket/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import 'property_controller.dart';
import 'package:brixmarket/models/single_property_model.dart' as single;

var homeCtrl = Get.find<PropCtrl>(tag: 'home');
var propCtrl = Get.find<PropCtrl>(tag: 'home');
var cPropCtrl = Get.find<CreatePropertyCtrl>();
var user = homeCtrl.user.value;
bool isLogin = HomeController.isLogin.value;

reInitInstance() {
  homeCtrl = Get.find<PropCtrl>(tag: 'home');
  propCtrl = Get.find<PropCtrl>(tag: 'home');
  cPropCtrl = Get.find<CreatePropertyCtrl>();
  isLogin = HomeController.isLogin.value;
  user = homeCtrl.user.value;
}

accountName({required User? user, home = false}) {
  if (user?.isUser == true) {
    return home ? "${user?.firstName}" : '${user?.firstName} ${user?.surname}';
  } else {
    return user?.agency?.name ?? '${user?.firstName}';
  }
}

accountName1({required single.User user, home = false}) {
  if (user.isUser == true) {
    return home ? user.firstName : '${user.firstName} ${user.surname}';
  } else {
    return '${user.firstName}';
  }
}

noInternetFunction({function}) {}
