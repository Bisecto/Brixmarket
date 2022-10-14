import 'dart:async';

import 'package:brixmarket/controllers/edit_controller.dart';
import 'package:brixmarket/controllers/home_controller.dart';
import 'package:brixmarket/core/dialogs.dart';
import 'package:brixmarket/models/user_model.dart';
import 'package:brixmarket/redirect/push_notification.dart';
import 'package:brixmarket/utils/utils.dart';
import 'package:get/get.dart';

import '../core/preloader.dart';
import '../models/property_model.dart';
import '../res/lists.dart';
import '../res/strings.dart';
import '../services/provider.dart';
import '../utils/validations.dart';
import 'instance.dart';
import 'mixin/create_property_mixin.dart';
import 'mixin/fetch_property_mixin.dart';

class PropCtrl extends HomeController with CreateProperty, FetchProperty {
  var isList = false.obs;
  var property = Property();
  var showLargeFilerBox = true.obs;
  var showPremiumForm = false.obs;

  var showMoreFilter = false.obs;

  var navbarIndex = 0.obs;

  var showWebFilter = false.obs;

  var currentIndex = ''.obs;

  var isFeaturedProperties = false.obs;
  var isAll_Properties = false.obs;


  void toggleList() {
    isList.value = !isList.value;
    isList.refresh();
  }

  var allProperties = <Property>[].obs;
  var globalProperties = <Property>[];
  var globalAllProperties = <Property>[];

  var propertiesList = <List<Property>>[];
  var loadingAllProperties = true.obs;

  Future<List<Property>> getProperties({navItem}) async {
    loadingAllProperties.value = true;
    map['nav_item'] = (navItem ?? navbarIndex.value).toString();
    var response = await Provider().postData("property/filter-properties", map);
    if (response != null && response.isNotEmpty) {
      globalProperties = (response['properties'] as List)
          .map((e) => Property.fromJson(e))
          .toList();
    }

    exploreFilterProperties.value = globalProperties;
    exploreFilterProperties.refresh();
    exploreFilterProperties.shuffle();
    showFeatureLoading.value = false;

    allProperties.value = globalProperties;
    allProperties.refresh();
    loadingAllProperties.value = false;
    return allProperties;
  }

  var searchLoading = false.obs;
  var searchProperties = [].obs;

  homeSearchProperties({init}) async {
    List<Property> result = [];
    searchLoading.value = true;
    String val = '';
    if (searchProperties.isEmpty) {
      switch (EditCtrl.homeSearch.text.toLowerCase()) {
        case "abuja":
          val = 'Municipal';

          break;
        case "fct":
          val = 'Municipal'; //propCtrl.homeSearchProperties();
          break;
        case "federal capital territory":
          val = 'Municipal'; //propCtrl.homeSearchProperties();
          break;
        case "federal":
          val = 'Municipal'; //propCtrl.homeSearchProperties();
          break;
        default:
          val = EditCtrl.homeSearch.text;
          //propCtrl.homeSearchProperties();
          break;
      }

      var response =
          await Provider().getData("property/search-properties/$val");
      if (response != null) {
        result = (response['properties'] as List)
            .map((e) => Property.fromJson(e))
            .toList();
      }
    }
    searchLoading.value = false;
    searchProperties.value = result;
    searchProperties.refresh();
    return allProperties;
  }

  loadingProperties() {
    return 'loading';
  }

  viewSingleProperty(Property property) {
    homeCtrl.property = property;
    Get.toNamed(RouteStr.webProperty, arguments: {'property': property});
  }

  var mySavedProperties = <Property>[].obs;

