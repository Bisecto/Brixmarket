import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/instance.dart';
import '../../../res/strings.dart';
import '../../../utils/utils.dart';
import '../../widgets/signup_home_button.dart';

class SignUpHomePage extends StatelessWidget {
  const SignUpHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: Pallet.primaryBackground,
        appBar: Utils.isMobileApp
            ? AppBar(
                backgroundColor: Pallet.primaryBackground,
                elevation: 0,
                foregroundColor: Colors.black54,
                automaticallyImplyLeading: true,
              )
            : null,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Utils.isMobileApp
                  ? Column(
                      children: [
                        Utils.isMobileApp ? const SizedBox.shrink() : SizedBox(height: 8.h),
                        Image.asset(ImgStr.logo1, width: 120),
                        SizedBox(height: 5.h),
                        const Divider(
                          color: Color.fromARGB(255, 221, 214, 214),
                          thickness: 1,
                          endIndent: 5,
                          indent: 5,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    )
                  : Container(
                      width: Get.width,
                      decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/hero1.jpg'))),
                      child: Container(
                        width: Get.width,
                        color: Colors.black.withOpacity(0.7),
                        padding: const EdgeInsets.only(top: 48),
                        child: Column(
                          children: [
                            GestureDetector(onTap: () => Get.toNamed(RouteStr.webHome), child: Image.asset(ImgStr.logoLight, width: 180)),
                            SizedBox(height: 2.h),
                            CustomText(
                              text: 'Create an account for free',
                              size: isMobile()
                                  ? 18
                                  : isTablet()
                                      ? 24
                                      : 32,
                              color: Colors.white,
                              weight: FontWeight.bold,
                            ),
                            SizedBox(height: 5.h)
                          ],
                        ),
                      ),
                    ),
              SizedBox(
                height: 5.h,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(height: 0.5, width: Get.width <= 420 ? Get.width * 0.2 : 150, color: Colors.grey),
                const SizedBox(
                  width: 16,
                ),
                const CustomText(
                  text: Str.signUpAs,
                  size: 18,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(height: 0.5, width: Get.width <= 420 ? Get.width * 0.2 : 150, color: Colors.grey),
              ]),
              SignUpHomeButtons(
                height: 44,
                onPressed: () => homeCtrl.gotoSignUpPage(Str.user),
                text: Str.individual,
                width: Get.width <= 420 ? Get.width * 0.8 : 360,
              ),
              SignUpHomeButtons(
                height: 44,
                onPressed: () => homeCtrl.gotoSignUpPage(Str.agent),
                text: Str.realTorAgent,
                width: Get.width <= 420 ? Get.width * 0.8 : 360,
              ),
              SignUpHomeButtons(
                height: 44,
                onPressed: () => homeCtrl.gotoSignUpPage(Str.agency),
                text: Str.developerAgency,
                width: Get.width <= 420 ? Get.width * 0.8 : 360,
              ),
              const SizedBox(height: 35),
              SizedBox(
                  width: Get.width <= 420 ? Get.width * 0.8 : 360,
                  child: Center(
                    child: TextStyles.richTexts(
                      onPress1: () => Get.offNamed(RouteStr.login),
                      size: 16,
                      text1: Str.haveAccountQ,
                      text2: Str.signIn,
                    ),
                  )),
            ],
          ),
        ),
      );
    });
  }
}
