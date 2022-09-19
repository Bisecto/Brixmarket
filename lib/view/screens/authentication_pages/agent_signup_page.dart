import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/auth_side.dart';
import '../../widgets/form_button.dart';
import '../../widgets/form_inputs.dart';

class AgencySignUpPage extends StatelessWidget {
  AgencySignUpPage({Key? key}) : super(key: key);

  bool checkState = true;
  bool showNextPage = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (contex, constraints) {
      return Scaffold(
          backgroundColor: Pallet.primaryBackground,
          body: (constraints.maxWidth <= 817)
              ? mobileView(screenWidth: constraints.maxWidth)
              : webView(screenWidth: constraints.maxWidth));
    });
  }

  mobileView({double? screenWidth}) {
    return Row(
      children: [
        Builder(builder: (context) {
          return Container(
            height: Get.height,
            width: Get.width,
            color: Colors.white,
            margin: const EdgeInsets.only(top: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AuthSide(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: 'Agency Manager',
                          size: 12,
                          color: Colors.blueGrey,
                          weight: FontWeight.w800,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FormInput(
                          height: 45,
                          controller: TextEditingController(text: ''),
                          label: 'First Name',
                          hint: 'First Name',
                          width: double.infinity,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FormInput(
                          height: 45,
                          controller: TextEditingController(text: ''),
                          label: 'Last Name',
                          hint: 'Last Name',
                          width: double.infinity,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FormInput(
                          height: 45,
                          controller: TextEditingController(text: ''),
                          label: 'Email ',
                          hint: 'Email',
                          width: double.infinity,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FormInput(
                          height: 45,
                          controller: TextEditingController(text: ''),
                          label: 'Phone number',
                          hint: 'Phone number',
                          width: double.infinity,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FormInput(
                          height: 45,
                          controller: TextEditingController(text: ''),
                          label: 'Password ',
                          hint: 'Password',
                          width: double.infinity,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FormInput(
                          height: 45,
                          controller: TextEditingController(text: ''),
                          label: 'Confirm Password',
                          hint: 'Confirm Password',
                          width: double.infinity,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: 430,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                                width: 10,
                                child: Checkbox(
                                    activeColor: Pallet.secondaryColor,
                                    checkColor: Colors.white,
                                    side:
                                        const BorderSide(color: Colors.white),
                                    value: checkState,
                                    onChanged: (state) {
                                      checkState = state!;
                                    }),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: TextStyles.richTexts(
                                    onPress1: () {},
                                    onPress2: () {},
                                    size: 11,
                                    color2: Colors.blueGrey[900],
                                    text1: 'By signing up, you agree to our ',
                                    text2: ' Terms and Conditions',
                                    text3: '',
                                    text4: ''),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FormButton(
                          width: double.infinity,
                          height: 45,
                          textSize: 14,
                          text: 'Sign Up',
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Center(
                          child: TextStyles.richTexts(
                              onPress1: () {},
                              onPress2: () {},
                              size: 11,
                              text1: 'Already have an account? ',
                              text2: ' Sign In',
                              text3: '',
                              text4: ''),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        })
      ],
    );
  }

  webView({double? screenWidth}) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              height: Get.height,
              width: 35.w,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/house.jpg',
                      ))),
            ),
            Container(
              color: Colors.black.withOpacity(0.7),
              height: Get.height,
              width: 35.w,
            ),
            Positioned(
                top: 7.h,
                left: 10,
                right: 10,
                child: Image.asset('assets/images/brixmarketlogo.png')),
          ],
        ),
        Builder(builder: (context) {
          return Container(
            height: Get.height,
            width: 65.w,
            color: Colors.white,
            margin: const EdgeInsets.only(top: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 105),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: screenWidth.toString(),
                          size: 22,
                          weight: FontWeight.w800,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomText(
                          text: 'Sign up',
                          size: 22,
                          weight: FontWeight.w800,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomText(
                          maxLines: 2,
                          text:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit,\nsed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                          size: 12,
                          weight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    endIndent: 120,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 105),
                    child: CustomText(
                      text: 'Agency',
                      size: 12,
                      color: Colors.blueGrey,
                      weight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 105, right: 105),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: FormInput(
                                width: double.infinity,
                                controller: TextEditingController(text: ''),
                                label: 'Agency Name',
                                hint: 'Agency Name',
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: FormInput(
                                controller: TextEditingController(text: ''),
                                width: double.infinity,
                                label: 'RC Number',
                                hint: 'RC Number',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 105, right: 105),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: FormInput(
                                width: double.infinity,
                                controller: TextEditingController(text: ''),
                                label: 'State ',
                                hint: 'State',
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: FormInput(
                                width: double.infinity,
                                controller: TextEditingController(text: ''),
                                label: 'City',
                                hint: 'City',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 105, right: 105),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormInput(
                          width: double.infinity,
                          maxLines: 3,
                          height: 60,
                          controller: TextEditingController(text: ''),
                          label: 'Address',
                          hint: 'Address',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 105),
                    child: CustomText(
                      text: 'Agency Manager',
                      size: 12,
                      color: Colors.blueGrey,
                      weight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 105),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: FormInput(
                                width: double.infinity,
                                controller: TextEditingController(text: ''),
                                label: 'First Name',
                                hint: 'First Name',
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: FormInput(
                                width: double.infinity,
                                controller: TextEditingController(text: ''),
                                label: 'Last Name',
                                hint: 'Last Name',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: FormInput(
                                width: double.infinity,
                                controller: TextEditingController(text: ''),
                                label: 'Email ',
                                hint: 'Email',
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: FormInput(
                                width: double.infinity,
                                controller: TextEditingController(text: ''),
                                label: 'Phone number',
                                hint: 'Phone number',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: FormInput(
                                width: double.infinity,
                                controller: TextEditingController(text: ''),
                                label: 'Password ',
                                hint: 'Password',
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: FormInput(
                                width: double.infinity,
                                controller: TextEditingController(text: ''),
                                label: 'Confirm Password',
                                hint: 'Confirm Password',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FormButton(
                          width: 65.w,
                          text: 'Sign Up',
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        SizedBox(
                          width: 430,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                                width: 10,
                                child: Checkbox(
                                    activeColor: Pallet.secondaryColor,
                                    checkColor: Colors.white,
                                    side: const BorderSide(color: Colors.white),
                                    value: checkState,
                                    onChanged: (state) {
                                      checkState = state!;
                                    }),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: TextStyles.richTexts(
                                    onPress1: () {},
                                    onPress2: () {},
                                    size: 11,
                                    color2: Colors.blueGrey[900],
                                    text1: 'By signing up, you agree to our ',
                                    text2: ' Terms and Conditions',
                                    text3: '',
                                    text4: ''),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        SizedBox(
                            width: 430,
                            child: Center(
                              child: TextStyles.richTexts(
                                  onPress1: () {},
                                  onPress2: () {},
                                  size: 11,
                                  text1: 'Already have an account? ',
                                  text2: ' Sign In',
                                  text3: '',
                                  text4: ''),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        })
      ],
    );
  }
}
