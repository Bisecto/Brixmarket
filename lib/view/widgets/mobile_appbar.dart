import 'package:brixmarket/controllers/home_controller.dart';
import 'package:brixmarket/res/strings.dart';
import 'package:brixmarket/utils/utils.dart';
import 'package:brixmarket/view/screens/shortstay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../config/theme/color.dart';
import '../../controllers/instance.dart';
import '../../core/app.dart';
import '../../res/enums.dart';
import '../screens/mobile/home_page.dart';
import 'app_social_icons.dart';
import 'appbar_menus.dart';
import 'appbar_notification.dart';
import 'image_widgets.dart';

mobileAppBar(homeScaffoldKey) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Pallet.homeBackground,
    leadingWidth: 200,
    leading: Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Image.asset(
        'assets/images/brixmarketlogo.png',
        height: 50,
      ),
    ),
    actions: [
      InkWell(
        onTap: () {
          homeScaffoldKey.currentState?.openDrawer();
        },
        child: const Padding(
          padding: EdgeInsets.only(right: 16.0, left: 16),
          child: Icon(Icons.menu, size: 25, color: Colors.blueGrey),
        ),
      )
    ],
  );
}

appBarWeb(GlobalKey<ScaffoldState> scaffoldKey) {
  double mainPadding = Get.width < 480 ? Get.width * 0.005 : Get.width * 0.06;
  return AppBar(
    backgroundColor: Pallet.topBarColor,
    automaticallyImplyLeading: false,
    toolbarHeight: 42,
    title: Padding(
      padding: EdgeInsets.only(left: mainPadding, right: isTabletDown() ? 0 : mainPadding),
      child: SizedBox(
        width: Get.width,
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Wrap(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.email,
                      color: Pallet.secondaryColor,
                      size: 18,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      Str.contactEmail1,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
                SizedBox(width: isNotDeskTop() ? 0 : 32),
                isNotDeskTop()
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.phone,
                            color: Pallet.secondaryColor,
                            size: 18,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            Str.contactPhone2,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            Str.contactPhone1,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          )
                        ],
                      ),
              ],
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const AppSocialIcons(),
                isTabletDown() ? const SizedBox.shrink() : SizedBox(width: isTabletDown() ? 0 : 32),
                isTabletDown()
                    ? const SizedBox.shrink()
                    : Obx(
                        () => InkWell(
                          onTap: () {
                            if (HomeController.isLogin.value) {
                              homeCtrl.openDashboard(1);
                            } else {
                              homeCtrl.loginRequest();
                            }
                          }, // homeCtrl.loginRequest(request: () {}),
                          child: Container(
                            width: 120,
                            height: 42,
                            color: Pallet.secondaryColor,
                            child: Center(
                                child: Text(
                              HomeController.isLogin.value ? 'Add Listing' : 'Sign In',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            )),
                          ),
                        ),
                      )
              ],
            ),
          ],
        ),
      ),
    ),
    bottom: AppBar(
      backgroundColor: Pallet.whiteColor,
      foregroundColor: const Color(0xFF0B2C3D),
      toolbarHeight: isMobile() ? 62 : 72,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: SizedBox(
        width: Get.width,
        child: Padding(
          padding: EdgeInsets.only(left: mainPadding, right: mainPadding),
          child: Row(
            children: [
              InkWell(
                onTap: () => Get.toNamed(RouteStr.webHome),
                child: Image.asset(ImgStr.logo1, height: isMobile() ? 38 : 48),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isNotDeskTop()
                      ? const SizedBox.shrink()
                      : Row(
                          children: [
                            InkWell(
                              onTap: () => propCtrl.setAllPropertiesWeb(navItem: NavItems.buy), // Get.to(() => () => PropertiesPage()),
                              child: Obx(() => Text(
                                    Str.buy,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: homeCtrl.activeNavItem.value == NavItems.buy ? Pallet.secondaryColor : Pallet.bottomBarColor,
                                    ),
                                  )),
                            ),
                            const SizedBox(width: 32),
                            InkWell(
                              onTap: () => propCtrl.setAllPropertiesWeb(navItem: NavItems.rent),
                              child: Obx(() => Text(
                                    Str.rent,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: homeCtrl.activeNavItem.value == NavItems.rent ? Pallet.secondaryColor : Pallet.bottomBarColor,
                                    ),
                                  )),
                            ),
                            const SizedBox(width: 32),
                            InkWell(
                              onTap: () => propCtrl.setAllPropertiesWeb(navItem: NavItems.newHomes),
                              child: Obx(() => Text(
                                    Str.newHome,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: homeCtrl.activeNavItem.value == NavItems.newHomes ? Pallet.secondaryColor : Pallet.bottomBarColor,
                                    ),
                                  )),
                            ),
                            const SizedBox(width: 32),
                            InkWell(
                              onTap: ()  {
                                //propCtrl.setAllPropertiesWeb(navItem: NavItems.shortStay);
                                homeCtrl.activeNavItem.value=NavItems.shortStay;
                                Navigator.of(context!).push(MaterialPageRoute(builder: (context) => Short_stay()));
                                //propCtrl.setAllPropertiesWeb(navItem: NavItems.shortStay);
                              },
                              child: Obx(() => Text(
                                Str.shortStay,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: homeCtrl.activeNavItem.value == NavItems.shortStay ? Pallet.secondaryColor : Pallet.bottomBarColor,
                                ),
                              )),
                            ),
                            const SizedBox(width: 32),
                            InkWell(
                              onTap: () {
                                propCtrl.setAllPropertiesWeb(navItem: NavItems.shortStay);
                                homeCtrl.activeNavItem.value=NavItems.commercial;
                              },
                              child: Obx(() => Text(
                                    Str.commercial,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: homeCtrl.activeNavItem.value == NavItems.commercial ? Pallet.secondaryColor : Pallet.bottomBarColor,
                                    ),
                                  )),
                            ),
                            const SizedBox(width: 32),
                            // InkWell(
                            //   onTap: () => propCtrl.setAllPropertiesWeb(navItem: NavItems.premiumRealtors),
                            //   child: Obx(() => Text(
                            //         Str.premiumRealtors,
                            //         style: TextStyle(
                            //           fontSize: 16,
                            //           fontWeight: FontWeight.w600,
                            //           color: homeCtrl.activeNavItem.value == NavItems.premiumRealtors ? Pallet.secondaryColor : Pallet.bottomBarColor,
                            //         ),
                            //       )),
                            // ),
                            // const SizedBox(width: 32),
                          ],
                        ),
                  Obx(() => Card(
                        elevation: 4,
                        child: GestureDetector(
                          onTap: !HomeController.isLogin.value ? () => homeCtrl.loginRequest() : () => openWebNotification(),
                          child: Stack(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.notifications,
                                ),
                              ),
                              !HomeController.isLogin.value ? const SizedBox.shrink() : const AppBarNotification(),
                            ],
                          ),
                        ),
                      )),
                  Obx(() => InkWell(
                        onTap: !HomeController.isLogin.value ? () => homeCtrl.loginRequest() : () => homeCtrl.openDashboard(3),
                        child: Card(
                          elevation: 4,
                          child: Stack(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.favorite),
                              ),
                              Obx(
                                () => homeCtrl.mySavedProperties.value.isEmpty
                                    ? const SizedBox.shrink()
                                    : Positioned(
                                        top: 1,
                                        right: 1,
                                        child: CircleAvatar(
                                            backgroundColor: Utils.isMobileApp ? Colors.black : Colors.red,
                                            radius: 8,
                                            child: Text(
                                              homeCtrl.mySavedProperties.value.length.toString(),
                                              style: const TextStyle(color: Colors.white, height: 1, fontSize: 12, fontWeight: FontWeight.w600),
                                            )),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  SizedBox(width: HomeController.isLogin.value && !isMobile() ? 8 : 0),
                  isMobile()
                      ? const SizedBox.shrink()
                      : Obx(() => HomeController.isLogin.value
                          ? Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: AppBarMenu(
                                propertyIDS: [],
                                child: circleProfileImage(radius: 20),
                              ),
                            )
                          : const AppBarMenu(
                              login: true,
                              logout: false,
                              myAccount: false,
                              propertyIDS: [],
                              child: Card(
                                elevation: 4,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.person),
                                ),
                              ),
                            )),
                  SizedBox(width: HomeController.isLogin.value && !isMobile() ? 8 : 0),
                  isDesktop()
                      ? const SizedBox.shrink()
                      : InkWell(
                          onTap: () {
                            scaffoldKey.currentState?.openDrawer();
                          },
                          child: const Card(
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.menu),
                            ),
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

openWebNotification() {
  return showMaterialModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: Get.context!,
    builder: (context) => Align(
      alignment: Alignment.topRight,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        constraints: const BoxConstraints(maxWidth: 480),
        child: const HomeNotificationsPage(),
      ),
    ),
  );
}
