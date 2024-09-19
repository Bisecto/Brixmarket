import 'dart:async';
import 'dart:math';

import 'package:brixmarket/controllers/edit_controller.dart';
import 'package:brixmarket/core/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:restart_app/restart_app.dart';

import '../core/dialogs.dart';
import '../core/preloader.dart';
import '../models/insight_model.dart';
import '../models/media_model.dart';
import '../models/property_model.dart';
import '../res/strings.dart';
import '../services/provider.dart';
import '../utils/utils.dart';
import '../view/screens/create_property/create_property_widges.dart';
import '../view/screens/mobile/my_ads_page.dart';
import 'instance.dart';
import 'package:http/http.dart' as http;

class CreatePropertyCtrl extends GetxController {
  late PageController controller;
  late PageController cPPageController;
  final createPropScrollCtrl = ScrollController();
  final createPropScrollCtrlA = ScrollController();
  final scrollController2 = ScrollController();
  final scrollController2a = ScrollController();
  final scrollController3 = ScrollController();
  final scrollController3a = ScrollController();
  final scrollController4 = ScrollController();
  final scrollController4a = ScrollController();
  final scrollController5 = ScrollController();
  final scrollController5a = ScrollController();
  final scrollController6 = ScrollController();
  final scrollController6a = ScrollController(initialScrollOffset: 0.0);

  var showMyPropertyMenu = false.obs;
  var showMyPropertyMenuIndex = 0.obs;
  var isEdit = false;

  static const historyLength = 5;

  final oCcy = NumberFormat("#,##0.00", "en_US");
  var accountIndex = 0.obs;

  var createPropPageIndex = 0.obs;
  var sideNavIndex = 0.obs;
  var isWebEdit = false;

  onSelected(int index) {
    sideNavIndex.value = index;
    if (index == 1) {
      EditCtrl.disposeControllers();
    }
    sideNavIndex.refresh();
  }

  bool propertyListData = false;
  bool pricingListData = false;
  bool isChange = false;
  bool isIdentity = false;
  var changePassword = false.obs;

  @override
  void onInit() {
    controller = PageController(initialPage: 0);
    cPPageController = PageController(initialPage: 0);
    super.onInit();
  }

