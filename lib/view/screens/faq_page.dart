import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/utils/utils.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/instance.dart';
import '../widgets/footer_page.dart';
import '../widgets/main_drawer.dart';
import '../widgets/mobile_appbar.dart';

class FaqPage extends StatefulWidget {
  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  bool isOpen = false;
  int pageNumber = -1;
  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  Set active = {};

  void _handleTap(index) {
    setState(() {
      active.contains(index) ? active.remove(index) : active.add(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    double mainPadding = Get.width < 480 ? Get.width * 0.05 : Get.width * 0.06;
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        key: homeScaffoldKey,
        backgroundColor: Pallet.primaryBackgroundLight,
        drawer: buildDrawer(context),
        appBar: appBarWeb(homeScaffoldKey),
        body: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 32,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: mainPadding),
                  width: Get.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          scale: 1,
                          image: AssetImage(
                            'assets/images/faq.jpeg',
                          ))),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: mainPadding),
                    child: Row(
                      children: [
                        isTabletDown()
                            ? const SizedBox.shrink()
                            : Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      const CustomText(color: Colors.black, text: 'Frequently Asked\nQuestions', weight: FontWeight.w800, size: 24),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 3,
                                        width: 60,
                                        color: Pallet.secondaryColor,
                                      ),
                                    ]),
                                    // const SizedBox(
                                    //   height: 30,
                                    // ),
                                    // Align(
                                    //   alignment: Alignment.centerLeft,
                                    //   child: Image.asset('assets/images/banner.png'),
                                    // )
                                  ],
                                )),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                            flex: 8,
                            child: Container(
                              color: const Color(0xFFf9f9f9),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 30),
                                      width: double.infinity,
                                      color: Colors.white,
                                      child: Material(
                                        type: MaterialType.card,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: homeCtrl.faqs.length,
                                            itemBuilder: ((context, index) {
                                              return Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (() {
                                                      setState(() {
                                                        _handleTap(index);
                                                      });
                                                    }),
                                                    child: Container(
                                                        height: 50,
                                                        width: MediaQuery.of(context).size.width,
                                                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                                        decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            CustomText(
                                                              maxLines: 2,
                                                              text: homeCtrl.faqs[index].question,
                                                              size: 15,
                                                              weight: FontWeight.w600,
                                                              color: Colors.black,
                                                            ),
                                                            active.contains(index)
                                                                ? const Icon(
                                                                    Icons.remove,
                                                                    color: Pallet.secondaryColor,
                                                                    size: 17,
                                                                  )
                                                                : const Icon(
                                                                    Icons.add,
                                                                    color: Pallet.secondaryColor,
                                                                    size: 17,
                                                                  )
                                                          ],
                                                        )),
                                                  ),
                                                  Visibility(
                                                    visible: active.contains(index) ? true : false,
                                                    child: AnimatedContainer(
                                                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                                      width: double.infinity,
                                                      duration: const Duration(seconds: 1),
                                                      child: Text(
                                                        homeCtrl.faqs[index].answer,
                                                        style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            })),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ],
                    )),
                const SizedBox(
                  height: 150,
                ),
                Container(
                  height: 150,
                  color: const Color(0xFFf9f9f9),
                  margin: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CustomText(
                        color: Colors.blueGrey,
                        text: 'Need support? Reach out to us',
                        weight: FontWeight.w400,
                        size: 18,
                        maxLines: 2,
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () => openWebContact(),
                        child: Container(
                          height: 35,
                          width: 70,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(left: 8),
                          child: const Center(
                            child: CustomText(color: Colors.white, text: 'Contact Us', weight: FontWeight.w500, size: 12),
                          ),
                          color: Pallet.secondaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 150,
                // ),
                pageFooter(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
