// import 'package:brixmarket/config/theme/color.dart';
// import 'package:brixmarket/view/widgets/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../res/strings.dart';
// import '../../widgets/form_button.dart';
// import '../../widgets/form_inputs.dart';
//
// class EnterPasswordResetPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (contex, constraints) {
//       return Scaffold(
//           backgroundColor: Pallet.primaryBackground,
//           body: (constraints.maxWidth <= 950)
//               ? Center(
//                   child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     CustomText(
//                       text: 'Display mobile view',
//                     ),
//                   ],
//                 ))
//               : Container(
//                   height: Get.height,
//                   width: 100.w,
//                   color: Colors.white,
//                   margin: const EdgeInsets.only(
//                     top: 30,
//                   ),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           height: 8.h,
//                         ),
//                         SizedBox(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.only(
//                                   left:
//                                       (constraints.maxWidth < 1366) ? 53 : 250,
//                                   right:
//                                       (constraints.maxWidth < 1366) ? 53 : 250,
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Image.asset(
//                                         'assets/images/brixmarketlogo.png'),
//                                     Container(
//                                         height: 25,
//                                         width: 25,
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: Colors.black, width: 1),
//                                             borderRadius:
//                                                 BorderRadius.circular(40)),
//                                         child: const Icon(
//                                           Icons.close_sharp,
//                                           size: 18,
//                                         ))
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 40,
//                               ),
//                               Container(
//                                   padding: EdgeInsets.only(
//                                     left: (constraints.maxWidth < 1366)
//                                         ? 53
//                                         : 250,
//                                     right: (constraints.maxWidth < 1366)
//                                         ? 53
//                                         : 250,
//                                   ),
//                                   child: const Divider()),
//                               const SizedBox(
//                                 height: 40,
//                               ),
//                               Container(
//                                 padding: EdgeInsets.only(
//                                   left:
//                                       (constraints.maxWidth < 1366) ? 53 : 250,
//                                   right:
//                                       (constraints.maxWidth < 1366) ? 53 : 250,
//                                 ),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: const [
//                                         CustomText(
//                                           text: 'Reset Password',
//                                           size: 28,
//                                           weight: FontWeight.w800,
//                                         ),
//                                         SizedBox(
//                                           height: 20,
//                                         ),
//                                         CustomText(
//                                           maxLines: 2,
//                                           text:
//                                               'Lorem ipsum dolor sit amet, consectetur adipiscing elit,\nsed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
//                                           size: 12,
//                                           weight: FontWeight.w500,
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       width: 80,
//                                     ),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         FormInput(
//                                           controller:
//                                               TextEditingController(text: ''),
//                                           label: 'New Password',
//                                           hint: 'Enter Password',
//                                           width: 410,
//                                         ),
//                                         const SizedBox(
//                                           height: 20,
//                                         ),
//                                         FormInput(
//                                           controller:
//                                               TextEditingController(text: ''),
//                                           label: 'Confirm New Password',
//                                           hint: 'Confirm New Password',
//                                           width: 410,
//                                         ),
//                                         const SizedBox(
//                                           height: 20,
//                                         ),
//                                         FormButton(
//                                           width: 410,
//                                           text: 'Sign In',
//                                           onPressed: () {
//                                             Get.toNamed(resetpassword2);
//                                           },
//                                         ),
//                                         const SizedBox(
//                                           height: 28,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ));
//     });
//   }
// }
