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
// class IndividualSignUpPage extends StatelessWidget {
//   IndividualSignUpPage({Key? key}) : super(key: key);
//
//   bool checkState = true;
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (contex, constraints) {
//       return Scaffold(
//           backgroundColor: Pallet.primaryBackground,
//           body: (constraints.maxWidth <= 817)
//               ? Center(
//                   child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const CustomText(
//                       text: 'Display mobile view',
//                     ),
//                     CustomText(
//                       text: '${constraints.maxWidth}',
//                       size: 22,
//                       weight: FontWeight.w800,
//                     ),
//                   ],
//                 ))
//               : Row(
//                   children: [
//                     Stack(
//                       children: [
//                         Container(
//                           height: Get.height,
//                           width: 25.w,
//                           decoration: const BoxDecoration(
//                               image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: AssetImage(
//                                     'assets/images/house.jpg',
//                                   ))),
//                         ),
//                         Container(
//                           color: Colors.black.withOpacity(0.7),
//                           height: Get.height,
//                           width: 25.w,
//                         ),
//                         Positioned(
//                             top: 7.h,
//                             left: 10,
//                             right: 10,
//                             child: Image.asset(
//                                 'assets/images/brixmarketlogo.png')),
//                       ],
//                     ),
//                     Expanded(
//                       child: Builder(builder: (context) {
//                         return Container(
//                           height: Get.height,
//                           width: 75.w,
//                           color: Colors.white,
//                           margin: const EdgeInsets.only(top: 30),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height: 8.h,
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.only(left: 105),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: const [
//                                     CustomText(
//                                       text: 'Sign up',
//                                       size: 22,
//                                       weight: FontWeight.w800,
//                                     ),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     CustomText(
//                                       maxLines: 2,
//                                       text:
//                                           'Lorem ipsum dolor sit amet, consectetur adipiscing elit,\nsed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
//                                       size: 12,
//                                       weight: FontWeight.w500,
//                                     ),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const Divider(
//                                 endIndent: 120,
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.only(left: 105),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         FormInput(
//                                           controller:
//                                               TextEditingController(text: ''),
//                                           label: 'First Name',
//                                           hint: 'First Name',
//                                         ),
//                                         const SizedBox(
//                                           width: 30,
//                                         ),
//                                         FormInput(
//                                           controller:
//                                               TextEditingController(text: ''),
//                                           label: 'Last Name',
//                                           hint: 'Last Name',
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     Row(
//                                       children: [
//                                         FormInput(
//                                           controller:
//                                               TextEditingController(text: ''),
//                                           label: 'Email ',
//                                           hint: 'Email',
//                                         ),
//                                         const SizedBox(
//                                           width: 30,
//                                         ),
//                                         FormInput(
//                                           controller:
//                                               TextEditingController(text: ''),
//                                           label: 'Phone number',
//                                           hint: 'Phone number',
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     Row(
//                                       children: [
//                                         FormInput(
//                                           controller:
//                                               TextEditingController(text: ''),
//                                           label: 'Password ',
//                                           hint: 'Password',
//                                         ),
//                                         const SizedBox(
//                                           width: 30,
//                                         ),
//                                         FormInput(
//                                           controller:
//                                               TextEditingController(text: ''),
//                                           label: 'Confirm Password',
//                                           hint: 'Confirm Password',
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     FormButton(
//                                       width: 430,
//                                       text: 'Sign Up',
//                                       onPressed: () {},
//                                     ),
//                                     const SizedBox(
//                                       height: 28,
//                                     ),
//                                     SizedBox(
//                                       width: 430,
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           SizedBox(
//                                             height: 10,
//                                             width: 10,
//                                             child: Checkbox(
//                                                 activeColor:
//                                                     Pallet.secondaryColor,
//                                                 checkColor: Colors.white,
//                                                 side: const BorderSide(
//                                                     color: Colors.white),
//                                                 value: checkState,
//                                                 onChanged: (state) {
//                                                   checkState = state!;
//                                                 }),
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           Flexible(
//                                             child: TextStyles.richTexts(
//                                                 onPress1: () {},
//                                                 onPress2: () {},
//                                                 size: 11,
//                                                 color2: Colors.blueGrey[900],
//                                                 text1:
//                                                     'By signing up, you agree to our ',
//                                                 text2: ' Terms and Conditions',
//                                                 text3: '',
//                                                 text4: ''),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 35,
//                                     ),
//                                     SizedBox(
//                                         width: 430,
//                                         child: Center(
//                                           child: TextStyles.richTexts(
//                                               onPress1: () {
//                                                 Get.toNamed(signinPage);
//                                               },
//                                               onPress2: () {
//                                                 Get.toNamed(signinPage);
//                                               },
//                                               size: 11,
//                                               text1:
//                                                   'Already have an account? ',
//                                               text2: ' Sign In',
//                                               text3: '',
//                                               text4: ''),
//                                         ))
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       }),
//                     )
//                   ],
//                 ));
//     });
//   }
// }
