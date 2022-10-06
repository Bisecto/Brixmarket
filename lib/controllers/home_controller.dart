import 'package:brixmarket/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_io/io.dart';

import '../core/dialogs.dart';
import '../core/preloader.dart';
import '../models/notification.dart';
import '../models/property_model.dart';
import '../models/upgrade_plans.dart';
import '../models/user_model.dart';
import '../res/lists.dart';
import '../res/strings.dart';
import '../services/provider.dart';
import '../utils/shared_preferences.dart';
import '../utils/validations.dart';
import 'edit_controller.dart';
import 'instance.dart' as inst;
import 'instance.dart';
import 'mixin/auth_mixin.dart';
import 'mixin/chat_mixin.dart';
import 'mixin/reset_passwor_mixin.dart';
import 'mobile_app_controllers/homepage_controller.dart';

class HomeController extends GetxController with Auth, Chat, ResetPassword {
  late PageController controller;
  static String _userId = '';
  static var isLogin = false.obs;
  var savingProperty = [].obs;
  var user = User().obs;
  var tmpUser = User().obs;
  static String tmpUserId = '';
  static String get userId => _userId;
  var isUser = false;
  var isAgent = false;
  var isPremium = false;
  var currentLocation = ''.obs;

  List<String> properties = [
    'Bundalow',
    'Plots of Land',
    'Flat',
    'Master House',
    'Landed Properites',
    'Lassive Lands',
    'Plenty Properties',
    'House on the rock',
    'Real Estate'
  ];

  var mainData = [].obs;

  void filterProduct(String search) {
    var results = [];

    if (search.isEmpty) {
      results = [];
    } else {
      results = properties.where((element) => element.toString().toLowerCase().contains(search.toLowerCase())).toList();
    }

    mainData.value = results;
  }

  logout() async {
    user.value = User();
    _userId = '';
    isLogin.value = false;
    await SharedPref.remove('userId');
    propCtrl.mySavedProperties.clear();
    if (Utils.isMobileApp) {
      Get.find<MobileHomeController>().bottomNavIndex.value = 0;
      Get.offAndToNamed(RouteStr.mobileLanding);
    } else {
      Preloader.show();
      Future.delayed(const Duration(seconds: 2), () {
        Get.back();
        Preloader.hide();
        Get.toNamed(RouteStr.webHome);
      });
    }
  }

  Future loginUser(User? userObj) async {
    if (userObj == null) {
      _userId = await SharedPref.getString('userId');

      if (_userId.isNotEmpty && user.value.id == null) {
        var response = (await Provider().postData("login/user", User.map()));
        if (response != null) {
          loginUser(User.fromJson(response));
          FirebaseMessaging.instance.subscribeToTopic(_userId);
          print('$_userId*******00000000001231234567812345678`12345678**************');
        }
      }
    } else {
      if (userObj.id != null) {
        user.value = userObj;
        _userId = userObj.id!;
        isLogin.value = true;
        await SharedPref.putString('userId', _userId);
        setUserType();
      }
    }
    inst.reInitInstance();
  }

  Future tmpLogin(User? userObj) async {
    if (userObj == null) {
      tmpUserId = await SharedPref.getString('tmpUserId');

      if (tmpUserId.isNotEmpty && tmpUser.value.id == null) {
        var response = (await Provider().postData("login/user", User.map(userId: tmpUserId)));
        if (response != null) {
          tmpLogin(User.fromJson(response));
        }
      }
    } else {
      if (userObj.id != null) {
        tmpUser.value = userObj;
        tmpUserId = userObj.id!;
        await SharedPref.putString('tmpUserId', tmpUserId);
      }
    }
  }

  setUserType() {
    isUser = !(user.value.isAgent ?? false) || !(user.value.isPremium ?? false);
  }

  openDashboard(index) {
    cPropCtrl.onSelected(index);
    Get.toNamed(RouteStr.webDashboard);
  }

  init() async {
    await loginUser(null);
    await tmpLogin(null);
    await getUpgradePlans();
    if (kIsWeb && !Get.currentRoute.toLowerCase().contains('terms')) {
      Get.toNamed(RouteStr.webHome);
    }
    homeCtrl.animateHomeHeroImage();
    propCtrl.fetchFeaturedProperties();
    await propCtrl.getSavedProperties();
    await propCtrl.getAmenitiesWeb();
    await fetchFAQs();
  }

  List faqs = [];
  Future<List> fetchFAQs() async {
    faqs = [];
    if (faqs.isEmpty) {
      var response = await Provider().postData("user/faqs", Property.map());
      if (response != null) {
        faqs = (response as List).map((e) => FAQ.fromJson(e)).toList();
      }
    }
    return faqs;
  }

