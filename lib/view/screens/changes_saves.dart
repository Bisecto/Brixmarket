import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ChangesMadeSuccess extends StatelessWidget {
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 50,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            color: Pallet.secondaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        const CustomText(
                          size: 14,
                          color: Colors.black,
                          weight: FontWeight.bold,
                          text: 'Request password was successful',
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        const CustomText(
                          maxLines: 2,
                          text:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit,\nsed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                          size: 12,
                          weight: FontWeight.w500,
                        ),
                      ],
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
