import 'dart:async';

import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/controllers/edit_controller.dart';
import 'package:brixmarket/core/dialogs.dart';
import 'package:brixmarket/utils/utils.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../controllers/instance.dart';
import '../../../res/strings.dart';

class VerifyOtpPage extends StatefulWidget {
  VerifyOtpPage({Key? key}) : super(key: key);

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final formKey = GlobalKey<FormState>();
  String smsOTP = '';

  bool isTimerEnded = false;

  @override
  Widget build(BuildContext context) {
    var vh = Get.height;
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
        body: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.white,
          child: SingleChildScrollView(
            child: SizedBox(
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: vh * 0.1,
                  ),
                  Image.asset(ImgStr.logo1, width: 160),
                  const SizedBox(height: 90),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                          horizontal: (constraints.maxWidth <= 471 ? 24 : 0)),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextStyles.richTexts(
                          onPress1: () {},
                          onPress2: () {},
                          size: 16,
                          centerText: true,
                          weight: FontWeight.w600,
                          color: const Color.fromARGB(255, 19, 48, 63),
                          color2: Pallet.secondaryColor,
                          text1: 'We have sent an OTP to your phone email\n',
                          text2: homeCtrl.tmpUser.value.emailAddress,
                          text3: '  Please input the six digit number',
                          text4: '',
                        ),
                      )),
                  SizedBox(
                    height: vh * 0.08,
                  ),
                  Container(
                    height: 0.5,
                    width: 110,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: vh * 0.080,
                  ),
                  const CustomText(
                    size: 18,
                    color: Color.fromARGB(255, 19, 48, 63),
                    weight: FontWeight.bold,
                    text: 'Enter OTP Code',
                  ),
                  SizedBox(
                    height: vh * 0.030,
                  ),
                  otpTextField(
                      context: context, screenWidth: constraints.maxWidth),
                  SizedBox(
                    height: vh * 0.060,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: TextStyles.richTexts(
                            onPress1: () {
                              if (isTimerEnded) {
                                homeCtrl.resendOTP;
                              } else {
                                MSG.snackBar('Resend Code after 2 minutes');
                              }
                            },
                            onPress2: () {},
                            size: 14,
                            weight: FontWeight.w600,
                            color: const Color.fromARGB(255, 19, 48, 63),
                            color2: Pallet.secondaryColor,
                            text1: 'Didn\'t recieve the OTP?',
                            text2: ' Resend code',
                            text3: '',
                            text4: ''),
                      ),
                      const SizedBox(width: 55),
                      Flexible(
                        child: TweenAnimationBuilder<Duration>(
                            duration: Duration(minutes: 2),
                            tween: Tween(
                                begin: Duration(minutes: 2),
                                end: Duration.zero),
                            onEnd: () {
                              isTimerEnded = true;
                              print('Timer ended');
                            },
                            builder: (BuildContext context, Duration value,
                                Widget? child) {
                              final minutes = value.inMinutes;
                              final seconds = value.inSeconds % 60;
                              return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: CustomText(
                                    maxLines: 1,
                                    text: '$minutes:$seconds',
                                    size: 18,
                                    color: Color.fromARGB(255, 19, 48, 63),
                                    weight: FontWeight.w600,
                                  ));
                            }),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget otpTextField({BuildContext? context, double? screenWidth}) {
    return Form(
      key: formKey,
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: (screenWidth! <= 357 ? 24 : 0)),
        width: 300,
        child: PinCodeTextField(
          appContext: context!,
          autoFocus: true,
          autoDisposeControllers: false,
          enablePinAutofill: true,
          autoUnfocus: true,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          pastedTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          length: 6,
          obscureText: false,
          validator: (v) {
            if (v!.length < 6) {
              return "";
            } else {
              return null;
            }
          },
          pinTheme: PinTheme(
            activeColor: Colors.transparent,
            inactiveColor: Colors.transparent,
            selectedColor: Colors.transparent,
            activeFillColor: Colors.grey.withOpacity(0.3),
            inactiveFillColor: Colors.grey.withOpacity(0.3),
            selectedFillColor: Colors.grey.withOpacity(0.3),
            shape: PinCodeFieldShape.box,
            fieldHeight: 42,
            fieldOuterPadding: const EdgeInsets.all(0),
            fieldWidth: 42,
          ),
          cursorColor: Pallet.secondaryColor,
          animationDuration: const Duration(milliseconds: 0),
          textStyle: const TextStyle(
              fontSize: 16, height: 1.3, color: Pallet.secondaryColor),
          backgroundColor: Colors.white,
          enableActiveFill: true,
          controller: EditCtrl.otp,
          keyboardType: TextInputType.number,
          onCompleted: (v) {
            formKey.currentState!.validate();
          },
          onChanged: (value) {
            if (value.length == 6) {
              homeCtrl.verifyOTP();
            }
          },
          beforeTextPaste: (text) {
            return true;
          },
        ),
      ),
    );
  }
}
