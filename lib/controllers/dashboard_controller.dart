import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  var priceDurationController = TextEditingController().obs;
  var statusController = TextEditingController().obs;
  var propertyTypeController = TextEditingController().obs;
  var newExistingController = TextEditingController().obs;
  var stateController = TextEditingController().obs;
  var cityController = TextEditingController().obs;
  var landmartController = TextEditingController().obs;
  var genderController = TextEditingController().obs;
  var nationalityController = TextEditingController().obs;
  var pstateController = TextEditingController().obs;
  var residenceCountryController = TextEditingController().obs;
  var residenceStateController = TextEditingController().obs;

  onSelected(int index) {
    selectedIndex.value = index;
    selectedIndex.refresh();
  }
}
