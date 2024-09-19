import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SentEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (contex, constraints) {
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        const CustomText(
                          size: 14,
                          color: Colors.black,
                          weight: FontWeight.bold,
                          text: 'Request password was successful',
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextStyles.richTexts(
                            onPress1: () {},
                            onPress2: () {},
                            size: 11,
                            text1:
                                'we have sent an email activation link to your email,  ',
                            text2: ' JohnDoe****@gmail.com',
                            text3: '',
                            text4: ''),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          height: 1,
                          width: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 10),
                            child: const CustomText(
                              size: 10,
                              color: Colors.black,
                              weight: FontWeight.bold,
                              text: 'Resend link',
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.black54),
                            )),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextStyles.richTexts(
                            onPress1: () {},
                            onPress2: () {},
                            size: 11,
                            text1: 'Don\'t have access to your email? ',
                            text2: ' Skip this for now',
                            text3: '',
                            text4: ''),
                      ],
                    ),
                  ),
                ));
    });
  }
}
