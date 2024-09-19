import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileHomeController extends GetxController {
  var isList = true.obs;
  var selectedIndex = 0.obs;
  var propertyTypeController = TextEditingController().obs;
  var bottomNavIndex = 0.obs;
}
