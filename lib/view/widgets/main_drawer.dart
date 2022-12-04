import 'package:brixmarket/controllers/home_controller.dart';
import 'package:brixmarket/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/theme/color.dart';
import '../../controllers/instance.dart';
import '../../res/enums.dart';
import '../screens/hom_page_web.dart';
import 'custom_text.dart';
import 'image_widgets.dart';
import 'mobile_appbar.dart';
import '../../controllers/edit_controller.dart';

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: Container(
      padding: const EdgeInsets.only(left: 0, right: 0),
      decoration: const BoxDecoration(
        color: Pallet.whiteColor,
      ),
      width: Get.width * 0.2,
      child: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            width: double.infinity,
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 20),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () => Get.to(HomePageWeb()),
                            child: Image.asset(ImgStr.logo1, width: 120)),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              height: 25,
                              width: 25,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Pallet.secondaryColor),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 14,
                              )),
                        )
                      ],
                    )),
                !HomeController.isLogin.value
                    ? const SizedBox.shrink()
                    : const SizedBox(height: 20),
                !HomeController.isLogin.value
                    ? const SizedBox.shrink()
                    : circleProfileImage(radius: 32),
                !HomeController.isLogin.value
                    ? const SizedBox.shrink()
                    : const SizedBox(height: 8),
                !HomeController.isLogin.value
                    ? const SizedBox.shrink()
                    : Obx(() => Center(
                          child: CustomText(
                            color: Colors.black,
                            size: 18,
                            text: accountName(user: homeCtrl.user.value),
                            weight: FontWeight.bold,
                          ),
                        )),
                const SizedBox(height: 24),
                !HomeController.isLogin.value
                    ? const SizedBox.shrink()
                    : sideBarItem(
                        navItem: NavItems.none,
                        icon: Icons.list_alt_outlined,
                        title: 'My Account',
                        onTap: () {
                          cPropCtrl.onSelected(0);
                          Get.toNamed(RouteStr.webDashboard);
                        }),
                const SizedBox(
                  height: 20,
                ),
                sideBarItem(
                  navItem: NavItems.house,
                  icon: Icons.house,
                  title: 'House',
                  onTap: () {
                    EditCtrl.filterCategories.clear();
                    EditCtrl.filterCategories.add('House');
                    propCtrl.setAllPropertiesWeb(
                        sideNav: true, navItem: NavItems.house);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                sideBarItem(
                  navItem: NavItems.land,
                  icon: Icons.bedroom_parent_outlined,
                  title: 'Land',
                  onTap: () {
                    EditCtrl.filterCategories.clear();
                    EditCtrl.filterCategories.add('Land');
                    propCtrl.setAllPropertiesWeb(
                        sideNav: true, navItem: NavItems.land);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                sideBarItem(
                  navItem: NavItems.newHomes,
                  icon: Icons.home,
                  title: 'New Homes',
                  onTap: () {
                    EditCtrl.filterCategories.clear();
                    EditCtrl.filterCategories.add('New Home');
                    propCtrl.setAllPropertiesWeb(
                        sideNav: true, navItem: NavItems.newHomes);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                sideBarItem(
                  navItem: NavItems.commercial,
                  icon: Icons.label_important,
                  title: 'Commercial',
                  onTap: () {
                    EditCtrl.filterCategories.clear();
                    EditCtrl.filterCategories.add('Commercial');
                    propCtrl.setAllPropertiesWeb(
                        sideNav: true, navItem: NavItems.commercial);
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                // sideBarItem(
                //   navItem: NavItems.premiumRealtors,
                //   icon: Icons.price_change,
                //   title: 'Premium Realtors',
                //   onTap: () => propCtrl.setAllPropertiesWeb(sideNav: true, navItem: NavItems.premiumRealtors),
                // ),
                !HomeController.isLogin.value
                    ? const SizedBox.shrink()
                    : const SizedBox(height: 20),
                !HomeController.isLogin.value
                    ? const SizedBox.shrink()
                    : sideBarItem(
                        navItem: NavItems.none,
                        icon: Icons.notifications,
                        title: 'Notifications',
                        onTap: () {
                          Get.back();
                          openWebNotification();
                        }),
                !HomeController.isLogin.value
                    ? const SizedBox.shrink()
                    : const SizedBox(height: 20),
                !HomeController.isLogin.value
                    ? const SizedBox.shrink()
                    : sideBarItem(
                        navItem: NavItems.none,
                        icon: Icons.favorite,
                        title: 'Saved Properties',
                        onTap: () {
                          cPropCtrl.onSelected(3);
                          Get.toNamed(RouteStr.webDashboard);
                        },
                      ),
                const SizedBox(height: 20),
                HomeController.isLogin.value
                    ? sideBarItem(
                        icon: Icons.logout,
                        title: 'Logout',
                        onTap: homeCtrl.logout)
                    : sideBarItem(
                        icon: Icons.person_pin_circle_rounded,
                        title: 'Sign In',
                        onTap: homeCtrl.loginRequest),
                const SizedBox(
                  height: 20,
                ),
                !HomeController.isLogin.value
                    ? const SizedBox.shrink()
                    : Container(
                        width: double.infinity,
                        height: 35,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Pallet.secondaryColor),
                        child: Obx(() => HomeController.isLogin.value
                            ? Center(
                                child: InkWell(
                                  onTap: () {
                                    cPropCtrl.onSelected(1);
                                    Get.toNamed(RouteStr.webDashboard);
                                  },
                                  child: const CustomText(
                                    size: 12,
                                    color: Colors.white,
                                    weight: FontWeight.w500,
                                    text: 'Add Listing',
                                  ),
                                ),
                              )
                            : const SizedBox.shrink()),
                      ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget sideBarItem(
    {IconData? icon,
    String? title,
    NavItems navItem = NavItems.home,
    required Function() onTap}) {
  return InkWell(
    splashColor: Colors.transparent,
    onTap: onTap,
    child: Obx(() {
      return Container(
        height: 40,
        padding: const EdgeInsets.only(left: 24),
        decoration: BoxDecoration(
            color: homeCtrl.activeNavItem.value == navItem
                ? Colors.blueGrey.withOpacity(0.2)
                : Colors.transparent,
            border: Border(
                left: BorderSide(
                    color: homeCtrl.activeNavItem.value == navItem
                        ? Pallet.secondaryColor
                        : Colors.transparent,
                    width: 3))),
        child: Row(
          children: [
            Icon(
              icon!,
              color: Pallet.secondaryColor,
              size: 18,
            ),
            const SizedBox(
              width: 15,
            ),
            CustomText(
              text: title,
              color: Colors.black87,
              size: 15,
              weight: FontWeight.w600,
            ),
          ],
        ),
      );
    }),
  );
}
