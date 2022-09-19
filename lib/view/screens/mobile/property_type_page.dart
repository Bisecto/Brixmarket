// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../config/theme/color.dart';
// import '../../widgets/custom_text.dart';
// import '../../widgets/material_search_bar/src/widgets/mobile_app_widgets/property_container.dart';
//
// class PropertyType extends StatefulWidget {
//   PropertyType({Key? key}) : super(key: key);
//
//   @override
//   State<PropertyType> createState() => _PropertyTypeState();
// }
//
// class _PropertyTypeState extends State<PropertyType> {
//   bool isEmty = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Pallet.homeBackground,
//       appBar: AppBar(
//         backgroundColor: Pallet.secondaryColor,
//         automaticallyImplyLeading: true,
//         title: const CustomText(
//           color: Colors.white,
//           size: 16,
//           text: 'New Home',
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 12.0),
//             child: Icon(
//               Icons.search,
//               color: Colors.white,
//               size: 30,
//             ),
//           )
//         ],
//       ),
//       body: SizedBox(
//         height: Get.height,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//           child: SizedBox(
//             child: ListView.builder(
//                 itemCount: 12,
//                 scrollDirection: Axis.vertical,
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   return buildPremiumList(showMore: true);
//                 }),
//           ),
//         ),
//       ),
//     );
//   }
// }
