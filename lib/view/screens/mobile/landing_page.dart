import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/controllers/home_controller.dart';
import 'package:brixmarket/controllers/mobile_app_controllers/homepage_controller.dart';
import 'package:brixmarket/res/strings.dart';
import 'package:brixmarket/view/screens/mobile/single_property_page.dart';
import 'package:brixmarket/view/screens/mobile/updateApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../controllers/instance.dart';
import '../../../main.dart';
import '../../../res/lists.dart';
import 'dart:io' show Platform;

import 'chat_page.dart';
import 'home_page.dart';

class MobileLandingPage extends StatefulWidget {
  const MobileLandingPage({Key? key}) : super(key: key);

  @override
  State<MobileLandingPage> createState() => _MobileLandingPageState();
}

class _MobileLandingPageState extends State<MobileLandingPage> {
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
            builder: (context) => Single_Property(
                  property_id: property_id,
                  property_tiitle: 'Brixmarket',
                )));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Testing(
        //               proertyID: property_id,
        //             )));
      } else {
        return;
      }
    }
  }

  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';
  String LatestVersion = '';
  String LatestBuildNumber = '';

  Fetch_App_Details() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  bool isAppUpdated = true;

  showDialo(
    String heading,
    String title,
    String body,
  ) {
    showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      heading,
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // Image.network(
                    //   'https://firebasestorage.googleapis.com/v0/b/brimarket-3e1d9.appspot.com/o/brix-logo-dark.png?alt=media&token=7dac3711-a18b-4a58-ac43-31509362aff7',
                    //   height: 100,width: 100,
                    //   loadingBuilder: (context, child, loadingProgress) {
                    //     if (loadingProgress == null) return child;
                    //
                    //     return const Center(
                    //       child: CircularProgressIndicator(
                    //         strokeWidth: 5,
                    //         backgroundColor: Colors.white,
                    //         valueColor: AlwaysStoppedAnimation<Color>(
                    //             Colors.red),
                    //       ),);
                    //     // You can use LinearProgressIndicator, CircularProgressIndicator, or a GIF instead
                    //   },
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      body,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text(
                            'View',
                            style: TextStyle(color: Colors.green),
                          ),
                          onPressed: () {
                            switch (heading) {
                              case 'Message':
                                homeCtrl.loginRequest(request: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const ChatPage()),
                                  );
                                });

                                break;
                              case 'Review':
                                return;
                              default:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeNotificationsPage()),
                                );
                                break;
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }

  CheckUpdate() async {
    if (Platform.isAndroid) {
      await FirebaseFirestore.instance
          .collection('version')
          .doc('Android-version-Android')
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> data =
              documentSnapshot.data()! as Map<String, dynamic>;

          setState(() {
            LatestVersion = data['version'];
            LatestBuildNumber = data['buildNumber'];
          });
          if (LatestVersion == version) {
            isAppUpdated = true;
          } else if (LatestVersion != version) {
            if (data['isUpdate']) {
              isAppUpdated = false;
            } else {
              isAppUpdated = true;
            }
          } else if (LatestVersion.isEmpty) {
            isAppUpdated = true;
          } else if (LatestVersion.toString() == 'null') {
            isAppUpdated = true;
          } else {
            isAppUpdated = true;
          }
        } else {
          isAppUpdated = true;
        }
      });
    } else if (Platform.isIOS) {
      await FirebaseFirestore.instance
          .collection('version')
          .doc('iOS-version-Ios')
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> data =
              documentSnapshot.data()! as Map<String, dynamic>;

          setState(() {
            LatestVersion = data['version'];
            LatestBuildNumber = data['buildNumber'];
          });
          if (LatestVersion == version) {
            isAppUpdated = true;
          } else if (LatestVersion != version) {
            if (data['isUpdate']) {
              isAppUpdated = false;
            } else {
              isAppUpdated = true;
            }
          } else if (LatestVersion.isEmpty) {
            isAppUpdated = true;
          } else if (LatestVersion.toString() == 'null') {
            isAppUpdated = true;
          } else {
            isAppUpdated = true;
          }
        } else {
          isAppUpdated = true;
        }
      });
    }
  }

  bool isNotification = false;

  void Dynamic() async {
    FirebaseDynamicLinks.instance.onLink;

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      String property_id = deepLink.queryParameters['id'] ?? 'pro';

      if (property_id != 'pro') {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Single_Property(
                  property_id: property_id,
                  property_tiitle: 'Brixmarket',
                )));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Testing(
        //               proertyID: property_id,
        //             )));
      } else {
        return;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    //Utils.getCurrentLocation();
    if (Platform.isAndroid) {
      initDynamicLinks(context);
    } else {
      Dynamic();
    }

    Fetch_App_Details();
    CheckUpdate();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? ios = message.notification?.apple;

      if (notification != null && android != null) {
        setState(() {
          isNotification = true;
        });
        if (message.data['value'] == 'Admin_Notification') {
          showDialo(
              'Message from admin',
              message.notification!.title.toString(),
              message.notification!.body.toString());
        } else if (message.data['value'] == "Message_Notification") {
          showDialo('Message', message.notification!.title.toString(),
              message.notification!.body.toString());
        } else if (message.data['value'] == "Review_Notification") {
          showDialo('Review', message.notification!.title.toString(),
              message.notification!.body.toString());
        } else if (message.data['value'] == "Request_Tour_Notification") {
          showDialo('Request tour', message.notification!.title.toString(),
              message.notification!.body.toString());
        }
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => TestingNews(categorySlug: message.data['categorySlug'], news_id: message.data['news_id'])
        //     ));
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              //channel.description,
              color: Colors.blueAccent,
              playSound: true,
              icon: 'assets/images/brix-logo.png',
            )));
      } else if (notification != null && ios != null) {
        //print('...............................................' + message.data['categorySlug']);
        //print(message.data['news_id']);
        setState(() {
          isNotification = true;
        });
        if (message.data['value'] == 'Admin_Notification') {
          showDialo(
              'Message from admin',
              message.notification!.title.toString(),
              message.notification!.body.toString());
        } else if (message.data['value'] == "Message_Notification") {
          showDialo('Message', message.notification!.title.toString(),
              message.notification!.body.toString());
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const ChatPage()),
          // );
        } else if (message.data['value'] == "Review_Notification") {
          showDialo('Review', message.notification!.title.toString(),
              message.notification!.body.toString());
        } else if (message.data['value'] == "Request_Tour_Notification") {
          showDialo('Request tour', message.notification!.title.toString(),
              message.notification!.body.toString());
        }
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => TestingNews(categorySlug: message.data['categorySlug'], news_id: message.data['news_id'])
        //     ));
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            const NotificationDetails(
              iOS: IOSNotificationDetails(
                presentAlert: false,
                presentSound: true,
                //presentBadge: true
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AppleNotification? ios = message.notification?.apple;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        setState(() {
          isNotification = true;
        });
        if (message.data['value'] == 'Admin_Notification') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const HomeNotificationsPage()),
          );
        } else if (message.data['value'] == "Message_Notification") {
          homeCtrl.loginRequest(request: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatPage()),
            );
          });
        } else if (message.data['value'] == "Review_Notification") {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) =>  const HomeNotificationsPage()),
          // );
        } else if (message.data['value'] == "Request_Tour_Notification") {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const HomeNotificationsPage()),
          );
        }
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => TestingNews(categorySlug: message.data['categorySlug'], news_id: message.data['news_id'])
        //     ));
      } else if (notification != null && ios != null) {
        setState(() {
          isNotification = true;
        });
        if (message.data['value'] == 'Admin_Notification') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const HomeNotificationsPage()),
          );
        } else if (message.data['value'] == "Message_Notification") {
          homeCtrl.loginRequest(request: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatPage()),
            );
          });
        } else if (message.data['value'] == "Review_Notification") {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) =>  const HomeNotificationsPage()),
          // );
        } else if (message.data['value'] == "Request_Tour_Notification") {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const HomeNotificationsPage()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isAppUpdated) {
      return Obx(() => Scaffold(
            backgroundColor: Pallet.homeBackground,
            body: Center(
              child: Lst.mobileHomeWidgets.elementAt(
                  Get.find<MobileHomeController>().bottomNavIndex.value),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined, size: 24), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search_outlined, size: 24),
                    label: 'Explore'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_outline, size: 24),
                    label: 'Saved'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.location_history_sharp, size: 24),
                    label: 'My account'),
              ],
              currentIndex:
                  Get.find<MobileHomeController>().bottomNavIndex.value,
              elevation: 18,
              selectedIconTheme:
                  const IconThemeData(color: Pallet.secondaryColor),
              unselectedIconTheme: const IconThemeData(color: Colors.blueGrey),
              selectedItemColor: Pallet.secondaryColor,
              onTap: (index) {
                if (index == 2 || index == 3) {
                  if (!HomeController.isLogin.value) {
                    Get.toNamed(RouteStr.login);
                    return;
                  }
                }
                if (index == 0) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MobileLandingPage()), // this mymainpage is your page to refresh
                    (Route<dynamic> route) => false,
                  );
                }
                Get.find<MobileHomeController>().bottomNavIndex.value = index;
              },
            ),
          ));
    } else {
      return const UpdateApp();
    }
  }
}
