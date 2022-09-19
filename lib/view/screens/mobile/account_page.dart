import 'package:brixmarket/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/edit_controller.dart';
import '../../../controllers/instance.dart';
import '../../../controllers/mobile_app_controllers/homepage_controller.dart';
import '../../../core/dialogs.dart';
import '../../../utils/validations.dart';
import '../../widgets/appbar_menus.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/form_button.dart';
import '../../widgets/form_inputs.dart';
import '../../widgets/image_widgets.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    reInitInstance();
    return WillPopScope(
      onWillPop: () => Future.delayed(const Duration(milliseconds: 10), () {
        Get.find<MobileHomeController>().bottomNavIndex.value = 0;
        return false;
      }),
      child: Scaffold(
        backgroundColor: Pallet.homeBackground,
        appBar: AppBar(
          backgroundColor: Pallet.secondaryColor,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () => Get.find<MobileHomeController>().bottomNavIndex.value = 0,
            child: const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 14, 0, 14),
              child: Icon(Icons.arrow_back),
            ),
          ),
          title: const CustomText(
            color: Colors.white,
            size: 18,
            text: 'My Account',
            weight: FontWeight.w600,
          ),
          actions: const [AppBarMenu(logout: true, myAccount: false)],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          children: [
            profileImgAndBasicInfo(),
            Container(
              color: Pallet.secondaryColor,
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
              child: const CustomText(
                color: Pallet.whiteColor,
                size: 16,
                text: 'Account',
                weight: FontWeight.w400,
              ),
            ),
            buildListTile(
                onTap: () {
                  Get.toNamed(RouteStr.mobileCreateProperty);
                },
                title: 'Place Ad',
                icon: Icons.post_add),
            buildListTile(
                onTap: () {
                  Get.toNamed(RouteStr.mobileMyProperties);
                },
                title: 'My Ads',
                icon: Icons.ads_click_outlined),
            buildListTile(
                onTap: () {
                  Get.toNamed(RouteStr.mobileStatistic);
                },
                title: 'Stats',
                icon: Icons.stacked_bar_chart),
            buildListTile(
                onTap: () {
                  MSG.snackBar("This Feature is in active development",title: "Coming Soon!");

                  //Get.toNamed(RouteStr.mobileSubscription);
                },
                title: 'Account upgrade',
                icon: Icons.verified),
            buildListTile(
                onTap: () {
                  Get.toNamed(RouteStr.mobileProfileHome);
                },
                title: 'My Profile',
                icon: Icons.account_box_outlined),
            buildListTile(
                onTap: () {
                  Get.toNamed(RouteStr.mobileSecurityHome);
                },
                title: 'Privacy and Security',
                icon: Icons.security_outlined),
            buildListTile(
                onTap: () {
                  Get.toNamed(RouteStr.mobileNotificationSettings);
                },
                title: 'Notification',
                icon: Icons.app_settings_alt),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Pallet.secondaryColor,
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
              child: const CustomText(
                color: Pallet.whiteColor,
                size: 16,
                text: 'Support',
                weight: FontWeight.w400,
              ),
            ),
            buildListTile(onTap: () => Get.toNamed(RouteStr.mobileChatHistory), title: 'Chat History', icon: Icons.wechat),
            buildListTile(onTap: homeCtrl.shareApp, title: 'Send an Invite', icon: Icons.share),
            buildListTile(onTap: () => sendFeedback(), title: 'Send us a feedback', icon: Icons.feedback_outlined),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Pallet.secondaryColor,
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
              child: const CustomText(
                color: Pallet.whiteColor,
                size: 16,
                text: 'Legal',
                weight: FontWeight.w400,
              ),
            ),
            buildListTile(
                onTap: () {
                  Get.toNamed(RouteStr.mobileHelpHome);
                },
                title: 'Help',
                icon: Icons.help_outline_sharp),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => homeCtrl.logout(),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: const [
                    Icon(Icons.logout, size: 20, color: Pallet.secondaryColor),
                    SizedBox(width: 28),
                    CustomText(
                      color: Colors.black87,
                      size: 16,
                      text: 'Logout',
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(thickness: 1)
          ],
        ),
      ),
    );
  }

  buildListTile({String title = '', IconData? icon, required Function onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 0.8))),
        child: ListTile(
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.blueGrey[500],
            size: 12,
          ),
          leading: Icon(icon ?? Icons.dashboard, size: 22, color: Pallet.secondaryColor),
          title: CustomText(
            color: Colors.black87,
            size: 16,
            text: title,
            weight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

sendFeedback() {
  showMaterialModalBottomSheet(
    context: Get.context!,
    backgroundColor: Colors.transparent,
    builder: (context) => Align(
      alignment: Alignment.bottomRight,
      child: SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 480),
          height: 640,
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                   const Spacer(),
                  const CustomText(
                    color: Colors.blueGrey,
                    size: 18,
                    weight: FontWeight.w600,
                    text: 'Send us a Feedback',
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 20),
              FormInput(
                value: isLogin ? accountName(user: user) : '',
                width: double.infinity,
                controller: EditCtrl.name,
                error: EditCtrl.nameErr,
                validate: Val.name,
                label: 'Name',
                hint: 'Enter full Name',
              ),
              const SizedBox(height: 20),
              FormInput(
                value: isLogin ? user.emailAddress : '',
                width: double.infinity,
                controller: EditCtrl.email,
                error: EditCtrl.emailErr,
                validate: Val.email,
                label: 'Email',
                hint: 'Enter Email',
              ),
              const SizedBox(height: 20),
              FormInput(
                value: isLogin && user.phoneNumber != null && user.phoneNumber != '' ? user.phoneNumber : '',
                controller: EditCtrl.phone,
                error: EditCtrl.phoneErr,
                validate: Val.phone,
                width: double.infinity,
                label: 'Phone number(optional)',
                hint: 'Enter Phone number',
              ),
              const SizedBox(
                height: 20,
              ),
              FormInput(
                controller: EditCtrl.message,
                validate: Val.name,
                error: EditCtrl.messageErr,
                height: 164,
                maxLines: 8,
                width: double.infinity,
                label: 'Message',
                hint: 'Enter message',
              ),
              FormIconButton(
                hasIcon: false,
                width: Get.width,
                height: 42,
                onPressed: homeCtrl.sendFeedback,
                fontSize: 16,
                text: Str.submit,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
