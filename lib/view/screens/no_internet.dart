import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:flutter/material.dart';

import '../../config/theme/color.dart';
import '../../controllers/instance.dart';
import '../../core/dialogs.dart';
import '../widgets/custom_button.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key, required this.callBack, this.reInitApp = false}) : super(key: key);
  final Function() callBack;
  final bool reInitApp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
            child: Icon(Icons.wifi_off, size: 48, color: Pallet.secondaryColor),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
            child: Text(
              'No Internet Connection',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Text(
              'An internet connection error occurred, please try again',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
            child: FormButton(
              onPressed: () {
                Connectivity().checkConnection().then((connected) async {
                  if (connected) {
                    if (reInitApp) {
                      homeCtrl.init().whenComplete(() => null);
                    }
                    callBack();
                  } else {
                    MSG.errorSnackBar('No Internet Connection');
                  }
                });
              },
              text: 'TRY AGAIN',
              txtColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
