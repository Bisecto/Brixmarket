import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../widgets/custom_button.dart';
import '../widgets/footer_page.dart';
import '../widgets/navbar.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: Colors.white,
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      navBar(),
                      Container(
                        height: 35,
                        color: Colors.white,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 80),
                        width: Get.width,
                        height: Get.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/nopage.png'),
                            const SizedBox(
                              height: 12,
                            ),
                            const CustomText(
                                maxLines: 2,
                                color: Colors.black,
                                text:
                                    'You need not to find the page you\'re looking for',
                                weight: FontWeight.w200,
                                size: 11),
                            const SizedBox(
                              height: 8,
                            ),
                            FormButton(
                              onPressed: () {},
                              text: 'Back to Home',
                              width: 150,
                              height: 28,
                              txtColor: Colors.white,
                              size: 10,
                              radius: 4,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 120,
                      ),
                      Container(
                        height: 72,
                        color: Pallet.secondaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CustomText(
                                color: Colors.white,
                                text:
                                    'Are you an estate agent or developer? List your property for FREE.',
                                weight: FontWeight.w200,
                                size: 14),
                            const SizedBox(width: 80),
                            Container(
                              height: 35,
                              width: 95,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(left: 8),
                              child: Center(
                                child: CustomText(
                                    color: Colors.blueGrey[600],
                                    text: 'Register',
                                    weight: FontWeight.w500,
                                    size: 12),
                              ),
                              color: Pallet.whiteColor,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      pageFooter(),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}
