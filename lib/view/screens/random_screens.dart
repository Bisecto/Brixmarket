// import 'package:brixmarket/res/strings.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../widgets/signup_home_button.dart';
//
// class RandomScreens extends StatelessWidget {
//   const RandomScreens({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox(
//         height: Get.height,
//         width: Get.width,
//         child: ListView(
//           shrinkWrap: true,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SignUpHomeButtons(
//                   text: 'Saved Changes',
//                   width: 220,
//                   onPressed: (() => Get.toNamed(savedchanges)),
//                 ),
//                 const SizedBox(
//                   height: 0,
//                 ),
//                 SignUpHomeButtons(
//                   text: 'Otp Page',
//                   width: 220,
//                   onPressed: (() => Get.toNamed(enterotppage)),
//                 ),
//                 SignUpHomeButtons(
//                   text: 'Welcome Page',
//                   width: 220,
//                   onPressed: (() => Get.toNamed(welcomepage)),
//                 ),
//                 SignUpHomeButtons(
//                   text: 'Home Page',
//                   width: 220,
//                   onPressed: (() => Get.toNamed(homePage)),
//                 ),
//                 SignUpHomeButtons(
//                   text: 'Property List',
//                   width: 220,
//                   onPressed: (() => Get.toNamed(propertyListPage)),
//                 ),
//                 SignUpHomeButtons(
//                   text: 'Property Details List',
//                   width: 220,
//                   onPressed: (() => Get.toNamed(propertydetailslist)),
//                 ),
//                 SignUpHomeButtons(
//                   text: 'About us Page',
//                   width: 220,
//                   onPressed: (() => Get.toNamed(aboutuspage)),
//                 ),
//                 SignUpHomeButtons(
//                   text: 'FAQ Page',
//                   width: 220,
//                   onPressed: (() => Get.toNamed(faqpage)),
//                 ),
//                 SignUpHomeButtons(
//                   text: 'Contact Us Page',
//                   width: 220,
//                   onPressed: (() => Get.toNamed(contactuspage)),
//                 ),
//                 SignUpHomeButtons(
//                   text: 'Terms of Use',
//                   width: 220,
//                   onPressed: (() => Get.toNamed(termspage)),
//                 ),
//                 SignUpHomeButtons(
//                   text: 'No Page Found',
//                   width: 220,
//                   onPressed: (() => Get.toNamed(errorpage)),
//                 ),
//                 SignUpHomeButtons(
//                   text: 'Flag Page',
//                   width: 220,
//                   onPressed: (() => Get.toNamed(flagpage)),
//                 ),
//                 SignUpHomeButtons(
//                   text: 'Create Property List',
//                   width: 220,
//                   onPressed: (() => Get.toNamed(dashboardPage)),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