  saveProperty(Property property) async {
    homeCtrl.savingProperty.add(property.id);
    if (HomeController.userId == '') {
      Get.toNamed(RouteStr.login);
    } else {
      var response = await Provider()
          .postData("user/save-property", Property.map(id: property.id));
      if (response != null && response.isNotEmpty) {
        mySavedProperties.value = [];
        mySavedProperties.value = (response['properties'] as List)
            .map((e) => Property.fromJson(e))
            .toList();
      }
      if (propCtrl.user.value.savedProperties != null) {
        if (propCtrl.user.value.savedProperties!.contains(property.id)) {
          propCtrl.user.value.savedProperties!.remove(property.id);
        } else {
          propCtrl.user.value.savedProperties!.add(property.id!);
        }
      }

      propCtrl.user.refresh();
      MSG.snackBar(response['message']);
    }

    homeCtrl.savingProperty.remove(property.id);
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  var allP = <Property>[];
  List<Property> featuredProperties = <Property>[];

  Future<List<Property>> fetchFeaturedProperties() async {
    if (featuredProperties.isEmpty) {
      // var response = await Provider().getData("property/featured-properties");
      var response = await Provider().getData("property/get-all");
      if (response != null) {
        for (var e in (response['properties'] as List)) {
          featuredProperties.addIf(
              featuredProperties.length < 1000, Property.fromJson(e));
          /// CHANGED THE ABOVE FROM featuredProperties.addIf(
          ///              featuredProperties.length < 20, Property.fromJson(e));
          ///              TO
          ///              featuredProperties.addIf(
          ///               featuredProperties.length < 10000, Property.fromJson(e));
          globalProperties.add(Property.fromJson(e));
        }
        isFeaturedProperties.value = true;
        featuredProperties.shuffle();
      }
    }
    return featuredProperties;
  }
  List<Property> allproperty = <Property>[];
  Future<List<Property>> fetchAllProperties() async {
    if (allproperty.isEmpty) {
      // var response = await Provider().getData("property/featured-properties");
      var response = await Provider().getData("property/get-all");
      if (response != null) {
        for (var e in (response['properties'] as List)) {
          allproperty.add(Property.fromJson(e));
          globalAllProperties.add(Property.fromJson(e));
        }
        isAll_Properties.value = true;
        allproperty.shuffle();
      }
    }
    return allproperty;
  }

  toggleSelectedFilterBox({required String filter, required String item}) {
    var filterCat = Lst.filterMap[filter]!;
    if (filterCat.contains(item)) {
      filterCat.remove(item);
      if (filterCat.isEmpty) {
        filterCat.add('Any');
      }
    } else {
      if (item == 'Any' && filterCat.isNotEmpty) {
        filterCat.removeRange(0, filterCat.length);
      } else {
        filterCat.remove('Any');
      }
      filterCat.add(item);
    }
    filterCat.refresh();
  }

  void clearFilter() {
    Lst.filterMap.forEach((key, value) {
      value.removeRange(0, value.length);
      value.add('Any');
      value.refresh();
    });
    EditCtrl.priceMin.value.text = '';
    EditCtrl.priceMax.value.text = '';
    EditCtrl.priceMin.refresh();
    EditCtrl.priceMax.refresh();
    EditCtrl.bathsMin.value.text = '';
    EditCtrl.bathsMax.value.text = '';
    EditCtrl.bathsMin.refresh();
    EditCtrl.bathsMax.refresh();
    EditCtrl.roomMax.value.text = '';
    EditCtrl.roomMin.value.text = '';
    EditCtrl.roomMax.refresh();
    EditCtrl.roomMin.refresh();
    EditCtrl.filterState.value.text = '';
    EditCtrl.filterCity.value.text = '';
    EditCtrl.filterLandMark.value.text = '';
    EditCtrl.filterState.refresh();
    EditCtrl.filterCity.refresh();
    EditCtrl.filterLandMark.refresh();
    EditCtrl.filterAmenities.value = ['Any'];
    EditCtrl.filterAmenities.refresh();
  }

  var exploreFilterProperties = <Property>[].obs;
  var showFeatureLoading = true.obs;
  var userFilterData = false.obs;
  var map = <String, String>{};

  void applyFilterParameters() async {
    userFilterData.value = true;
    showFeatureLoading.value = true;
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
    if (Utils.isMobileApp) {
      Get.back();

      exploreFilterProperties.value = [];
      var response =
          await Provider().postData("property/filter-properties", map);
      if (response != null && response.isNotEmpty) {
        exploreFilterProperties.value = (response['properties'] as List)
            .map((e) => Property.fromJson(e))
            .toList();
      }

      showFeatureLoading.value = false;
      exploreFilterProperties.refresh();
    } else {
      showWebFilter.value = false;
      getProperties();
    }
  }

  webNavigateTo(int i) {}

  void selectSingleImage() async {
    if (EditCtrl.image8Lists.isNotEmpty) {
      EditCtrl.image8Lists.removeAt(0);
    }
    EditCtrl.image8Lists.add(await Utils.singleFilePicker());
    EditCtrl.image8Lists.refresh();
  }

  Future submitPropertyReview(propertyId) async {
    EditCtrl.messageErr.value = Val.name(EditCtrl.messageReview.text);
    if (EditCtrl.rating.text.isEmpty) {
      MSG.errorSnackBar('Select a star to rate the user');
    } else if (EditCtrl.messageErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'Message error',
      );
    } else {
      Preloader.show();

      var data = Property.map(
        id: propertyId,
        rating: EditCtrl.rating.text,
        message: EditCtrl.messageReview.text,
      );
      var response =
          await Provider().postData("user/review-property/$propertyId", data);
      if (response != null) {
        Preloader.hide();
        //if (property.user!.settings!.inAppAlert.isTrue) {
          await sendPushNotification(
              property.user!.id.toString(),
              "You just got a review on a property you uploaded",
              EditCtrl.messageReview.text,
              'Review_Notification');
          EditCtrl.messageReview.text = '';
          if (Utils.isMobileApp) Get.back();
          MSG.snackBar('Review submitted successfully');
        // } else {
        //   EditCtrl.messageReview.text = '';
        //   if (Utils.isMobileApp) Get.back();
        //   MSG.snackBar('Review submitted successfully');
        // }
      }
    }
  }

