import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/controllers/home_controller.dart';
import 'package:brixmarket/controllers/mobile_app_controllers/homepage_controller.dart';
import 'package:brixmarket/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/lists.dart';

class MobileLandingPage extends StatelessWidget {
  const MobileLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        ));
  }
}
