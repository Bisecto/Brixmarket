import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/controllers/home_controller.dart';
import 'package:brixmarket/controllers/mobile_app_controllers/homepage_controller.dart';
import 'package:brixmarket/res/strings.dart';
import 'package:brixmarket/view/screens/mobile/updateApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../res/lists.dart';
import '../../../testingPage.dart';
import '../../../utils/utils.dart';
import 'dart:io' show Platform;

class MobileLandingPage extends StatefulWidget {
  const MobileLandingPage({Key? key}) : super(key: key);

  @override
  State<MobileLandingPage> createState() => _MobileLandingPageState();
}

class _MobileLandingPageState extends State<MobileLandingPage> {
  void initDynamicLinks(BuildContext context) async {
    final PendingDynamicLinkData? data =
    await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deeplink = data!.link;
    //String categorySlug = deeplink.queryParameters['categorySlug'] ?? 'Empty';
    //print('Category SLug $categorySlug');
    String property_id = deeplink.queryParameters['id'] ?? 'pro';
    if (property_id != 'pro') {
      print(deeplink);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Testing(
                proertyID: property_id,
              )));
    } else {
      return;
    }
  }

  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';
  String LatestVersion='';
  String LatestBuildNumber='';
  Fetch_App_Details() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {

      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
      print("........................"+appName+"........................"+packageName+"........................"+version+"........................"+buildNumber);
    });

  }
  bool isAppUpdated=true;

  CheckUpdate()async{
    if (Platform.isAndroid) {
      await FirebaseFirestore.instance.collection('version').doc('Android-version-Android').get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;

          setState(() {
            LatestVersion=data['version'];
            LatestBuildNumber=data['buildNumber'];

            print(LatestBuildNumber);
            print(LatestVersion);

          });
          if(LatestVersion==version){
            isAppUpdated=true;
          }else if(LatestVersion!=version){
            if(data['isUpdate']){
              isAppUpdated=false;
            }else{
              isAppUpdated=true;}
          } else if(LatestVersion.isEmpty){
            isAppUpdated=true;
          } else if(LatestVersion.toString()=='null') {
            isAppUpdated = true;

          } else{
            isAppUpdated=true;
          }
        } else{
          isAppUpdated=true;
        }
      });
    } else if (Platform.isIOS) {
      await FirebaseFirestore.instance.collection('version').doc('iOS-version-Ios').get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;

          setState(() {
            LatestVersion=data['version'];
            LatestBuildNumber=data['buildNumber'];

            print(LatestBuildNumber);
            print(LatestVersion);

          });
          if(LatestVersion==version){
            isAppUpdated=true;
          }else if(LatestVersion!=version){
            if(data['isUpdate']){
              isAppUpdated=false;
            }else{
              isAppUpdated=true;}
          } else if(LatestVersion.isEmpty){
            isAppUpdated=true;
          } else if(LatestVersion.toString()=='null') {
            isAppUpdated = true;

          } else{
            isAppUpdated=true;
          }
        } else{
          isAppUpdated=true;
        }
      });    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Fetch_App_Details();
    CheckUpdate();
    initDynamicLinks(context!);
    Utils.getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    if(isAppUpdated){
    return Obx(() => Scaffold(
          backgroundColor: Pallet.homeBackground,
          body: Center(
            child: Lst.mobileHomeWidgets.elementAt(Get.find<MobileHomeController>().bottomNavIndex.value),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined, size: 24), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.search_outlined, size: 24), label: 'Explore'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_outline, size: 24), label: 'Saved'),
              BottomNavigationBarItem(icon: Icon(Icons.location_history_sharp, size: 24), label: 'My account'),
            ],
            currentIndex: Get.find<MobileHomeController>().bottomNavIndex.value,
            elevation: 18,
            selectedIconTheme: const IconThemeData(color: Pallet.secondaryColor),
            unselectedIconTheme: const IconThemeData(color: Colors.blueGrey),
            selectedItemColor: Pallet.secondaryColor,
            onTap: (index) {
              if (index == 2 || index == 3) {
                if (!HomeController.isLogin.value) {
                  Get.toNamed(RouteStr.login);
                  return;
                }
              }
              Get.find<MobileHomeController>().bottomNavIndex.value = index;
            },
          ),
        ));}
  else{
  return const UpdateApp();
  }
  }
}