  Future submitFlagInappropriate(propertyId) async {
    EditCtrl.nameErr.value = Val.name(EditCtrl.name.text);
    EditCtrl.phoneErr.value = Val.phone(EditCtrl.phone.text);
    EditCtrl.emailErr.value = Val.email(EditCtrl.email.text);
    EditCtrl.messageErr.value = Val.name(EditCtrl.message.text);
    print("Hello " + EditCtrl.nameErr.value);

    if (EditCtrl.nameErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'Name error',
      );
    } else if (EditCtrl.emailErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        EditCtrl.emailErr.value,
      );
    } else if (EditCtrl.phoneErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        EditCtrl.phoneErr.value,
      );
    } else if (EditCtrl.messageErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'Message error',
      );
    } else {
      Preloader.show();

      var data = Property.map(
        id: propertyId,
        message: EditCtrl.message.text,
        phone: EditCtrl.phone.text,
        email: EditCtrl.email.text,
        name: EditCtrl.name.text,
      );
      var response = await Provider()
          .postData("user/flag-inappropriate-property/$propertyId", data);
      if (response != null) {
        EditCtrl.message.text = '';
        EditCtrl.phone.text = '';
        EditCtrl.email.text = '';
        EditCtrl.name.text = '';
        Preloader.hide();
        Get.back();
        MSG.snackBar('Submitted successfully');
      }
    }
  }

  Future submitRequestATour(propertyId) async {
    EditCtrl.nameErr.value = Val.name(EditCtrl.name.text);
    EditCtrl.phoneErr.value = Val.phone(EditCtrl.phone.text);
    print("Hello " + EditCtrl.nameErr.value);
    EditCtrl.emailErr.value = Val.email(EditCtrl.email.text);
    EditCtrl.messageErr.value = Val.name(EditCtrl.messageTour.text);

    if (EditCtrl.nameErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'Name error',
      );
    } else if (EditCtrl.emailErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        EditCtrl.emailErr.value,
      );
    } else if (EditCtrl.phoneErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        EditCtrl.phoneErr.value,
      );
    } else if (EditCtrl.messageErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'Message should be above 3 character',
      );
    } else {
      Preloader.show();

      var data = Property.map(
        id: propertyId,
        message: EditCtrl.messageTour.text,
        phone: EditCtrl.phone.text,
        email: EditCtrl.email.text,
        name: EditCtrl.name.text,
      );
      var response =
          await Provider().postData("user/request-a-tour/$propertyId", data);
      if (response != null) {
        //if (property.user!.settings!.inAppAlert.isTrue&&property.user!.settings!.requestTourAlert.isTrue) {

          await sendPushNotification(
            property.user!.id.toString(),
            EditCtrl.name.text+" Requested a tour on a property you uploaded",
            EditCtrl.messageTour.text,
            'Request_Tour_Notification');
        EditCtrl.messageTour.text = '';
        EditCtrl.phone.text = '';
        EditCtrl.email.text = '';
        EditCtrl.name.text = '';
        Preloader.hide();
        if (Utils.isMobileApp) Get.back();

        MSG.snackBar('Submitted successfully');
      // }else{
      //     EditCtrl.messageTour.text = '';
      //     EditCtrl.phone.text = '';
      //     EditCtrl.email.text = '';
      //     EditCtrl.name.text = '';
      //     Preloader.hide();
      //     if (Utils.isMobileApp) Get.back();
      //
      //     MSG.snackBar('Submitted successfully');
      //   }
      }
    }
  }

  var heroImage = 'assets/images/hero1.jpg'.obs;

  late Timer messageTimer;

  int iM = 0;

  animateHomeHeroImage({bool stopTimer = false}) {
    if (!Utils.isMobileApp) {
      if (stopTimer) {
        messageTimer.cancel();
      } else {
        var images = [
          'assets/images/home_bg1.jpg',
          'assets/images/welcome3.jpg',
          'assets/images/welcome2.jpg',
          'assets/images/room4.jpg',
          'assets/images/hero1.jpg',
        ];
        messageTimer =
            Timer.periodic(const Duration(seconds: 6), (Timer timer) {
          homeCtrl.heroImage.value = images[iM % 5];
          iM++;
          dnd(iM % 4);
        });
      }
    }
  }

  deleteAccount() async {
    errorDialog(
      'Are you sure you want to DELETE your account?',
      title: 'DELETE ACCOUNT',
      onTapContinue: deleteUserAccount,
      btnContinue: 'Delete Account',
      showButtons: true,
    );
  }

  deleteUserAccount() async {
    Preloader.show();
    var response = await Provider().postData("user/delete-account", User.map());
    if (response != null) {
      logout();
      MSG.snackBar('Account Deleted');
    } else {
      Get.back();
    }
  }
}
