// import 'package:brixmarket/config/theme/color.dart';
// import 'package:brixmarket/view/widgets/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:group_radio_button/group_radio_button.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../res/strings.dart';
// import '../../widgets/form_button.dart';
// import '../../widgets/form_inputs.dart';
//
// class SignInPage extends StatefulWidget {
//   SignInPage({Key? key}) : super(key: key);
//
//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }
//
// class _SignInPageState extends State<SignInPage> {
//   String _verticalGroupValue = "Pending";
//
//   final List<String> _status = [
//     "Individual",
//     "Agency",
//   ];
//   bool checkState = true;
//
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
//                     Builder(builder: (context) {
//                       return Container(
//                         height: Get.height,
//                         width: 75.w,
//                         color: Colors.white,
//                         margin: const EdgeInsets.only(top: 30),
//                         child: SingleChildScrollView(
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
//                                       text: 'Sign In',
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
//                               Container(
//                                 padding: const EdgeInsets.only(left: 105),
//                                 width: 500,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     RadioGroup<String>.builder(
//                                       groupValue: _verticalGroupValue,
//                                       spacebetween: 80,
//                                       horizontalAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       textStyle: const TextStyle(fontSize: 12),
//                                       direction: Axis.horizontal,
//                                       onChanged: (value) => setState(() {
//                                         _verticalGroupValue = value!;
//                                       }),
//                                       items: _status,
//                                       itemBuilder: (item) => RadioButtonBuilder(
//                                         item,
//                                       ),
//                                       activeColor: Colors.red,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.only(left: 105),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     FormInput(
//                                       controller:
//                                           TextEditingController(text: ''),
//                                       label: 'Email',
//                                       hint: 'Email',
//                                       width: 430,
//                                     ),
//                                     const SizedBox(
//                                       height: 30,
//                                     ),
//                                     FormInput(
//                                       controller:
//                                           TextEditingController(text: ''),
//                                       label: 'Password',
//                                       hint: 'Password',
//                                       width: 430,
//                                     ),
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     FormButton(
//                                       width: 430,
//                                       text: 'Sign In',
//                                       onPressed: () {},
//                                     ),
//                                     const SizedBox(
//                                       height: 28,
//                                     ),
//                                     SizedBox(
//                                         width: 430,
//                                         child: TextStyles.richTexts(
//                                             onPress1: () {
//                                               Get.toNamed(resetpassword1);
//                                             },
//                                             onPress2: () {},
//                                             size: 11,
//                                             text1: 'Forgot Password? ',
//                                             text2: ' Reset',
//                                             text3: '',
//                                             text4: '')),
//                                     const SizedBox(
//                                       height: 35,
//                                     ),
//                                     SizedBox(
//                                         width: 430,
//                                         child: Center(
//                                           child: TextStyles.richTexts(
//                                               onPress1: () {},
//                                               onPress2: () {},
//                                               size: 11,
//                                               text1:
//                                                   'Already have an account? ',
//                                               text2: ' Sign In',
//                                               text3: '',
//                                               text4: ''),
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     })
//                   ],
//                 ));
//     });
//   }
// }
