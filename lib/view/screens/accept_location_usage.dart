// import 'package:brixmarket/utils/utils.dart';
// import 'package:cross_connectivity/cross_connectivity.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
//
// import '../../config/theme/color.dart';
// import '../../controllers/instance.dart';
// import '../../core/dialogs.dart';
// import '../../res/strings.dart';
// import '../../utils/shared_preferences.dart';
// import '../widgets/custom_button.dart';
//
// class AcceptLocationUsage extends StatefulWidget {
//   const AcceptLocationUsage({Key? key}) : super(key: key);
//
//   @override
//   State<AcceptLocationUsage> createState() => _AcceptLocationUsageState();
// }
//
// class _AcceptLocationUsageState extends State<AcceptLocationUsage> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     checkpermission();
//   }
//   checkpermission()async{
//     await Utils.getCurrentLocation();
//     var permission = await Geolocator.checkPermission();
//     if(permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
//       await SharedPref.putBool('acceptLocationUsage', true);
//       Get.offNamed(RouteStr.mobileSplashscreen);
//     } else {
//       await SharedPref.putBool('acceptLocationUsage', false);
//       //Get.offNamed(RouteStr.mobileSplashscreen);
//       Get.offNamed(RouteStr.mobileSplashscreen);
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//            Padding(
//             padding: const EdgeInsets.only(top: 24, bottom: 24),
//             child: Image.asset('assets/images/map_location.jpg', width: 200, fit: BoxFit.contain),
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//             child: Text(
//               'Brixmarket requires access to your location',textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Pallet.secondaryColor),
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
//             child: Text(
//               'This app collect location data to enable search and filtering of properties within your location. '
//                   'Make sure that your device location is on',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//           // Padding(
//           //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
//           //   child: FormButton(
//           //     onPressed: () async {
//           //       await Utils.getCurrentLocation();
//           //       var permission = await Geolocator.checkPermission();
//           //       if(permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
//           //         await SharedPref.putBool('acceptLocationUsage', true);
//           //         Get.offNamed(RouteStr.mobileSplashscreen);
//           //       } else {
//           //         SystemNavigator.pop();
//           //       }
//           //     },
//           //     text: 'Location Access',
//           //     txtColor: Colors.white,
//           //   ),
//           // ),
//           // GestureDetector(
//           //   onTap: () => SystemNavigator.pop(),
//           //   child: const Padding(
//           //     padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
//           //     child: Text(
//           //       'No Thanks',
//           //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Pallet.secondaryColor),
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
