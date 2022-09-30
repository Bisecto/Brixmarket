import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setPathUrlStrategy();
  if (Utils.userFirebase) {
    await Firebase.initializeApp();
  }
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
  runApp(const Directionality(textDirection: TextDirection.ltr, child: MyApp()));
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, constraints, orientation) {
      return GetMaterialApp(
        title: 'Brix Market',
        textDirection: TextDirection.ltr,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Pallet.secondaryColor,
          primarySwatch: Colors.pink,
        ),
        // home: Utils.isMobileApp ? const SplashScreen() : HomePage(),
        // initialRoute: Utils.isMobileApp ? regBasicInfoPage : homePage,
        initialRoute: Utils.isMobileApp ? RouteStr.mobileSplashscreen : RouteStr.webHome,
        getPages: Utils.isMobileApp ? mobileRoutes : webRoutes,
      );
    }));
  }
}
