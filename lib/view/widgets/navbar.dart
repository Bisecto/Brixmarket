import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/theme/color.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/instance.dart';
import '../../res/strings.dart';
import 'custom_text.dart';

Widget navBar() {
  return Container(
    height: 90,
    color: Pallet.homeBackground,
    margin: const EdgeInsets.only(top: 0, bottom: 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              homeCtrl.navbarIndex.value = 0;
              Get.toNamed(RouteStr.webHome);
              // Get.find<PropCtrl>(tag: 'home').makePayment(Get.context!, amount: 100000, email: 'zikzay@gmail.com', ref: '20033jj483jj3');
            },
            child: Image.asset('assets/images/brixmarketlogo.png')),
        Row(
          children: [
            InkWell(
                splashColor: Colors.transparent,
                onTap: () async {
                  await navigateTo(1);
                },
                child: Obx(
                  () => CustomText(
                    size: 16,
                    color: homeCtrl.navbarIndex.value == 1 ? Pallet.secondaryColor : const Color(0xFF282e42),
                    weight: FontWeight.w600,
                    text: 'Buy',
                  ),
                )),
            const SizedBox(width: 50),
            InkWell(
                splashColor: Colors.transparent,
                onTap: () async {
                  await navigateTo(2);
                },
                child: Obx(
                  () => CustomText(
                    size: 16,
                    color: homeCtrl.navbarIndex.value == 2 ? Pallet.secondaryColor : const Color(0xFF282e42),
                    weight: FontWeight.w600,
                    text: 'Rent',
                  ),
                )),
            const SizedBox(width: 50),
            InkWell(
                splashColor: Colors.transparent,
                onTap: () async {
                  await navigateTo(3);
                },
                child: Obx(
                  () => CustomText(
                    size: 16,
                    color: homeCtrl.navbarIndex.value == 3 ? Pallet.secondaryColor : const Color(0xFF282e42),
                    weight: FontWeight.w600,
                    text: 'New Homes',
                  ),
                )),
            const SizedBox(width: 50),
            InkWell(
                splashColor: Colors.transparent,
                onTap: () async {
                  await navigateTo(4);
                },
                child: Obx(
                  () => CustomText(
                    size: 16,
                    color: homeCtrl.navbarIndex.value == 4 ? Pallet.secondaryColor : const Color(0xFF282e42),
                    weight: FontWeight.w600,
                    text: 'Commercial',
                  ),
                )),
            const SizedBox(width: 50),
            InkWell(
              splashColor: Colors.transparent,
              onTap: () async {
                await navigateTo(5);
              },
              child: Obx(() => CustomText(
                    size: 16,
                    color: homeCtrl.navbarIndex.value == 5 ? Pallet.secondaryColor : const Color(0xFF282e42),
                    weight: FontWeight.w500,
                    text: 'Premium Realtors',
                  )),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              onTap: () => HomeController.userId.isBlank! ? Get.toNamed(RouteStr.login) : null,
              child: CustomText(
                size: 16,
                color: Colors.blueGrey,
                weight: FontWeight.w500,
                text: HomeController.userId.isBlank! ? 'Sign in' : homeCtrl.user.value.firstName,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            InkWell(
              splashColor: Colors.transparent,
              onTap: HomeController.userId.isBlank!
                  ? () => Get.toNamed(RouteStr.login)
                  : () {
                      cPropCtrl.sideNavIndex.value == 1;
                      Get.toNamed(RouteStr.webDashboard);
                    },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Pallet.secondaryColor),
                child: const CustomText(
                  size: 16,
                  color: Colors.white,
                  weight: FontWeight.w500,
                  text: 'Place Ad',
                ),
              ),
            )
          ],
        ),
      ],
    ),
  );
}

navigateTo(int i) async {
  homeCtrl.navbarIndex.value = i;
  homeCtrl.clearFilter();
  await homeCtrl.getProperties();
  Get.toNamed(RouteStr.mobileExplore);
}

Widget topMessage({homeCtrl}) {
  return Obx(() => Visibility(
        visible: homeCtrl.showTopMsg.value,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          color: const Color(0xFF7a869f),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(minWidth: 20, maxWidth: Get.width * 0.7),
                child: TextStyles.richTexts(
                    onPress1: () {},
                    onPress2: () {},
                    size: 14,
                    decoration: TextDecoration.underline,
                    weight: FontWeight.w300,
                    color: Colors.white,
                    color2: Colors.white60,
                    centerText: true,
                    text1: 'Updates!! You can now pre order houses on a single click without hassele   ',
                    text2: ' learn more',
                    text3: '',
                    text4: ''),
              ),
              SizedBox(width: Get.width * 0.05),
              InkWell(
                onTap: homeCtrl.closeTopMsg,
                child: const Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ));
}
