import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../widgets/footer_page.dart';
import '../widgets/form_button.dart';
import '../widgets/form_inputs.dart';
import '../widgets/navbar.dart';

class ContactUsPage extends StatefulWidget {
  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  bool isOpen = false;
  int pageNumber = -1;

  Set active = {};

  void _handleTap(index) {
    setState(() {
      active.contains(index) ? active.remove(index) : active.add(index);
    });
  }

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
                              text: 'Contact Us',
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
                                scale: 1,
                                image: AssetImage(
                                  'assets/images/aerial.jpg',
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
                                  flex: 3,
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
                                                text: 'Contact Us',
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
                                      Container(
                                        width: 220,
                                        padding: const EdgeInsets.all(25),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          border: Border.all(
                                              color: Colors.grey.shade400,
                                              width: 0.5),
                                          color: const Color(0xFFf9f9f9),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            CustomText(
                                                color: Pallet.secondaryColor,
                                                text: 'Email',
                                                weight: FontWeight.w900,
                                                size: 14),
                                            SizedBox(height: 14),
                                            CustomText(
                                                color: Colors.blueGrey,
                                                text: 'info@brixmarket.com',
                                                weight: FontWeight.w400,
                                                size: 12),
                                            SizedBox(height: 14),
                                            Divider(
                                              thickness: 0.3,
                                            ),
                                            CustomText(
                                                color: Pallet.secondaryColor,
                                                text: 'Hot-line',
                                                weight: FontWeight.w900,
                                                size: 14),
                                            SizedBox(height: 14),
                                            CustomText(
                                                color: Colors.blueGrey,
                                                text: '00-1000399-33',
                                                weight: FontWeight.w400,
                                                size: 12),
                                            SizedBox(height: 10),
                                            CustomText(
                                                color: Colors.blueGrey,
                                                text: '001-1987399-30',
                                                weight: FontWeight.w400,
                                                size: 12),
                                            SizedBox(height: 14),
                                            Divider(
                                              thickness: 0.3,
                                            ),
                                            CustomText(
                                                color: Pallet.secondaryColor,
                                                text: 'Address',
                                                weight: FontWeight.w900,
                                                size: 14),
                                            SizedBox(height: 14),
                                            CustomText(
                                                color: Color.fromARGB(
                                                    255, 49, 84, 102),
                                                text:
                                                    'Abuja, Nigeria\nWuse District',
                                                weight: FontWeight.w700,
                                                size: 12),
                                            SizedBox(height: 14),
                                            CustomText(
                                                color: Color.fromARGB(
                                                    255, 49, 84, 102),
                                                text: 'Mexico',
                                                weight: FontWeight.w700,
                                                size: 12),
                                            SizedBox(height: 10),
                                            CustomText(
                                                color: Colors.blueGrey,
                                                text: 'perax centre, Adax',
                                                weight: FontWeight.w400,
                                                size: 12),
                                            SizedBox(height: 14),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                flex: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 50),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 0.5),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                          color: Colors.blueGrey,
                                          text: 'Mail a Request or Complaints',
                                          weight: FontWeight.w400,
                                          size: 20),
                                      const SizedBox(height: 30),
                                      FormInput(
                                        width: double.infinity,
                                        controller:
                                            TextEditingController(text: ''),
                                        label: 'Name',
                                        hint: 'Enter full Name',
                                      ),
                                      const SizedBox(height: 20),
                                      FormInput(
                                        width: double.infinity,
                                        controller:
                                            TextEditingController(text: ''),
                                        label: 'Email',
                                        hint: 'Enter Email',
                                      ),
                                      const SizedBox(height: 20),
                                      FormInput(
                                        width: double.infinity,
                                        controller:
                                            TextEditingController(text: ''),
                                        label: 'Phone number',
                                        hint: 'Enter Phone number',
                                      ),
                                      const SizedBox(height: 20),
                                      FormSelectInput(
                                        width: double.infinity,
                                        controller:
                                            TextEditingController(text: ''),
                                        label: 'Reason',
                                        hint: 'select reason',
                                      ),
                                      const SizedBox(height: 20),
                                      FormInput(
                                        height: 100,
                                        maxLines: 8,
                                        width: double.infinity,
                                        controller:
                                            TextEditingController(text: ''),
                                        label: 'Message',
                                        hint: 'Enter message',
                                      ),
                                      const SizedBox(height: 20),
                                      FormIconButton(
                                        width: 120,
                                        height: 30,
                                        onPressed: () {},
                                        fontSize: 9,
                                        text: 'Send message',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 80,
                      ),
                      Image.asset('assets/images/world.png'),
                      const SizedBox(
                        height: 30,
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
