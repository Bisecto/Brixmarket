import 'dart:io';

import 'package:brixmarket/view/screens/mobile/single_property_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_strategy/url_strategy.dart';

import 'config/route.dart';
import 'config/theme/color.dart';
import 'controllers/create_property_controller.dart';
import 'controllers/dashboard_controller.dart';
import 'controllers/mobile_app_controllers/accout_page_controller.dart';
import 'controllers/mobile_app_controllers/homepage_controller.dart';
import 'controllers/mobile_app_controllers/property_details_controller.dart';
import 'controllers/property_controller.dart';
import 'controllers/terms_controller.dart';
import 'res/strings.dart';
import 'utils/utils.dart';
import 'package:flutter/foundation.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'id', 'name',
    importance: Importance.high, playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _FirebaseMessagingBacground(RemoteMessage message) async {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.deepOrange,
  // ));deepOrange

}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    if(kIsWeb){
      await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBMohxojVx0jaut5qxWyuzul5_kwExNXuw",
            authDomain: "brimarket-3e1d9.firebaseapp.com",
            projectId: "brimarket-3e1d9",
            storageBucket: "brimarket-3e1d9.appspot.com",
            messagingSenderId: "591770978937",
            appId: "1:591770978937:web:dfd865441b80e09c86e2a8",
            measurementId: "G-5MFHT3RCLW"),
      );
    }else{
      await Firebase.initializeApp();

    }

  setPathUrlStrategy();

  Get.put(TermsController());
  Get.put(AccountPageController());
  Get.put(CreatePropertyCtrl());
  Get.put(PropCtrl(), tag: 'home', permanent: true);
  Get.put(DashboardController());
  Get.put(MobileHomeController());
  Get.put(PropertyDetailsController(), permanent: true);

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message.data}');
  //
  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}');
  //   }
  // });
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onBackgroundMessage(_FirebaseMessagingBacground);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(
      const Directionality(textDirection: TextDirection.ltr, child: MyApp()));
}

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   description: 'This channel is used for important notifications.', // description
//   importance: Importance.max,
// );
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//
//   print("Handling a background message: ${message.messageId}");
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void Dynamic() async {
    FirebaseDynamicLinks.instance.onLink;

    final PendingDynamicLinkData? data =
    await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      String property_id = deepLink.queryParameters['id']?? 'pro';

      if (property_id != 'pro') {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                Single_Property(property_id: property_id,property_tiitle: 'Brixmarket',)));
      } else {
        return;
      }
    }
  }
  void initDynamicLinks(BuildContext context) async {

    final PendingDynamicLinkData? data =
    await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      final Uri deeplink = data.link;
      //String categorySlug = deeplink.queryParameters['categorySlug'] ?? 'Empty';
      //print('Category SLug $categorySlug');
      String property_id = deeplink.queryParameters['id'] ?? 'pro';

      if (property_id != 'pro') {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                Single_Property(property_id: property_id,property_tiitle: 'Brixmarket',)));
      } else {
        return;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    if(Utils.isMobileApp){
      FirebaseMessaging.instance.subscribeToTopic("AdminNotification");
      if(Platform.isAndroid){
        initDynamicLinks(context);}else{
        Dynamic();
      }
    }
  }
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, constraints, orientation) {
      return GetMaterialApp(
        title: 'Brix Market',
        textDirection: TextDirection.ltr,
        debugShowCheckedModeBanner: false,
        navigatorObservers: [observer],
        theme: ThemeData(
          primaryColor: Pallet.secondaryColor,
          primarySwatch: Colors.pink,
        ),
        // home: Utils.isMobileApp ? const SplashScreen() : HomePage(),
        // initialRoute: Utils.isMobileApp ? regBasicInfoPage : homePage,
        initialRoute:
            Utils.isMobileApp ? RouteStr.mobileSplashscreen : RouteStr.webHome,
        getPages: Utils.isMobileApp ? mobileRoutes : webRoutes,
      );
    }));
  }
}
