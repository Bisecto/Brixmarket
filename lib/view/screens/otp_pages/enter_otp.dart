import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class EnterOtpPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  String smsOTP = '';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: Pallet.primaryBackground,
        body: (constraints.maxWidth <= 950)
            ? Center(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    text: 'Display mobile view',
                  ),
                  CustomText(
                    text: '${constraints.maxWidth}',
                    size: 22,
                    weight: FontWeight.w800,
                  ),
                ],
              ))
            : Container(
                height: Get.height,
                width: 100.w,
                color: Colors.white,
                margin: const EdgeInsets.only(
                  top: 30,
                ),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: Get.height,
                    width: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Image.asset('assets/images/brixmarketlogo.png'),
                        SizedBox(
                          height: 9.h,
                        ),
                        TextStyles.richTexts(
                            onPress1: () {},
                            onPress2: () {},
                            size: 11,
                            weight: FontWeight.w600,
                            color: Colors.black54,
                            color2: Pallet.secondaryColor,
                            text1: 'We have sent an OTP to your phone number\n',
                            text2: '+23408023803423.',
                            text3: '  Please input the six digit number',
                            text4: ''),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          height: 0.5,
                          width: 110,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        const CustomText(
                          size: 9,
                          color: Colors.black,
                          weight: FontWeight.bold,
                          text: 'Enter OTP code',
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        otpTextField(context),
                        SizedBox(
                          height: 6.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextStyles.richTexts(
                                onPress1: () {},
                                onPress2: () {},
                                size: 11,
                                weight: FontWeight.w600,
                                color: Colors.black54,
                                color2: Pallet.secondaryColor,
                                text1: 'Didn\'t recieve the OTP?',
                                text2: ' Resend code',
                                text3: '',
                                text4: ''),
                            const SizedBox(width: 55),
                            CustomText(
                              maxLines: 1,
                              text: 'Resend in 2:00',
                              size: 11,
                              color: Colors.grey.withOpacity(0.8),
                              weight: FontWeight.w300,
                            ),
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

  Widget otpTextField(BuildContext context) {
    return Form(
      key: formKey,
      child: SizedBox(
        width: 300,
        child: PinCodeTextField(
          appContext: context,
          autoFocus: true,
          autoDisposeControllers: false,
          enablePinAutofill: true,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          pastedTextStyle: const TextStyle(
            color: Colors.white,
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
            fieldHeight: 32,
            fieldOuterPadding: const EdgeInsets.all(0),
            fieldWidth: 32,
          ),
          cursorColor: Pallet.secondaryColor,
          animationDuration: const Duration(milliseconds: 0),
          textStyle: const TextStyle(
              fontSize: 18, height: 1.3, color: Pallet.secondaryColor),
          backgroundColor: Colors.white,
          enableActiveFill: true,
          controller: TextEditingController(text: ''),
          keyboardType: TextInputType.number,
          onCompleted: (v) {
            formKey.currentState!.validate();

            // if (controller.currentText.value.length != 6) {
            // } else {
            //   // controller.textEditingController.value.text = '';
            //   // sendOtp(otp: v, user: widget.userId);
            // }
          },
          onChanged: (value) {
            // controller.currentText.value = value;
          },
          beforeTextPaste: (text) {
            return true;
          },
        ),
      ),
    );
  }
}
