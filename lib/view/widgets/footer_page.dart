import 'package:brixmarket/controllers/edit_controller.dart';
import 'package:brixmarket/core/dialogs.dart';
import 'package:brixmarket/res/strings.dart';
import 'package:brixmarket/utils/validations.dart';
import 'package:brixmarket/view/widgets/custom_button.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:brixmarket/view/widgets/form_inputs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/theme/color.dart';
import '../../controllers/instance.dart';
import '../../res/enums.dart';
import '../../res/lists.dart';
import '../../res/states.dart';
import '../../utils/utils.dart';
import '../screens/faq_page.dart';
import '../screens/mobile/account_page.dart';
import '../screens/mobile/help_page.dart';
import 'app_social_icons.dart';
import 'drop_down.dart';

Widget pageFooter() {
  double mainPadding = Get.width < 480 ? Get.width * 0.05 : Get.width * 0.065;
  return Column(
    children: [
      const SizedBox(height: 48),
      Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: 42, horizontal: mainPadding),
        color: Pallet.secondaryColor,
        child: Wrap(
          alignment: isTabletDown()
              ? WrapAlignment.center
              : WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 24,
          children: [
            Column(
              crossAxisAlignment: isTabletDown()
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  'Want to Become a Real Estate Agent?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: isTabletDown() ? 24 : 28,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  'We will help you grow your career and bring your listings to prospective customers.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile() ? Get.width * 0.04 : 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(32)),
                child: InkWell(
                  onTap: () => Get.toNamed(RouteStr.registerHome),
                  child: Container(
                      width: 172,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(36),
                        boxShadow: const [
                          BoxShadow(color: Colors.white30, spreadRadius: 6)
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Sign up Today',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                ))
          ],
        ),
      ),
      Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(
            vertical: isDesktop() ? 72 : 42, horizontal: mainPadding),
        color: Pallet.topBarColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(runSpacing: 32, alignment: WrapAlignment.center, children: [
              SizedBox(
                width: isMobile() ? Get.width : Get.width * 0.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(ImgStr.logoLight, height: isTablet() ? 32 : 48),
                    SizedBox(height: isTablet() ? 12 : 24),
                    Text(
                      'No 9B Seguela Street, Wuse Zone 2, British Village,',
                      style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.w300,
                          fontSize: isTabletDown()
                              ? isMobile()
                                  ? 14
                                  : 12
                              : 16),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Off IBB Boulevard, Abuja, Nigeria.',
                      style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.w300,
                          fontSize: isTabletDown()
                              ? isMobile()
                                  ? 14
                                  : 12
                              : 16),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      Str.contactEmail1,
                      style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.w300,
                          fontSize: isTabletDown()
                              ? isMobile()
                                  ? 14
                                  : 12
                              : 16),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      Str.contactPhone1,
                      style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.w300,
                          fontSize: isTabletDown()
                              ? isMobile()
                                  ? 14
                                  : 12
                              : 16),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      Str.contactPhone2,
                      style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.w300,
                          fontSize: isTabletDown()
                              ? isMobile()
                                  ? 14
                                  : 12
                              : 16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: isMobile() ? Get.width : Get.width * 0.62,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isMobile() ? const SizedBox.shrink() : const Spacer(),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          footerQuickLindTitle('SOLUTIONS'),
                          footerQuickLind('Buy',
                              onTap: () => propCtrl.setAllPropertiesWeb(
                                  navItem: NavItems.buy)),
                          footerQuickLind('Rent',
                              onTap: () => propCtrl.setAllPropertiesWeb(
                                  navItem: NavItems.rent)),
                          footerQuickLind('New Home',
                              onTap: () => propCtrl.setAllPropertiesWeb(
                                  navItem: NavItems.newHomes)),
                          footerQuickLind('Short-stay',
                              onTap: () => propCtrl.setAllPropertiesWeb(
                                  navItem: NavItems.shortStay)),
                          footerQuickLind('Commercial',
                              onTap: () => propCtrl.setAllPropertiesWeb(
                                  navItem: NavItems.commercial)),
                          footerQuickLind('Premium Realtors',
                              onTap: () => propCtrl.setAllPropertiesWeb(
                                  navItem: NavItems.premiumRealtors)),
                        ]),
                    const Spacer(flex: 2),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          footerQuickLindTitle('SUPPORT'),
                          footerQuickLind('FAQs',
                              onTap: () => Get.to(() => FaqPage())),
                          footerQuickLind('Contact',
                              onTap: () => openWebContact()),
                          footerQuickLind('Feedback',
                              onTap: () => sendFeedback()),
                          const SizedBox(height: 15),
                          footerQuickLindTitle('COMPANY'),
                          footerQuickLind('About',
                              onTap: () => Get.toNamed(RouteStr.webAboutUs)),
                          footerQuickLind('Terms & Conditions',
                              onTap: () => Get.toNamed(RouteStr.webTerms)),
                          footerQuickLind('Privacy Policy',
                              onTap: () => Get.toNamed(RouteStr.webPolicy)),
                        ]),
                    isTabletDown() ? const SizedBox.shrink() : const Spacer(),
                    Expanded(
                      flex: 4,
                      child: LayoutBuilder(builder: (context, constraint) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: constraint.maxWidth,
                                  child: const CustomText(
                                      color: Colors.white,
                                      text: 'Subscribe to Our Newsletter',
                                      weight: FontWeight.w600,
                                      size: 18)),
                              const SizedBox(
                                height: 12,
                              ),
                              SizedBox(
                                width: constraint.maxWidth,
                                child: const Text(
                                  'Join our subscribers list to get the latest news, update, and special offers delivered directly to your inbox',
                                  style: TextStyle(color: Colors.white54),
                                ),
                              ),
                              const SizedBox(height: 8),
                              FormInput(
                                txColor: Colors.white,
                                width: constraint.maxWidth,
                                topSpace: false,
                                controller: EditCtrl.newsLetterEmail,
                                error: EditCtrl.newsLetterEmailErr,
                                validate: Val.email,
                                hint: 'Email address',
                                borderColor: Colors.white,
                              ),
                              FormButton(
                                  onPressed: () =>
                                      homeCtrl.subscribeToNewsLetter(),
                                  txtColor: Colors.white),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                height: 44,
                                padding: const EdgeInsets.only(left: 0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        const BorderRadius.all(const Radius.circular(4)),
                                    border: true
                                        ? Border.all(color: Colors.black12)
                                        : null),
                                margin:
                                    const EdgeInsets.only(left: 0, right: 0),
                                child: Obx(
                                  () => DropdownButton<String>(
                                    iconEnabledColor: Colors.black54,
                                    icon: const Icon(
                                      Icons.arrow_drop_down_outlined,
                                      size: 32,
                                    ),
                                    isExpanded: true,
                                    iconSize: 24,
                                    focusColor: Colors.black12,
                                    alignment: Alignment.bottomCenter,
                                    elevation: 3,
                                    underline: Container(color: Colors.white),
                                    value: EditCtrl.country.value.text == ' ' ||
                                            !countryList.contains(
                                                EditCtrl.country.value.text)
                                        ? null
                                        : EditCtrl.country.value.text,
                                    onChanged: (newValue) {
                                      if (newValue == '🇳🇬 Nigeria') {
                                        MSG.snackBar(
                                            'Explore our diverse collection of properties');
                                        EditCtrl.country.value.text = newValue!;
                                        EditCtrl.country.refresh();
                                      } else {
                                        MSG.errorSnackBar(
                                            'We do not have properties available here now');
                                        EditCtrl.country.value.text = newValue!;
                                        EditCtrl.country.refresh();
                                      }
                                    },
                                    hint: const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Select Country',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    items: countryList.map((data) {
                                      return DropdownMenuItem<String>(
                                        value: data.toString(),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: Text(data,
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 16)),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              )
            ]),
          ],
        ),
      ),
      Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: mainPadding, vertical: 16),
        color: Pallet.bottomBarColor,
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: 16,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white)),
                    child: const CustomText(
                      text: 'C',
                      size: 10,
                      color: Colors.white,
                    )),
                const SizedBox(width: 6),
                const CustomText(
                    color: Colors.white54,
                    text: '2022 Brix Market, Inc. All rights reserved',
                    weight: FontWeight.w300,
                    size: 14),
              ],
            ),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse('https://swizel.co/'));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  CustomText(
                    text: 'Built by',
                    size: 17,
                    weight: FontWeight.w300,
                    color: Colors.white,
                  ),
                  SizedBox(width: 6),
                  CustomText(
                      color: Colors.red,
                      text: 'Swizel',
                      weight: FontWeight.w300,
                      size: 17),
                ],
              ),
            ),
            const AppSocialIcons(),
          ],
        ),
      ),
    ],
  );
}

