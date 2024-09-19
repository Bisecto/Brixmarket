import 'package:brixmarket/controllers/instance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme/color.dart';
import '../../../res/strings.dart';
import '../../../utils/utils.dart';
import '../../widgets/appbar_menus.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/form_button.dart';
import '../../widgets/image_widgets.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    reInitInstance();
    return Scaffold(
      backgroundColor: Pallet.homeBackground,
      appBar: AppBar(
        backgroundColor: Pallet.secondaryColor,
        automaticallyImplyLeading: true,
        title: const CustomText(
          color: Colors.white,
          size: 18,
          text: 'Notifications',
        ),
        actions: const [AppBarMenu(logout: true, myAccount: true, propertyIDS: [],)],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        children: [
          profileImgAndBasicInfo(0),
          Container(
            color: Pallet.secondaryColor,
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            child: const CustomText(
              color: Pallet.whiteColor,
              size: 16,
              text: 'Notification Settings',
              weight: FontWeight.w400,
            ),
          ),
          notificationSettingsInfo(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

notificationSettingsInfo() {
  return Wrap(children: [
    const SizedBox(height: 20),
    SizedBox(
      width: isTabletDown() ? double.infinity : Get.width * 0.29,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('NOTIFICATIONS', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Pallet.secondaryColor)),
          const SizedBox(height: 8),
          settingsItem('App Notifications', '', user.settings?.inAppAlert),
          settingsItem('Email Alert', '', user.settings?.emailAlert),
          settingsItem('SMS Alert', '', user.settings?.smsAlert),
        ],
      ),
    ),
    SizedBox(width: Get.width * 0.015),
    SizedBox(
      width: isTabletDown() ? double.infinity : Get.width * 0.29,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text('UPDATES', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Pallet.secondaryColor)),
          const SizedBox(height: 8),
          settingsItem('Request Tour Alert', '', user.settings?.requestTourAlert),
          settingsItem('Newsletter Subscription', '', user.settings?.subNewsletter),
          settingsItem('News and Update', '', user.settings?.updateAlert),
        ],
      ),
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FormBorderButton(
          width: 86,
          bgColor: Colors.white,
          txtColor: Colors.black,
          text: Str.cancel,
          onPressed: () => Get.back(),
        ),
        const SizedBox(width: 10),
        FormButton(
          width: 86,
          textSize: 14,
          weight: FontWeight.bold,
          text: Str.save,
          disableButton: false,
          onPressed: homeCtrl.updateSettings,
        ),
      ],
    ),
  ]);
}

Widget settingsItem(String title, String subTitle, state) {
  var defaultState = false.obs;
  return ListTile(
    contentPadding: const EdgeInsets.only(left: 8),
    title: CustomText(
      text: title,
      color: Colors.black,
      weight: FontWeight.w700,
      size: 16,
    ),
    subtitle: CustomText(
      text: subTitle,
      color: Colors.black54,
      weight: FontWeight.w400,
      size: 14,
    ),
    trailing: Transform.scale(
      scale: 0.5,
      child: Obx(() => CupertinoSwitch(
            value: state?.value ?? defaultState.value,
            activeColor: Colors.green,
            onChanged: (value) {
              state?.value = value;
            },
          )),
    ),
  );
}
