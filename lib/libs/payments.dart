///Had to commet this out becase its not been used currently.And it gives error to the android

// import 'package:flutter/material.dart';
// import 'package:flutter_paystack_client/flutter_paystack_client.dart';
//
// import '../core/dialogs.dart';
// import '../res/strings.dart';
//
// class Payments {
//   static Future paystackPayment(
//     BuildContext context, {
//     required int amount,
//     required String email,
//     String? reference,
//     Map<String, String>? meta,
//     Function? successCallBack,
//     Function? failedCallBack,
//   }) async {
//     await PaystackClient.initialize(paystackPublicKey);
//     final charge = Charge()
//       ..email = email
//       ..amount = (amount * 100).toInt()
//       ..reference = reference ?? '${DateTime.now().millisecondsSinceEpoch}';
//
//     if (meta != null) {
//       meta.forEach((key, value) {
//         charge.putMetaData(key, value);
//       });
//     }
//
//     await PaystackClient.initialize(paystackPublicKey);
//     final response = await PaystackClient.checkout(context, charge: charge);
//     if (response.status) {
//       if (successCallBack != null) {
//         successCallBack(response.reference);
//       }
//     } else {
//       MSG.snackBar('Failed: ${response.message}');
//       if (failedCallBack != null) {
//         failedCallBack(response.message);
//       }
//     }
//   }
// }