footerQuickLind(text, {onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: GestureDetector(
      onTap: onTap ?? () => null,
      child: CustomText(
          color: Colors.white54,
          text: text,
          weight: FontWeight.w300,
          size: isTabletDown()
              ? isMobile()
                  ? 14
                  : 12
              : 16),
    ),
  );
}

footerQuickLindTitle(text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: CustomText(
        color: Colors.white,
        text: text,
        weight: FontWeight.w500,
        size: isTabletDown()
            ? isMobile()
                ? 14
                : 12
            : 16),
  );
}

columnList({text1, text2, text3, text4, text5, text6}) {
  double fontSize = isTabletDown()
      ? isMobile()
          ? 14
          : 12
      : 16;
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    CustomText(
        color: Colors.white,
        text: text1,
        weight: FontWeight.w500,
        size: fontSize),
    const SizedBox(
      height: 20,
    ),
    CustomText(
        color: Colors.white54,
        text: text2,
        weight: FontWeight.w300,
        size: fontSize),
    const SizedBox(
      height: 10,
    ),
    CustomText(
        color: Colors.white54,
        text: text3,
        weight: FontWeight.w300,
        size: fontSize),
    const SizedBox(
      height: 12,
    ),
    CustomText(
        color: Colors.white54,
        text: text4,
        weight: FontWeight.w300,
        size: fontSize),
    const SizedBox(
      height: 12,
    ),
    CustomText(
        color: Colors.white54,
        text: text5,
        weight: FontWeight.w300,
        size: fontSize),
    const SizedBox(
      height: 12,
    ),
    CustomText(
        color: Colors.white54,
        text: text6,
        weight: FontWeight.w300,
        size: fontSize),
  ]);
}

openWebContact() {
  return showMaterialModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: Get.context!,
    builder: (context) => Align(
      alignment: Alignment.topRight,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        constraints: const BoxConstraints(maxWidth: 480),
        child: const ContactPage(web: true),
      ),
    ),
  );
}
