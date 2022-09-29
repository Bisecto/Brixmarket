import 'package:flutter/material.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/edit_controller.dart';
import '../../widgets/appbar_menus.dart';
import '../../widgets/custom_text.dart';
import '../create_property/create_property_widges.dart';

class AddPropertyPage extends StatelessWidget {
  bool isEdit;
   AddPropertyPage({Key? key,required this.isEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
          title: const Text('Do you want to Leave this page?'),
          content: const Text('You will leave this page with some data not saved'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                EditCtrl.disposeControllers();
                Navigator.of(context).pop(true);
              },
              child: const Text('Yes'),
            ),
          ],
        ),
        )) ??
        false;

      },
      child: Scaffold(
          backgroundColor: Pallet.homeBackground,
          appBar: AppBar(
            backgroundColor: Pallet.secondaryColor,
            automaticallyImplyLeading: true,
            title: const CustomText(
              color: Colors.white,
              size: 18,
              text: 'Add Property',
            ),
            actions: const [AppBarMenu(logout: true, saveDraft: true, propertyIDS: [],)],
          ),
          body:  CreatePropertyWidget(isEdt: isEdit,)),

    );
  }
  //
  // propertyTypeContainers({required String title, Function? onTap}) {
  //   return GestureDetector(
  //       onTap: () {
  //         onTap!();
  //       },
  //       child: Container(
  //           height: 42,
  //           margin: const EdgeInsets.symmetric(vertical: 10),
  //           color: Pallet.cardColor,
  //           child: Material(
  //               elevation: 4,
  //               type: MaterialType.card,
  //               color: Pallet.cardColor,
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     CustomText(
  //                       color: Pallet.blueGray,
  //                       size: 18,
  //                       text: title,
  //                     ),
  //                     const Icon(
  //                       Icons.arrow_forward_ios,
  //                       color: Colors.black,
  //                       size: 20,
  //                     )
  //                   ],
  //                 ),
  //               ))));
  // }
}
//
// class PropertyDetails extends StatelessWidget {
//   PropertyDetails({Key? key}) : super(key: key);
//
//   // var controller = Get.find<AddPropertyController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Pallet.homeBackground,
//         appBar: AppBar(
//           backgroundColor: Pallet.secondaryColor,
//           automaticallyImplyLeading: true,
//           title: const CustomText(
//             color: Colors.white,
//             size: 18,
//             text: 'Add Property Details',
//           ),
//           actions: const [
//             Padding(
//               padding: EdgeInsets.only(right: 12.0),
//               child: Icon(
//                 Icons.more_vert,
//                 color: Colors.white,
//                 size: 30,
//               ),
//             ),
//           ],
//         ),
//         body: ListView(
//           shrinkWrap: true,
//           padding: const EdgeInsets.symmetric(horizontal: 14),
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             const CustomText(
//               color: Colors.black,
//               size: 14,
//               text: 'Fill in your property details',
//               weight: FontWeight.w600,
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             FormInput(
//               width: double.infinity,
//               controller: TextEditingController(text: ''),
//               label: 'Title ',
//               hint: 'Enter Title of the List',
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             FormInput(
//               width: double.infinity,
//               controller: TextEditingController(text: ''),
//               label: 'Description ',
//               height: 100,
//               maxLines: 8,
//               hint: 'Description of the property',
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             DropDown(
//               controller: EditCtrl.type,
//               label: 'Status',
//               initialValue: 'Buy',
//               items: const ['Buy', 'Rent', 'New Home', 'Commercial', 'Short Stay'],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             DropDown(
//               controller: EditCtrl.type,
//               label: 'Status',
//               initialValue: 'Buy',
//               items: const ['Buy', 'Rent', 'New Home', 'Commercial', 'Short Stay'],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             DropDown(
//               controller: EditCtrl.type,
//               label: 'Status',
//               initialValue: 'Buy',
//               items: const ['Buy', 'Rent', 'New Home', 'Commercial', 'Short Stay'],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const Divider(
//               thickness: 1,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             CustomText(
//               color: Pallet.blueGray,
//               size: 16,
//               text: 'Location',
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             FormInput(
//               width: double.infinity,
//               controller: TextEditingController(text: ''),
//               label: 'Address ',
//               height: 55,
//               maxLines: 2,
//               hint: 'Enter propperty address',
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: DropDown(
//                     controller: EditCtrl.type,
//                     label: 'Status',
//                     initialValue: 'Buy',
//                     items: const ['Buy', 'Rent', 'New Home', 'Commercial', 'Short Stay'],
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: DropDown(
//                     controller: EditCtrl.type,
//                     label: 'Status',
//                     initialValue: 'Buy',
//                     items: const ['Buy', 'Rent', 'New Home', 'Commercial', 'Short Stay'],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: FormInput(
//                     width: double.infinity,
//                     controller: TextEditingController(text: ''),
//                     label: 'Longitude ',
//                     height: 42,
//                     maxLines: 1,
//                     hint: '',
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: FormInput(
//                     width: double.infinity,
//                     controller: TextEditingController(text: ''),
//                     label: 'Latitude ',
//                     height: 42,
//                     maxLines: 1,
//                     hint: '',
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   flex: 3,
//                   child: DropDown(
//                     controller: EditCtrl.type,
//                     label: 'Status',
//                     initialValue: 'Buy',
//                     items: const ['Buy', 'Rent', 'New Home', 'Commercial', 'Short Stay'],
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   flex: 6,
//                   child: FormInput(
//                     width: double.infinity,
//                     controller: TextEditingController(text: ''),
//                     label: ' ',
//                     height: 42,
//                     maxLines: 1,
//                     hint: 'Eg. 550,00000',
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             DropDown(
//               controller: EditCtrl.type,
//               label: 'Status',
//               initialValue: 'Buy',
//               items: const ['Buy', 'Rent', 'New Home', 'Commercial', 'Short Stay'],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const Divider(
//               thickness: 1,
//             ),
//             CustomText(
//               color: Pallet.blueGray,
//               size: 16,
//               text: 'More Details',
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: FormInput(
//                     width: double.infinity,
//                     controller: TextEditingController(text: ''),
//                     label: 'Bedrooms ',
//                     height: 42,
//                     maxLines: 1,
//                     hint: '',
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: FormInput(
//                     width: double.infinity,
//                     controller: TextEditingController(text: ''),
//                     label: 'Toilets ',
//                     height: 42,
//                     maxLines: 1,
//                     hint: '',
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: FormInput(
//                     width: double.infinity,
//                     controller: TextEditingController(text: ''),
//                     label: 'Bathrooms ',
//                     height: 42,
//                     maxLines: 1,
//                     hint: '',
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: FormInput(
//                     width: double.infinity,
//                     controller: TextEditingController(text: ''),
//                     label: 'Parking ',
//                     height: 42,
//                     maxLines: 1,
//                     hint: '',
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: FormInput(
//                     width: double.infinity,
//                     controller: TextEditingController(text: ''),
//                     label: 'Total Area(Sqm) ',
//                     height: 42,
//                     maxLines: 1,
//                     hint: '',
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: FormInput(
//                     width: double.infinity,
//                     controller: TextEditingController(text: ''),
//                     label: 'Covered Area(Sqm) ',
//                     height: 42,
//                     maxLines: 1,
//                     hint: '',
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 FormBorderButton(
//                   width: 120,
//                   bgColor: Colors.white,
//                   txtColor: Colors.black,
//                   text: 'Cancel',
//                   onPressed: () {},
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 FormButton(
//                   width: 160,
//                   textSize: 14,
//                   weight: FontWeight.bold,
//                   text: 'Save and proceed',
//                   disableButton: false,
//                   onPressed: () {
//                     Get.to(() => AddMediaProperty());
//                   },
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//           ],
//         ));
//   }
// }
//
// class AddMediaProperty extends StatefulWidget {
//   AddMediaProperty({Key? key}) : super(key: key);
//
//   @override
//   State<AddMediaProperty> createState() => _AddMediaPropertyState();
// }
//
// class _AddMediaPropertyState extends State<AddMediaProperty> {
//   int _selectedIndex = 1;
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
//           size: 18,
//           text: 'Add Property Media',
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 12.0),
//             child: Icon(
//               Icons.more_vert,
//               color: Colors.white,
//               size: 30,
//             ),
//           ),
//         ],
//       ),
//       body: ListView(
//         shrinkWrap: true,
//         padding: const EdgeInsets.symmetric(horizontal: 14),
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           const CustomText(
//             color: Colors.black,
//             size: 14,
//             text: 'Add photo to your listing',
//             weight: FontWeight.w600,
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           Container(
//             color: Pallet.secondaryColor.withOpacity(0.2),
//             padding: const EdgeInsets.all(20),
//             child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               const SizedBox(height: 12),
//               const CustomText(
//                 text: '      • Each picture must not exceed 5 Mb',
//                 color: Colors.black,
//                 size: 14,
//                 weight: FontWeight.normal,
//               ),
//               const SizedBox(height: 12),
//               const CustomText(
//                 text: '      • Supported formats are *.jpg, *.gif, *png',
//                 color: Colors.black,
//                 size: 14,
//                 weight: FontWeight.normal,
//               ),
//               const SizedBox(height: 12),
//               const CustomText(
//                 text: '      • Advert must contain from 2 to 20 images',
//                 color: Colors.black,
//                 size: 14,
//                 weight: FontWeight.normal,
//               ),
//               const SizedBox(height: 12),
//               TextStyles.richTexts(
//                   onPress1: () {},
//                   onPress2: () {},
//                   size: 14,
//                   decoration: TextDecoration.underline,
//                   color2: Colors.blueGrey[900],
//                   text1: '      • Read the terms and Policy guide',
//                   text2: 'here',
//                   text3: '',
//                   text4: ''),
//               const SizedBox(height: 12),
//               const CustomText(
//                 text: '      • Add at least two photos for this category',
//                 color: Colors.black,
//                 size: 14,
//                 weight: FontWeight.normal,
//               ),
//               const SizedBox(height: 12),
//               const CustomText(
//                 text: '      • First picture is the Title picture. Grab and Drag to chage the order of photos',
//                 color: Colors.black,
//                 size: 14,
//                 weight: FontWeight.normal,
//               ),
//             ]),
//           ),
//           const SizedBox(
//             height: 40,
//           ),
//           Align(
//               alignment: Alignment.bottomLeft,
//               child: Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(color: Colors.black12, shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(6)),
//                 child: Column(
//                   children: const [
//                     Icon(
//                       Icons.camera_enhance,
//                       color: Pallet.secondaryColor,
//                       size: 22,
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     CustomText(
//                       text: 'Add Photos',
//                       color: Pallet.secondaryColor,
//                       size: 14,
//                       weight: FontWeight.normal,
//                     ),
//                   ],
//                 ),
//               )),
//           const SizedBox(
//             height: 30,
//           ),
//           Container(
//             height: 35,
//             color: Colors.blueGrey,
//             child: Center(
//               child: CustomText(
//                 text: '6 files uploaded',
//                 color: Pallet.whiteColor,
//                 size: 14,
//                 weight: FontWeight.normal,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           Image.asset(
//             'assets/images/bulk_upload.PNG',
//             width: double.infinity,
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           const CustomText(
//             text: 'Select Ad Package',
//             color: Colors.black,
//             size: 16,
//             weight: FontWeight.w600,
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           Container(
//             margin: const EdgeInsets.only(bottom: 30),
//             height: 150,
//             child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 20), shrinkWrap: true, children: [
//               buildPackageListing(index: 1, plan: 'Free', price: 'N 0', uploadLimit: '5 Ad upload limit'),
//               const SizedBox(
//                 width: 20,
//               ),
//               buildPackageListing(index: 2, plan: 'Pro', price: 'N 5,000', uploadLimit: '100 Ad upload limit'),
//               const SizedBox(
//                 width: 20,
//               ),
//               buildPackageListing(index: 3, plan: 'Premium', price: 'N 40,0000', uploadLimit: '500 Ad upload limit'),
//             ]),
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               FormBorderButton(
//                 width: 120,
//                 bgColor: Colors.white,
//                 txtColor: Colors.black,
//                 text: 'Previous',
//                 onPressed: () {},
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               FormButton(
//                 width: 160,
//                 textSize: 14,
//                 weight: FontWeight.bold,
//                 text: 'Finish listing',
//                 disableButton: false,
//                 onPressed: () {
//                   Get.to(() => AddMediaProperty());
//                 },
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _isSelected({required int index}) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   buildPackageListing({
//     String? plan,
//     String? price,
//     int? index,
//     String? uploadLimit,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         _isSelected(index: index!);
//       },
//       child: Container(
//         padding: const EdgeInsets.only(bottom: 30),
//         child: Material(
//           elevation: 5,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           child: Container(
//             height: 90,
//             width: Get.width * 0.55,
//             padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
//             margin: const EdgeInsets.only(
//               right: 12,
//               top: 12,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CustomText(
//                       text: plan,
//                       color: Colors.blueGrey.shade400,
//                       size: 18,
//                       weight: FontWeight.w600,
//                     ),
//                     _selectedIndex == index!
//                         ? const Icon(
//                             Icons.check_circle,
//                             color: Pallet.secondaryColor,
//                             size: 30,
//                           )
//                         : const Icon(
//                             Icons.radio_button_off,
//                             color: Pallet.secondaryColor,
//                             size: 30,
//                           ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 CustomText(
//                   text: price,
//                   color: Colors.black,
//                   size: 20,
//                   weight: FontWeight.w600,
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 CustomText(
//                   text: uploadLimit,
//                   color: Colors.black38,
//                   size: 14,
//                   weight: FontWeight.w400,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
