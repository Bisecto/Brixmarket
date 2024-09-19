import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPropertyController extends GetxController {
  var statusController = TextEditingController().obs;
  var propertyTypeController = TextEditingController().obs;
  var subTypeController = TextEditingController().obs;
  var cityController = TextEditingController().obs;
  var stateController = TextEditingController().obs;
  var priceController = TextEditingController().obs;
  var priceDurationController = TextEditingController().obs;
}
