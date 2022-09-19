// import 'package:flutter/material.dart';
// import 'package:flutterwave/flutterwave.dart';
// import 'package:sos/utils/utils.dart';
//
// class FlutterWaveLib {
//   static makePayment({
//     required BuildContext? context,
//     required String fullName,
//     required String phone,
//     required String email,
//     required String amount,
//     required Function successCallBack,
//     required Function errorCallBack,
//     required Function failedCallBack,
//   }) async {
//     try {
//       Flutterwave flutterwave = Flutterwave.forUIPayment(
//         context: context!,
//         fullName: fullName,
//         phoneNumber: phone,
//         email: email,
//         amount: amount,
//         encryptionKey: "FLWSECK_TEST5b51ed727116",
//         publicKey: "FLWPUBK_TEST-ebf927523e8665a946b52f900fb4f406-X",
//         currency: 'NGN',
//         txRef: DateTime.now().toIso8601String(),
//         isDebugMode: true,
//         acceptCardPayment: true,
//         acceptUSSDPayment: true,
//         acceptAccountPayment: true,
//         acceptFrancophoneMobileMoney: false,
//         acceptGhanaPayment: false,
//         acceptMpesaPayment: false,
//         acceptRwandaMoneyPayment: false,
//         acceptUgandaPayment: false,
//         acceptZambiaPayment: false,
//       );
//
//       final response = await flutterwave.initializeForUiPayments();
//       dnd('FlutterWaveLib - 40:' + response.toString());
//       dnd('flutterwaveLib - 41:' + response.data.toString());
//       dnd('flutterwaveLib - 42:' + response.status.toString());
//       if (response.runtimeType == Null) {
//       } else {
//         if (response.status == "Transaction successful") {
//           if (response.data != null) {
//             if (response.data!.status == 'successful') {
//               successCallBack(response.data!);
//               return;
//             }
//           }
//         }
//         errorCallBack(response.message);
//       }
//     } catch (error) {
//       errorCallBack(error.toString());
//     }
//   }
// }
