import 'package:flutter/material.dart';

import '../config/theme/color.dart';
import '../controllers/instance.dart';
import '../view/screens/mobile/notifications_page.dart';
import '../view/widgets/custom_button.dart';
import '../view/widgets/custom_text.dart';

class CheckVerification extends StatefulWidget {
  const CheckVerification({Key? key}) : super(key: key);

  @override
  State<CheckVerification> createState() => _CheckVerificationState();
}

class _CheckVerificationState extends State<CheckVerification> {
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: _screenHeight,
        width: _screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:   [
            const CustomText(
              size: 25,
              color: Colors.red,
              text: "Do you know you can become a verified agent?",
            ),
            const CustomText(
              size: 20,
              color: Colors.red,
              text: "Follow few easy steps to become a verified agent",
            ),
            const Icon(Icons.verified_user_rounded,color: Colors.green,size: 100,),
            Column(
              children: [
                settingsItem('Never show this again', 'When turned on, you wont be able to get prompt on Verification', user.settings?.requestTourAlert),
                const SizedBox(
                  height: 10,
                ),
                settingsItem('Remind me later', 'When turned on, you wont be able to get prompt on Verification', user.settings?.requestTourAlert),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FormButton(
                      bgColor: Pallet.secondaryColor,
                      text: 'Skip',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FormButton(
                      bgColor: Pallet.secondaryColor,
                      text: 'Continue',
                      onPressed: () {
                      },
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
