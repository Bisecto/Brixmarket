// import 'package:brixmarket/config/theme/color.dart';
// import 'package:brixmarket/view/widgets/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../controllers/terms_controller.dart';
// import '../../res/strings.dart';
// import '../widgets/footer_page.dart';
// import '../widgets/navbar.dart';
//
// class TermsPage extends GetView<TermsController> {
//   const TermsPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         body:  Container(
//                 height: Get.height,
//                 width: 100.w,
//                 color: Colors.white,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       navBar(),
//                       Container(
//                         height: 35,
//                         color: Colors.white,
//                       ),
//                       Container(
//                         height: 33,
//                         color: const Color.fromARGB(153, 206, 203, 203),
//                         padding: const EdgeInsets.only(left: 120),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: const [
//                             CustomText(
//                               text: 'Home',
//                               size: 11,
//                               color: Pallet.secondaryColor,
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Icon(
//                               Icons.arrow_forward_ios,
//                               size: 11,
//                               color: Colors.black54,
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             CustomText(
//                               text: 'Terms of Use',
//                               size: 11,
//                               color: Colors.black54,
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 70,
//                       ),
//                       Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 40),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                   flex: 1,
//                                   child: SizedBox(
//                                     height: 800,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Obx(() {
//                                           return GestureDetector(
//                                             onTap: () {
//                                               controller.selectedIndex.value =
//                                                   0;
//                                             },
//                                             child: Container(
//                                               height: 17,
//                                               width: 170,
//                                               decoration: BoxDecoration(
//                                                   border: Border(
//                                                       right: BorderSide(
//                                                           color: (controller
//                                                                       .selectedIndex
//                                                                       .value ==
//                                                                   0)
//                                                               ? Pallet
//                                                                   .secondaryColor
//                                                               : Colors
//                                                                   .transparent,
//                                                           width: 3))),
//                                               child: const Center(
//                                                 child: CustomText(
//                                                     color: Colors.black87,
//                                                     text: 'Terms of Use',
//                                                     textAlign: TextAlign.center,
//                                                     weight: FontWeight.w700,
//                                                     size: 11),
//                                               ),
//                                             ),
//                                           );
//                                         }),
//                                         const SizedBox(
//                                           height: 30,
//                                         ),
//                                         Obx(() {
//                                           return GestureDetector(
//                                             onTap: () {
//                                               controller.selectedIndex.value =
//                                                   1;
//                                             },
//                                             child: Container(
//                                               height: 17,
//                                               width: 170,
//                                               decoration: BoxDecoration(
//                                                   border: Border(
//                                                       right: BorderSide(
//                                                           color: (controller
//                                                                       .selectedIndex
//                                                                       .value ==
//                                                                   1)
//                                                               ? Pallet
//                                                                   .secondaryColor
//                                                               : Colors
//                                                                   .transparent,
//                                                           width: 3))),
//                                               child: const Center(
//                                                 child: CustomText(
//                                                     color: Colors.black87,
//                                                     text: 'Privacy          ',
//                                                     textAlign: TextAlign.start,
//                                                     weight: FontWeight.w700,
//                                                     size: 11),
//                                               ),
//                                             ),
//                                           );
//                                         }),
//                                         const SizedBox(
//                                           height: 30,
//                                         ),
//                                         Obx(() {
//                                           return GestureDetector(
//                                             onTap: () {
//                                               controller.selectedIndex.value =
//                                                   2;
//                                             },
//                                             child: Container(
//                                               height: 17,
//                                               width: 170,
//                                               decoration: BoxDecoration(
//                                                   border: Border(
//                                                       right: BorderSide(
//                                                           color: (controller
//                                                                       .selectedIndex
//                                                                       .value ==
//                                                                   2)
//                                                               ? Pallet
//                                                                   .secondaryColor
//                                                               : Colors
//                                                                   .transparent,
//                                                           width: 3))),
//                                               child: const Center(
//                                                 child: CustomText(
//                                                     color: Colors.black87,
//                                                     text: 'Cookie Policy',
//                                                     textAlign: TextAlign.center,
//                                                     weight: FontWeight.w700,
//                                                     size: 11),
//                                               ),
//                                             ),
//                                           );
//                                         }),
//                                       ],
//                                     ),
//                                   )),
//                               const SizedBox(
//                                 width: 170,
//                               ),
//                               Expanded(
//                                 flex: 8,
//                                 child: SizedBox(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Obx(() {
//                                         return IndexedStack(
//                                             alignment: Alignment.topCenter,
//                                             index:
//                                                 controller.selectedIndex.value,
//                                             children: <Widget>[
//                                               SizedBox(
//                                                 width: double.infinity,
//                                                 child: SingleChildScrollView(
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: const [
//                                                       CustomText(
//                                                           color: Colors.black,
//                                                           text:
//                                                               'TERMS & CONDITIONS',
//                                                           weight:
//                                                               FontWeight.w800,
//                                                           size: 16),
//                                                       SizedBox(height: 40),
//                                                       CustomText(
//                                                           maxLines: 5000,
//                                                           color: Colors.black,
//                                                           text: terms,
//                                                           weight:
//                                                               FontWeight.w300,
//                                                           size: 12),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: double.infinity,
//                                                 child: SingleChildScrollView(
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: const [
//                                                       CustomText(
//                                                           color: Colors.black,
//                                                           text:
//                                                               'PRIVACY POLICY GOVERNING BRIX MARKET',
//                                                           weight:
//                                                               FontWeight.w800,
//                                                           size: 16),
//                                                       SizedBox(height: 40),
//                                                       CustomText(
//                                                           maxLines: 5000,
//                                                           color: Colors.black,
//                                                           text: privacy,
//                                                           weight:
//                                                               FontWeight.w300,
//                                                           size: 12),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: double.infinity,
//                                                 child: SingleChildScrollView(
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: const [
//                                                       CustomText(
//                                                           color: Colors.black,
//                                                           text: 'COOKIE POLICY',
//                                                           weight:
//                                                               FontWeight.w800,
//                                                           size: 16),
//                                                       SizedBox(height: 40),
//                                                       CustomText(
//                                                           maxLines: 5000,
//                                                           color: Colors.black,
//                                                           text: cookie,
//                                                           weight:
//                                                               FontWeight.w300,
//                                                           size: 12),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ]);
//                                       })
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )),
//                       const SizedBox(
//                         height: 120,
//                       ),
//                       Container(
//                         height: 72,
//                         color: Pallet.secondaryColor,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const CustomText(
//                                 color: Colors.white,
//                                 text:
//                                     'Are you an estate agent or developer? List your property for FREE.',
//                                 weight: FontWeight.w200,
//                                 size: 14),
//                             const SizedBox(width: 80),
//                             Container(
//                               height: 35,
//                               width: 95,
//                               padding: const EdgeInsets.all(10),
//                               margin: const EdgeInsets.only(left: 8),
//                               child: Center(
//                                 child: CustomText(
//                                     color: Colors.blueGrey[600],
//                                     text: 'Register',
//                                     weight: FontWeight.w500,
//                                     size: 12),
//                               ),
//                               color: Pallet.whiteColor,
//                             )
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       pageFooter(),
//                     ],
//                   ),
//                 ),
//               ),
//       );
//     });
//   }
// }
