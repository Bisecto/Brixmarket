import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../widgets/footer_page.dart';
import '../widgets/navbar.dart';

class AboutUsPage extends StatelessWidget {
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
                        color: const Color(0xFF7a869f),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: TextStyles.richTexts(
                                  onPress1: () {},
                                  onPress2: () {},
                                  size: 11,
                                  decoration: TextDecoration.underline,
                                  weight: FontWeight.w300,
                                  color: Colors.white,
                                  color2: Colors.white60,
                                  centerText: true,
                                  text1:
                                      'Updates!! You can now pre order houses on a single click without hassele   ',
                                  text2: ' learn more',
                                  text3: '',
                                  text4: ''),
                            ),
                            const SizedBox(width: 80),
                            const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 33,
                        color: const Color.fromARGB(153, 206, 203, 203),
                        padding: const EdgeInsets.only(left: 120),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CustomText(
                              text: 'Home',
                              size: 11,
                              color: Pallet.secondaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 11,
                              color: Colors.black54,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomText(
                              text: 'About Us',
                              size: 11,
                              color: Pallet.secondaryColor,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 80),
                        height: 200,
                        width: Get.width,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                scale: 0.5,
                                image: AssetImage(
                                  'assets/images/smile.jpg',
                                ))),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 80),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const CustomText(
                                                color: Colors.black,
                                                text: 'About Brixmarket',
                                                weight: FontWeight.w800,
                                                size: 24),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              height: 3,
                                              width: 60,
                                              color: Pallet.secondaryColor,
                                            ),
                                          ]),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Image.asset(
                                            'assets/images/banner.png'),
                                      )
                                    ],
                                  )),
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                  flex: 8,
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                    color: Pallet.secondaryColor
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40)),
                                                child: const Icon(Icons.work,
                                                    size: 16,
                                                    color:
                                                        Pallet.secondaryColor),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              const CustomText(
                                                  color: Pallet.secondaryColor,
                                                  text: 'WHO WE ARE',
                                                  weight: FontWeight.w800,
                                                  size: 18),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          const CustomText(
                                              color: Colors.black,
                                              maxLines: 100,
                                              textAlign: TextAlign.justify,
                                              text:
                                                  'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?',
                                              weight: FontWeight.w200,
                                              size: 14),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                    color: Pallet.secondaryColor
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40)),
                                                child: const Icon(
                                                    Icons.visibility,
                                                    size: 16,
                                                    color:
                                                        Pallet.secondaryColor),
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              const CustomText(
                                                  color: Pallet.secondaryColor,
                                                  text: 'OUR VISION',
                                                  weight: FontWeight.w800,
                                                  size: 18),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          const CustomText(
                                              color: Colors.black,
                                              maxLines: 100,
                                              textAlign: TextAlign.justify,
                                              text:
                                                  'accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.',
                                              weight: FontWeight.w200,
                                              size: 14),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                    color: Pallet.secondaryColor
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40)),
                                                child: const Icon(Icons.castle,
                                                    size: 16,
                                                    color:
                                                        Pallet.secondaryColor),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              const CustomText(
                                                  color: Pallet.secondaryColor,
                                                  text: 'OUR MISSION',
                                                  weight: FontWeight.w800,
                                                  size: 18),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          const CustomText(
                                              color: Colors.black,
                                              maxLines: 100,
                                              textAlign: TextAlign.justify,
                                              text:
                                                  'accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium. accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab eaque ipsa quae ab Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium. accusantium doloremque laudantium,',
                                              weight: FontWeight.w200,
                                              size: 14),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 100,
                                      ),
                                    ],
                                  )),
                            ],
                          )),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 0.5, width: 100, color: Colors.grey),
                            const SizedBox(
                              width: 20,
                            ),
                            const CustomText(
                              text: 'Our Core Services',
                              size: 28,
                              color: Colors.blueGrey,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                                height: 0.5, width: 100, color: Colors.grey),
                          ]),
                      const SizedBox(
                        height: 100,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Image.asset('assets/images/oval1.png'),
                                const SizedBox(
                                  height: 10,
                                ),
                                const CustomText(
                                  text: 'Buy',
                                  size: 18,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomText(
                                  text:
                                      'At vero eos et accusamus et iusto odio dignissimos',
                                  size: 12,
                                  color: Colors.blueGrey.shade300,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset('assets/images/oval2.png'),
                                const SizedBox(
                                  height: 10,
                                ),
                                const CustomText(
                                  text: 'Sell',
                                  size: 18,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomText(
                                  text:
                                      'At vero eos et accusamus et iusto odio dignissimos',
                                  size: 12,
                                  color: Colors.blueGrey.shade300,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset('assets/images/oval3.png'),
                                const SizedBox(
                                  height: 10,
                                ),
                                const CustomText(
                                  text: 'Rent/Lease',
                                  size: 18,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomText(
                                  text:
                                      'At vero eos et accusamus et iusto odio dignissimos',
                                  size: 12,
                                  color: Colors.blueGrey.shade300,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 150,
                      ),
                      SizedBox(
                        height: 300,
                        width: Get.width,
                        child: Row(
                          children: [
                            Container(
                              height: 500,
                              width: 50.w,
                              color: const Color(0xFFe0e0e0),
                              child: Center(
                                  child:
                                      Image.asset('assets/images/person.png')),
                            ),
                            Container(
                              height: 300,
                              width: 50.w,
                              color: const Color(0xFF7A869F),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                        maxLines: 2,
                                        text:
                                            'Quality makes the \nbelief for customers.',
                                        size: 24,
                                        color: Colors.white,
                                        weight: FontWeight.bold,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const CustomText(
                                        textAlign: TextAlign.justify,
                                        maxLines: 4,
                                        text:
                                            'voluptatum deleniti atque Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident',
                                        size: 10,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset('assets/images/play.png'),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          const CustomText(
                                            text: 'Watch video',
                                            size: 9,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      const CustomText(
                        text: 'OUR PARTNERS',
                        size: 9,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Image.asset('assets/images/partners.png'),
                      const SizedBox(
                        height: 250,
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