  bool isGoBack = false;
  @override
  void onInit() {
    var makeSecondCall = true;
    init().whenComplete(() {
      if (makeSecondCall) {
        makeSecondCall = false;
        if (isLogin.value != true) {
          init().whenComplete(() {});
        }
      }
    });
    // Connectivity().isConnected.listen((connected) {
    //   if (!connected) {
    //     Get.toNamed(noInternet);
    //   } else {
    //     if (isGoBack) Get.back();
    //   }
    // });
    super.onInit();
  }

  getProperties() {}

  @override
  void dispose() {
    // connectionSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  var showTopMsg = true.obs;
  void closeTopMsg() {
    showTopMsg.value = false;
  }

  var highLighted = 'Buy'.obs;
  searchProperty(String s) {
    highLighted.value = s;
  }

  List<UpgradePlan> upgradePlans = [];
  UpgradePlan? selectedUpgradePlan;
  getUpgradePlans() async {
    if (upgradePlans.isEmpty) {
      var response = await Provider().getData("user/fetch-plans");
      if (response != null) {
        upgradePlans = (response as List).map((e) => UpgradePlan.fromJson(e)).toList();
      }
    }
    return upgradePlans;
  }

  shareApp({Property? property}) async {
    await Share.share("https://brixmarket.com/", subject: 'Brixmarket');
    // MSG.snackBar("Successful", title: "Share");
  }

  Future sendFeedback() async {
    EditCtrl.nameErr.value = Val.name(EditCtrl.name.text);
    EditCtrl.phoneErr.value = Val.phone(EditCtrl.phone.text);
    EditCtrl.emailErr.value = Val.email(EditCtrl.email.text);
    EditCtrl.messageErr.value = Val.name(EditCtrl.message.text);

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
        name: EditCtrl.name.text,
        phone: EditCtrl.phone.text,
        email: EditCtrl.email.text,
        message: EditCtrl.message.text,
      );
      var response = await Provider().postData("user/feedback", data);
      if (response != null) {
        Preloader.hide();
        Get.back();
        MSG.snackBar('Message sent');
      }
    }
  }

  Future subscribeToNewsLetter() async {
    EditCtrl.newsLetterEmailErr.value = Val.email(EditCtrl.newsLetterEmail.text);
    if (EditCtrl.newsLetterEmailErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        EditCtrl.newsLetterEmailErr.value,
      );
    } else {
      Preloader.show();

      var data = User.map(
        email: EditCtrl.newsLetterEmail.text,
      );
      var response = await Provider().postData("user/subscribe-to-news-letter", data);
      if (response != null) {
        EditCtrl.newsLetterEmail.text = '';
        Preloader.hide();
        Get.back();
        MSG.snackBar('Message sent');
      }
    }
  }

  Future contactUs() async {
    EditCtrl.nameErr.value = Val.name(EditCtrl.name.text);
    EditCtrl.phoneErr.value = Val.phone(EditCtrl.phone.text);
    EditCtrl.emailErr.value = Val.email(EditCtrl.email.text);
    EditCtrl.subjectErr.value = Val.name(EditCtrl.subject.text);
    EditCtrl.messageErr.value = Val.name(EditCtrl.message.text);

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
    } else if (EditCtrl.subjectErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'Subject error',
      );
    } else if (EditCtrl.messageErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'Message error',
      );
    } else {
      Preloader.show();

      var data = Property.map(
        name: EditCtrl.name.text,
        phone: EditCtrl.phone.text,
        email: EditCtrl.email.text,
        subject: EditCtrl.subject.text,
        message: EditCtrl.message.text,
      );
      var response = await Provider().postData("user/contact-us", data);
      if (response != null) {
        Preloader.hide();
        Get.back();
        EditCtrl.message.clear();
        MSG.snackBar('Message sent');
      }
    }
  }

  List<AppNotification> notifications = [];
  Future getNotifications() async {
    var response = await Provider().postData("user/get-notifications", User.map());
    if (response != null) {
      notifications = (response as List).map((e) => AppNotification.fromJson(e)).toList();
      Provider().postData("user/mark-notifications-as-read", User.map());
    }

    newNotifications.value = 0;
    return notifications.isNotEmpty ? notifications : null;
  }

  var newNotifications = 0.obs;
  Future getNewNotifications() async {
    var response = await Provider().postData("user/get-new-notifications", User.map());
    if (response != null) {
      return response.isEmpty ? null : newNotifications.value = response.length;

    }
    return null;
  }

  loginRequest({request, bool isFunction = true}) {
    if (HomeController.isLogin.value) {
      if (isFunction) {
        request();
      } else {
        request;
      }
    } else {
      Get.toNamed(RouteStr.login);
    }
  }

  firebasePermissionIOS() async {
    if (Platform.isIOS || kIsWeb || Platform.isMacOS) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      dnd('User granted permission: ${settings.authorizationStatus}');
    }
  }
}
