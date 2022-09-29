// ignore_for_file: avoid_unnecessary_containers

import 'package:brixmarket/core/dialogs.dart';
import 'package:brixmarket/res/strings.dart';
import 'package:brixmarket/utils/utils.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/theme/color.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/instance.dart';
import '../widgets/image_widgets.dart';
import '../widgets/mobile_appbar.dart';
import 'create_property/create_property_widges.dart';
import 'dashboard/account_widgets.dart';
import 'dashboard/insight_widgets.dart';
import 'dashboard/my_property_widgets.dart';
import 'dashboard/save_property_widgets.dart';
import 'dashboard/upgrade_pricing_widgets.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with TickerProviderStateMixin {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    if (!HomeController.isLogin.value) {
      Get.toNamed(RouteStr.webHome);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!HomeController.isLogin.value) {
      Get.toNamed(RouteStr.webHome);
    }
    return LayoutBuilder(builder: (context, constraints) {
      var dashboardWidgets = [
        const InsightWidget(),
         CreatePropertyWidget(isEdt: false,),
        MyPropertiesWidget(provider: this),
        SavedPropertiesWidget(constraints: constraints.maxWidth),
        UpgradePricingWidget(constraints: constraints.maxWidth),
        AccountWidget(constraints: constraints.maxWidth),
        const Align(alignment: Alignment.center, child: Text('You are currently Logged Out')),
      ];
      return Scaffold(
        backgroundColor: Pallet.primaryBackgroundLight, // (cPropCtrl.sideNavIndex.value == 1) ? const Color(0xFFf9f9f9) : Colors.white,
        key: homeScaffoldKey,
        drawer: const DashBoardSideBar(),
        appBar: appBarWeb(homeScaffoldKey),
        extendBody: true,
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: true),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                  child: Row(
                children: [
                  isNotDeskTop() ? const SizedBox.shrink() : const DashBoardSideBar(),
                  Expanded(
                    child: Obx(() => IndexedStack(
                          index: cPropCtrl.sideNavIndex.value,
                          children: dashboardWidgets,
                        )),
                  ),
                ],
              )),
            ],
          ),
        ),
      );
    });
  }
}

class DashBoardSideBar extends StatelessWidget {
  const DashBoardSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      color: Pallet.sideBarColor,
      width: Get.width < 320 ? Get.width : 320,
      child: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: 8),
          Stack(
            children: [
              isNotDeskTop()
                  ? Positioned(
                      right: 16,
                      top: 8,
                      child: InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Pallet.secondaryColor),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 14,
                            )),
                      ),
                    )
                  : const SizedBox.shrink(),
              profileImgAndBasicInfo(0),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: CustomText(
              text: 'BOARD',
              color: Colors.white,
              size: 16,
              weight: FontWeight.w100,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          sideBarItem(index: 0, icon: Icons.insights, title: 'Insight'),
          const SizedBox(
            height: 20,
          ),
          sideBarItem(index: 1, icon: Icons.list_alt_outlined, title: 'Create listing'),
          const SizedBox(
            height: 20,
          ),
          sideBarItem(index: 2, icon: Icons.ads_click, title: 'My Ads'),
          const SizedBox(
            height: 20,
          ),
          sideBarItem(index: 3, icon: Icons.label_important, title: 'Saved Property'),
          const SizedBox(
            height: 20,
          ),
          sideBarItem(index: 4, icon: Icons.price_change, title: 'Premium upgrade'),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: CustomText(
              text: 'PROFILE',
              color: Colors.white,
              size: 16,
              weight: FontWeight.w100,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          sideBarItem(index: 5, icon: Icons.person_pin_circle_rounded, title: 'Account Settings'),
          const SizedBox(
            height: 20,
          ),
          sideBarItem(index: 6, icon: Icons.logout, title: 'Logout'),
          const SizedBox(
            height: 120,
          ),
        ],
      ),
    );
  }

  Widget sideBarItem({IconData? icon, String? title, int? index}) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: title == 'Logout'
          ? homeCtrl.logout
          : index == 4
              ? () => MSG.snackBar('This feature is in active development', title: 'Coming Soon!')
              : (() {
                  if (isNotDeskTop()) {
                    Get.back();
                  }
                  cPropCtrl.onSelected(index!);
                }),
      child: Obx(() {
        return Container(
          height: 44,
          padding: const EdgeInsets.only(left: 40),
          decoration: BoxDecoration(
              color: cPropCtrl.sideNavIndex.value == index ? Colors.white.withOpacity(0.2) : Colors.transparent,
              border: Border(left: BorderSide(color: cPropCtrl.sideNavIndex.value == index ? Pallet.secondaryColor : Colors.transparent, width: 3))),
          child: Row(
            children: [
              Icon(
                icon!,
                color: Pallet.secondaryColor,
                size: 24,
              ),
              const SizedBox(
                width: 15,
              ),
              CustomText(
                text: title,
                color: Colors.white,
                size: 16,
                weight: FontWeight.w500,
              ),
            ],
          ),
        );
      }),
    );
  }
}
