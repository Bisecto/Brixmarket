import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/libs/launch_urls.dart';
import 'package:brixmarket/res/strings.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';
import '../widgets/footer_page.dart';
import '../widgets/main_drawer.dart';
import '../widgets/mobile_appbar.dart';

class AboutUsWeb extends StatelessWidget {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  AboutUsWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mainPadding = Get.width < 480 ? Get.width * 0.05 : Get.width * 0.06 + Get.width * 0.009;
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        key: homeScaffoldKey,
        backgroundColor: Pallet.primaryBackgroundLight,
        drawer: buildDrawer(context),
        appBar: appBarWeb(homeScaffoldKey),
        body: Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              color: Pallet.primaryBackgroundLight,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.width,
                      decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/hero1.jpg'))),
                      child: Container(
                        width: Get.width,
                        height: isMobile() ? 140 : 300,
                        color: Colors.black.withOpacity(0.7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: 'About Us',
                              size: isMobile() ? 32 : 48,
                              color: Colors.white,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 108),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: mainPadding),
                      child: LayoutBuilder(builder: (context, constraints) {
                        double lWidth = constraints.maxWidth;
                        return Column(children: [
                          Wrap(
                            runSpacing: 48,
                            spacing: 32,
                            children: [
                              Image.asset(
                                'assets/images/welcome3.jpg',
                                width: isTabletDown() ? lWidth : lWidth * 0.5,
                              ),
                              SizedBox(
                                width: isTabletDown() ? lWidth : lWidth * 0.5 - 32,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomText(
                                      text: 'ABOUT US',
                                      color: Pallet.secondaryColor,
                                      weight: FontWeight.w700,
                                      size: 18,
                                    ),
                                    CustomText(
                                      text: 'Company Description',
                                      weight: FontWeight.w700,
                                      size: isMobile() ? 28 : 42,
                                      maxLines: 2,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 18.0, bottom: 24),
                                      child: Text(
                                          'Brixmarket is an online marketplace for real-estate in Nigeria. Brixmarket aim to bring the best real-estate deals to both buyers and sellers. We are making every type of real-estate property from commercial buildings, homes, and estates to parking lots and shop shelf space available for sale, lease, or rent',
                                          style: TextStyle(
                                            color: Pallet.blueGray,
                                            height: 2,
                                            fontSize: 16,
                                          )),
                                    ),
                                    const CustomText(
                                      text: 'Mission',
                                      color: Pallet.secondaryColor,
                                      weight: FontWeight.w700,
                                      size: 18,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 24),
                                      child: Text('To connect landlords and property seekers in a safe space.  ',
                                          style: TextStyle(
                                            color: Pallet.blueGray,
                                            height: 2,
                                            fontSize: 16,
                                          )),
                                    ),
                                    const CustomText(
                                      text: 'Vision',
                                      color: Pallet.secondaryColor,
                                      weight: FontWeight.w700,
                                      size: 18,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 24),
                                      child: Text('To become Africa’s leading real-estate Marketplace',
                                          style: TextStyle(
                                            color: Pallet.blueGray,
                                            height: 2,
                                            fontSize: 16,
                                          )),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 80),
                          downloadOurApp(lWidth),
                        ]);
                      }),
                    ),
                    const SizedBox(height: 24),
                    pageFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

downloadOurApp(lWidth) {
  return Wrap(
    runSpacing: 48,
    spacing: 32,
    children: [
      SizedBox(
        width: isTabletDown() ? lWidth : lWidth * 0.5,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/p2.png',
              width: isTabletDown() ? lWidth * 0.6 : lWidth * 0.25,
            ),
            Image.asset(
              'assets/images/p1.png',
              width: isTabletDown() ? lWidth * 0.4 : lWidth * 0.165,
            ),
          ],
        ),
      ),
      SizedBox(
        width: isTabletDown() ? lWidth : lWidth * 0.5 - 32,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Download our App',
              color: Pallet.secondaryColor,
              weight: FontWeight.w700,
              size: 18,
            ),
            CustomText(
              text: 'Find the best properties from our top listing',
              weight: FontWeight.w600,
              size: isMobile() ? 28 : 38,
              color: Colors.black87,
              maxLines: 2,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 18.0, bottom: 32),
              child: Text(Str.downloadOurAppDescription,
                  style: TextStyle(
                    color: Pallet.blueGray,
                    height: 2,
                    fontSize: 16,
                  )),
            ),
            FittedBox(
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                OpenUrl(
                  url: Str.downloadIOSLink,
                  widget: Container(
                    width: 180,
                    height: 72,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Pallet.secondaryColor, Color(0xFFFE6606)]),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Image.asset(
                      'assets/images/apple-store.png',
                      color: Colors.white,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: isMobile() ? 16 : 32),
                OpenUrl(
                  url: Str.downloadAndroidLink,
                  widget: Container(
                    width: 180,
                    height: 72,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF038D4B), Colors.greenAccent]),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Image.asset(
                      'assets/images/play-store.png',
                      color: Colors.white,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: isMobile() ? 16 : 32),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Pallet.secondaryColor, Color(0xFFFE6606)]),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.asset('assets/images/qrcode.png', fit: BoxFit.contain, width: 108),
                ),
              ]),
            ),
          ],
        ),
      )
    ],
  );
}
