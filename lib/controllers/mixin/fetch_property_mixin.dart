import 'package:get/get.dart';

import '../../core/preloader.dart';
import '../../models/property_model.dart';
import '../../res/enums.dart';
import '../../res/strings.dart';
import '../../services/provider.dart';
import '../../utils/utils.dart';
import '../edit_controller.dart';
import '../instance.dart';

mixin FetchProperty {
  var activeNavItem = NavItems.home.obs;

  late Rx<Future<List<Property>>> allPropertiesWeb = getPropertiesWeb().obs;
  late Future<List> allAmenitiesFuture = getAmenitiesWeb();
  var refreshCount = 0.obs;
  var searchResultCount = 0.obs;
  Future<List<Property>> getPropertiesWeb({bool filter = false}) async {
    Preloader.show();
    if (filter || activeNavItem.value != NavItems.home) {
      return await applyFilterParametersWeb();
    }
    var response = await Provider().getData("property/get-all");
    if (response != null && response.isNotEmpty) {
      Preloader.hide();
      return (response['properties'] as List).map((e) => Property.fromJson(e)).toList();
    }
    Preloader.hide();
    return [];
  }

  void setAllPropertiesWeb({bool filter = false, NavItems navItem = NavItems.home, bool sideNav = false}) async {
    if (sideNav) Get.back();
    Get.toNamed(RouteStr.webProperties);
    activeNavItem.value = navItem;
    allPropertiesWeb.value = getPropertiesWeb(filter: filter);
    allPropertiesWeb.refresh();
    refreshCount++;
  }

  var map = <String, String>{};
  Future<List<Property>> applyFilterParametersWeb() async {
    map = {
      'min_price': EditCtrl.priceMin.value.text,
      'max_price': EditCtrl.priceMax.value.text,
      'min_room': EditCtrl.roomMin.value.text,
      'max_room': EditCtrl.roomMax.value.text,
      'min_bath': EditCtrl.bathsMin.value.text,
      'max_bath': EditCtrl.bathsMax.value.text,
      'state': EditCtrl.filterState.value.text,
      'city': EditCtrl.filterCity.value.text,
      'landmark': EditCtrl.filterLandMark.value.text,

    };
    int i = 0;
    // map['category'] = EditCtrl.category.value.text;
    // map['type'] = EditCtrl.propertyType.value;
    // map['status'] = EditCtrl.status.value.text;
    map['category[${i++}]'] = EditCtrl.filterCategoriesWeb.value.text;
    for (var element in EditCtrl.filterCategories) {
      map['category[${i++}]'] = element;
    }
    i = 0;
    for (var element in EditCtrl.filterTypes) {
      map['type[${i++}]'] = element;
    }
    i = 0;
    for (var element in EditCtrl.filterStatus) {
      map['status[${i++}]'] = element;
    }
    i = 0;
    for (var element in EditCtrl.filterAmenities) {
      map['amenity[${i++}]'] = element;
    }

    map['nav_item'] = activeNavItem.value.index.toString();
    dnd(activeNavItem);
    var response = await Provider().postData("property/filter-properties", map);

    if (response != null && response.isNotEmpty) {
      Preloader.hide();
      return (response['properties'] as List).map((e) => Property.fromJson(e)).toList();
    }
    Preloader.hide();
    return [];
  }

  List allAmenities = [];
  Future<List> getAmenitiesWeb() async {
    allAmenities = [];
    if (allAmenities.isEmpty) {
      String category = 'all';
      await Provider().postData("property/get-amenities/$category", Property.map()).then((value) => allAmenities = value as List);
    }
    return allAmenities;
  }

  Future getSavedProperties() async {
    if (propCtrl.mySavedProperties.isEmpty) {
      var response = await Provider().postData("user/saved-properties", Property.map(id: propCtrl.property.id));
      if (response != null && response.isNotEmpty) {
        propCtrl.mySavedProperties.value = (response['properties'] as List).map((e) => Property.fromJson(e)).toList();
      }
    }

    return propCtrl.mySavedProperties.isEmpty ? null : propCtrl.mySavedProperties;
  }
}