  backToPrevious() {
    createPropScrollCtrl.jumpTo(0);
    if (createPropPageIndex.value > 0) {
      createPropPageIndex.value--;
    }
    cPPageController.animateToPage(cPPageController.page!.toInt() - 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  ToSpecifiedpage() {
    createPropScrollCtrl.jumpTo(0);
    if (createPropPageIndex.value < 5) {
      createPropPageIndex.value++;
    }
    cPPageController.animateToPage(cPPageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  ToLastpage() {
    createPropScrollCtrl.jumpTo(0);
    if (createPropPageIndex.value < 5) {
      createPropPageIndex.value = 5;
    }
    cPPageController.animateToPage(5,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  Toinitial() {
    createPropPageIndex.value = 0;
  }

  bool saveToDraft = false;

  gotoNext({required int pageIndex}) async {
    ///(pageIndex);
    createPropScrollCtrl.jumpTo(0);
    if (saveToDraft == true) {
      MSG.snackBar('Property saved to my draft');
      saveToDraft = false;
      createPropPageIndex.value = 1;
      sideNavIndex.value = 2;
      sideNavIndex.refresh();
      createPropPageIndex.refresh();
      EditCtrl.disposeControllers();
      if (!Utils.isMobileApp) {
        onInit();

        // }
        //DashboardPage
        // Navigator.pushReplacement(
        //   context!,
        //   MaterialPageRoute(builder: (context) =>  DashboardPage()),
        // );
        Property.map(id: '');
        EditCtrl.disposeControllers();
        Restart.restartApp();
      }
    } else {
      await cPPageController.nextPage(
          //cPPageController.page!.toInt() + 1,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn);
      createPropPageIndex.value = pageIndex;
    }
  }

  String generateRandomString(int lengthOfString) {
    final random = Random();
    const allChars =
        'AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL234567890';

    final randomString = List.generate(lengthOfString,
        (index) => allChars[random.nextInt(allChars.length)]).join();
    return randomString;
  }

  submitPropertyDescription() async {
    if (EditCtrl.reference.text.isEmpty) {
      EditCtrl.reference.text = generateRandomString(5) +
          user.id!.substring(0, 4) +
          generateRandomString(5);
    } else {
      EditCtrl.reference.text = EditCtrl.reference.text.toString();
    }
    if (EditCtrl.title.text.isEmpty) {
      MSG.errorSnackBar(
        'Property title field is required',
      );
    } else if (EditCtrl.description.text.isEmpty) {
      MSG.errorSnackBar(
        'Property description field is required',
      );
    } else if (EditCtrl.price.text.isEmpty) {
      MSG.errorSnackBar(
        'Property price filed is required',
      );
    } else if (EditCtrl.priceDuration.value.text.isEmpty) {
      MSG.errorSnackBar(
        'Price duration field is required',
      );
    } else if (EditCtrl.category.value.text.isEmpty) {
      MSG.errorSnackBar(
        'Property category field is required',
      );
    } else if (EditCtrl.type.value.text.isEmpty) {
      MSG.errorSnackBar(
        'Property type field is required',
      );
    } else if (EditCtrl.status.value.text.isEmpty) {
      MSG.errorSnackBar(
        'New or Existing field is required',
      );
    } else {
      Preloader.show();
      ///(EditCtrl.reference.text);
      Map<String, dynamic> data = Property.map(
        title: EditCtrl.title.text,
        reference: EditCtrl.reference.text,
        description: EditCtrl.description.text,
        price: EditCtrl.price.text,
        priceDuration: EditCtrl.priceDuration.value.text,
        category: EditCtrl.category.value.text,
        type: EditCtrl.type.value.text,
        status: EditCtrl.status.value.text,
      );
      ///(data);
       await Provider().postData("property/store", data);
      var response = await Provider().postData("property/store", data);
      ///(123456);
      ///(response);
      ///(123456);
      if (response != null) {
        ///(response);
        propCtrl.property = Property.fromJson(response);
        Preloader.hide();
        gotoNext(pageIndex: 1);
        getAmenities();
        getFeatures();
      } else {
        ///(response);
        Preloader.hide();
        MSG.errorSnackBar('There was a problem uploading product details',
            title: 'Message');
      }
    }
  }

  selectPropertyImages() async {
    var uInt8List = await Utils.filesPicker();
    for (var uInt in uInt8List) {
      EditCtrl.image8Lists.addIf(uInt != null, uInt!);
    }
    EditCtrl.image8Lists.refresh();
  }

  removeImage(file) {
    EditCtrl.image8Lists.value.remove(file);
    EditCtrl.image8Lists.refresh();
  }

  submitPropertyMedia() async {
    if (EditCtrl.image8Lists.length < 3) {
      MSG.errorSnackBar(
        'Image uploaded is not up to 3',
      );
    } else {
      Preloader.show(msg: 'Images uploading..... please wait');
      var data = Property.map();
      var response = await Provider().postFiles(
          "property/store-media/${data['property']}",
          EditCtrl.image8Lists.value,
          data: data);
      if (response != null) {
        propCtrl.property = Property.fromJson(response);
        Preloader.hide();
        gotoNext(pageIndex: 2);
      } else {
        //gotoNext(pageIndex: 2);
        ///('1234567890');
        ///(response);
        Preloader.hide();
        MSG.errorSnackBar(
            'Image was not Uploaded. Please check your connections.',
            title: 'Message');
        //Preloader.hide();
      }
    }
  }

  submitPropertyLocation() async {
    bool isValidData = false;
    if (EditCtrl.address.text.isEmpty) {
      MSG.errorSnackBar(
        'Address of property is required',
      );
    } else if (EditCtrl.state.value.text.isEmpty) {
      MSG.errorSnackBar(
        'State of property is required',
      );
    } else if (EditCtrl.city.value.text.isEmpty) {
      MSG.errorSnackBar(
        'City of property is required',
      );
    } else if (EditCtrl.longitude.text.isNotEmpty) {
      if (EditCtrl.longitude.text.isNum) {
        isValidData = true;
      } else {
        MSG.errorSnackBar(
          'Invalid longitude value',
        );
      }
    } else if (EditCtrl.latitude.text.isNotEmpty) {
      if (EditCtrl.longitude.text.isNum) {
        isValidData = true;
      } else {
        MSG.errorSnackBar(
          'Invalid latitude value',
        );
      }
    } else {
      isValidData = true;
    }
    if (isValidData) {
      Preloader.show();
      Map<String, dynamic> data = Property.map(
        address: EditCtrl.address.text,
        city: EditCtrl.city.value.text,
        state: EditCtrl.state.value.text,
        landmarks: EditCtrl.landmarks.value.text,
        longitude: EditCtrl.longitude.value.text,
        latitude: EditCtrl.latitude.value.text,
      );

      var response = await Provider()
          .postData("property/store-location/${data['property']}", data);
      if (response != null) {
        propCtrl.property = Property.fromJson(response);
        Preloader.hide();
        getAmenities();
        getFeatures();
        gotoNext(pageIndex: 3);
      } else {
        Preloader.hide();
        MSG.errorSnackBar('Problem Occurred while Uploading product location',
            title: 'Message');
        Preloader.hide();
      }
    }
  }

  submitPropertyMoreDetails() async {
    // bool isValidData = true;
    int i = 0;
    Map<String, dynamic> map = {};
    for (var ctrl in EditCtrl.features) {
      //var key = EditCtrl.ctrlListKeys[i++];
      // if (ctrl.value.text.trim().isEmpty && isValidData) {
      //isValidData = false;
      //MSG.errorSnackBar(
      //   '${key.text} field is required',
      //  );
      //} else {
      map['features[${EditCtrl.features[i++]}]'] = ctrl;
      //ctrl.value.text.trim();
      //}
    }
    // if (isValidData) {
    Preloader.show();
    Map<String, dynamic> data = Property.map();
    data.addAll(map);
    var response = await Provider()
        .postData("property/store-features/${data['property']}", data);
    if (response != null) {
      propCtrl.property = Property.fromJson(response);
      Preloader.hide();
      gotoNext(pageIndex: 4);
    }
    // }
  }

  submitPropertyAmenities() async {
    int i = 0;
    Map<String, dynamic> map = {};
    for (var amenity in EditCtrl.amenities) {
      map['amenities[${i++}]'] = amenity;
    }
    Preloader.show();
    Map<String, dynamic> data = Property.map();
    data.addAll(map);

    var response = await Provider()
        .postData("property/store-amenities/${data['property']}", data);
    if (response != null) {
      propCtrl.property = Property.fromJson(response);
      Preloader.hide();
      gotoNext(pageIndex: 5);
    }
  }

  submitPropertyContact() async {
    if (!EditCtrl.email.text.isEmail) {
      MSG.errorSnackBar(
        'Email address is not valid',
      );
    } else if (!Utils.isPhoneNumber(EditCtrl.phone.text)) {
      MSG.errorSnackBar(
        'Phone number not valid',
      );
    } else if (EditCtrl.userAddress.text.isEmpty) {
      MSG.errorSnackBar(
        'Address field is required',
      );
    } else {
      Preloader.show();
      Map<String, dynamic> data = Property.map(
        address: EditCtrl.userAddress.text,
        email: EditCtrl.email.text,
        phone: EditCtrl.phone.text,
        whatsAppNumber: EditCtrl.whatsAppNumber.text,
      );

      var response = await Provider()
          .postData("property/store-user-contact/${data['property']}", data);
      if (response != null) {
        propCtrl.property = Property.fromJson(response);
        Preloader.hide();
        EditCtrl.reference.text = '';
        MSG.snackBar('Property has been created successfully');
        EditCtrl.disposeControllers();
        if (Utils.isMobileApp) {
          cPropCtrl.createPropPageIndex.value = 0;
          Get.off(() => const MyAdsPage());
        } else {
          cPropCtrl.createPropPageIndex.value = 0;
          cPropCtrl.createPropPageIndex.refresh();
          sideNavIndex.value = 2;
          sideNavIndex.refresh();
          //onInit();
          EditCtrl.disposeControllers();
          Restart.restartApp();
        }
      }
    }
  }

  // String token = '';

  // authToken() async {
  //   token = await SharedPref.getString('token');
  // }

  Datum? insight;

  Future<Datum?> getInsight() async {
    var response = await Provider().postData(
      "property/get-insight",
      {},
    );

    if (response != null) {
      insight = Datum.fromJson(response);

      return insight;
    }
    return insight;
  }

  var myProperties = <Property>[].obs;
  var allProperties = <Property>[].obs;
  var mySoldProperties = <Property>[].obs;
  var myDraftProperties = <Property>[].obs;
  var mySuspendedProperties = <Property>[].obs;
  var myPublishedProperties = <Property>[].obs;
  int allPropertiesPage = 0;
  int mySoldPropertiesPage = 0;
  int myDraftPropertiesPage = 0;
  int mySuspendedPropertiesPage = 0;
  int myPublishedPropertiesPage = 0;

  //StreamController<UserProperty> My_property_streamController=StreamController();

  // Future getUserProperty(int page,{required String property_state}) async {
  //
  //   var Url = Uri.parse('https://api.brixmarket.com/property/get-user-properties?page=$page');
  //   var body={
  //     'userId': user.id,
  //     'property_state': property_state
  //   };
  //   var headers = {
  //     'Authorization': 'Bearer kOoT3jVQAK73GAsRrftjnnXzXS6o7lfLi9iMENmJOx1nYbDPgaiqk7vs5lEpfXg4LMF+wFZWWommwTf1CrqTU1ZZz/my4WZxuReq/uDdBIs=dodroosos',
  //     'Cookie': 'PHPSESSID=efe427461bf8353458f882c0d7143ce3'
  //   };
  //   final res = await http.post(Url,headers: headers,body: body);
  //   final dataBody = await jsonDecode(res.body);
  //   for (var e in dataBody['properties']) {
  //     myProperties.add(Property.fromJson(e));
  //   }
  //   // //UserProperty userProperty=UserProperty.fromJson(dataBody);
  //   // ///('1');
  //   // ///(dataBody['data']);
  //   // //allProperties.add(dataBody['data']);
  //   // ///('1');
  //   // // FilterModel filterModel = FilterModel.fromJson(dataBody);
  //   // //myProperties.add(userProperty.data.property);
  //   // //My_property_streamController.add(userProperty);
  //   // return dataBody;
  // }

  Future getAllMyProperties(int page) async {
    var map = {'userId': user.id.toString(), 'property_state': 'All'};

    var response = await Provider()
        .postData("property/get-user-properties?page=$page", map);
    // ///(response);
    if (response != null) {
      myProperties.value = [];

      if (response != null && response.isNotEmpty) {
        allPropertiesPage = response['pages'];
        for (var e in response['properties']) {
          myProperties.add(Property.fromJson(e));

        }
      }
      // }
    }
    return myProperties;
  }

  Future getAllPublishedProperties(int page) async {
    var map = {'userId': user.id, 'property_state': 'Published'};
    var response = await Provider()
        .postData("property/get-user-properties?page=$page", map);
    ///(response);
    if (response != null) {
      myPublishedProperties.value = [];

      if (response != null && response.isNotEmpty) {
        myPublishedPropertiesPage = response['pages'];

        for (var e in response['properties']) {
          myPublishedProperties.add(Property.fromJson(e));
        }
      }
      // }
    }
    return myPublishedProperties;
  }

  Future getAllDraftProperties(int page) async {
    var map = {'userId': user.id, 'property_state': 'Draft'};
    var response = await Provider()
        .postData("property/get-user-properties?page=$page", map);
    ///(response);
    if (response != null) {
      myDraftProperties.value = [];

      if (response != null && response.isNotEmpty) {
        myDraftPropertiesPage = response['pages'];

        for (var e in response['properties']) {
          myDraftProperties.add(Property.fromJson(e));
        }
      }
      // }
    }
    return myDraftProperties;
  }

  Future getAllSoldProperties(int page) async {
    var map = {'userId': user.id, 'property_state': 'Sold'};
    var response = await Provider()
        .postData("property/get-user-properties?page=$page", map);
    ///(response);
    if (response != null) {
      mySoldProperties.value = [];

      if (response != null && response.isNotEmpty) {
        mySoldPropertiesPage = response['pages'];
        for (var e in response['properties']) {
          mySoldProperties.add(Property.fromJson(e));
        }
      }
      // }
    }
    return mySoldProperties;
  }

  Future getAllSuspendedProperties(int page) async {
    var map = {'userId': user.id, 'property_state': 'Suspended'};
    var response = await Provider()
        .postData("property/get-user-properties?page=$page", map);

    if (response != null) {
      mySuspendedProperties.value = [];

      if (response != null && response.isNotEmpty) {
        mySuspendedPropertiesPage = response['pages'];

        for (var e in response['properties']) {
          mySuspendedProperties.add(Property.fromJson(e));
        }
      }
      // }
    }
    return mySuspendedProperties;
  }

  Future getMyProperties(int page, {required String property_state}) async {
    var map = {'userId': user.id, 'property_state': property_state};
    var response = await Provider()
        .postData("property/get-user-properties?page=$page", map);
    ///(response);
    if (response != null) {
      myProperties.value = [];
      mySoldProperties.value = [];
      myDraftProperties.value = [];
      mySuspendedProperties.value = [];
      myPublishedProperties.value = [];
      if (response != null && response.isNotEmpty) {
        for (var e in response['properties']) {
          mySoldProperties.addIf(
              e['publish_state'] == 'Sold', Property.fromJson(e));
          myDraftProperties.addIf(
              e['publish_state'] == 'Draft', Property.fromJson(e));
          mySuspendedProperties.addIf(
              e['publish_state'] == 'Suspended', Property.fromJson(e));
          myPublishedProperties.addIf(
              e['publish_state'] == 'Published', Property.fromJson(e));
          myProperties.add(Property.fromJson(e));
        }
      }
      // }
    }
    return myProperties;
  }

  Future changePublishState({property, state}) async {
    cPropCtrl.showMyPropertyMenu.value = false;
    var map = Property.map(id: property.id, publishState: state);
    var response = await Provider()
        .postData("property/change-property-publish-state", map);
    if (response != null) {
      if (response != null && response.isNotEmpty) {
        dnd(response['properties'].length);
        myProperties.value = [];
        mySoldProperties.value = [];
        myDraftProperties.value = [];
        mySuspendedProperties.value = [];
        myPublishedProperties.value = [];
        for (var e in response['properties']) {
          mySoldProperties.addIf(
              e['publish_state'] == 'Sold', Property.fromJson(e));
          myDraftProperties.addIf(
              e['publish_state'] == 'Draft', Property.fromJson(e));
          mySuspendedProperties.addIf(
              e['publish_state'] == 'Suspended', Property.fromJson(e));
          myPublishedProperties.addIf(
              e['publish_state'] == 'Published', Property.fromJson(e));
          myProperties.add(Property.fromJson(e));
        }
        myProperties.refresh();
        mySoldProperties.refresh();
        myDraftProperties.refresh();
        mySuspendedProperties.refresh();
        myPublishedProperties.refresh();
      }
    }
  }

  List? amenities;

  Future getAmenities({all = false}) async {
    amenities = [];
    if (amenities!.isEmpty && EditCtrl.category.value.text.isNotEmpty || all) {
      String category = all ? 'all' : EditCtrl.category.value.text;
      await Provider()
          .postData("property/get-amenities/${EditCtrl.category.value.text}",
              Property.map())
          .then((value) => amenities = value);
    }
    return amenities ?? [];
  }

  completeDraftProperty(Property property) async {
    cPropCtrl.showMyPropertyMenu.value = false;
    cPropCtrl.createPropPageIndex.value = 0;
    Preloader.show(msg: 'Please wait while we get all saved data.');
    EditCtrl.title.text = property.title ?? '';
    EditCtrl.reference.text = property.reference!;
    EditCtrl.description.text = property.description ?? '';
    ///(property.title);
    ///(property.reference);
    ///(property.description);
    ///(property.price);
    ///(property.priceDuration);
    ///(property.category);
    ///(property.type);
    ///(property.status);

    EditCtrl.price.text = property.price.toString();
    EditCtrl.priceDuration.value.text = property.priceDuration!;
    EditCtrl.category.value.text = property.category!;
    EditCtrl.type.value.text = property.type!;
    EditCtrl.status.value.text = property.status!.toString();

    if (property.media != null) {
      // EditCtrl.imageFiles.value = [];
      EditCtrl.image8Lists.value = [];
      for (var element in property.media!) {
        // EditCtrl.imageFiles.add(File.fromUri(Uri.parse('$propertyImgPath${element.media}')));
        EditCtrl.image8Lists
            .add(await Utils.imgUrlToFile('$propertyImgPath${element.media}'));
      }
      EditCtrl.imageFiles.refresh();
    }

    if (property.location != null) {
      EditCtrl.address.text = property.location!.address ?? '';
      EditCtrl.city.value.text = property.location!.city ?? '';
      EditCtrl.state.value.text = property.location!.state ?? '';
      EditCtrl.landmarks.value.text = property.location!.landmarks ?? '';
      EditCtrl.longitude.text = property.location!.longitude ?? '';
      EditCtrl.latitude.text = property.location!.latitude ?? '';
    }

    if (property.features != null) {
      //var featuresData = property.features;
      //var feature = {};
      for (var e in property.features!) {
        // if (feature[e.feature] == null) {
        //   feature[e.feature] = [e.featureValue.toString()];
        // } else {
        //   feature[e.feature].add(e.featureValue.toString());
        // }
        // features ??= [];
        //features!.add(e.toJson());
        EditCtrl.features.add(e.feature);
      }
      EditCtrl.features.refresh();
      // feature.entries.map((feature) {
      //EditCtrl.features.add(e.feature);
      //EditCtrl.ctrlListKeys.add(TextEditingController(text: feature.key));
      // });
    }

    if (property.amenities != null) {
      for (var e in property.amenities!) {
        EditCtrl.amenities.add(e.amenity);
      }
      EditCtrl.amenities.refresh();
    }

    if (property.contact != null) {
      EditCtrl.userAddress.text = property.contact!.address ?? '';
      EditCtrl.email.text = property.contact!.address ?? '';
      EditCtrl.phone.text = property.contact!.address ?? '';
    }
    if (Utils.isMobileApp) {
      Preloader.hide();
      Get.toNamed(RouteStr.mobileCreateProperty);
    } else {
      Preloader.hide();
      sideNavIndex.value = 1;
      sideNavIndex.refresh();
    }
  }
}
