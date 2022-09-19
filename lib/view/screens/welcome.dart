import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class WelcomePage extends StatelessWidget {
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
                          const CustomText(
                            size: 14,
                            color: Colors.black,
                            weight: FontWeight.bold,
                            text: 'Hi John Doe, Welcome to Brixmarket',
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                          const CustomText(
                            maxLines: 1,
                            text:
                                'we are setting you up. This may take a moment',
                            size: 11,
                            color: Colors.black,
                            weight: FontWeight.w300,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Container(
                              width: 300,
                              height: 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: LinearProgressIndicator(
                                  value: null,
                                  color: Pallet.secondaryColor,
                                  backgroundColor:
                                      Colors.grey.withOpacity(0.8))),
                        ],
                      ),
                    ),
                  ),
                ),
          bottomNavigationBar: (constraints.maxWidth <= 950)
              ? Container(
                  height: 0,
                )
              : Container(
                  height: 130,
                  width: 70.w,
                  margin: const EdgeInsets.fromLTRB(150, 0, 150, 40),
                  color: Colors.grey,
                ));
    });
  }
}
