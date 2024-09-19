import 'package:flutter/material.dart';

import '../../../res/strings.dart';
import '../../../utils/utils.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ImgStr.logoDark, height: isMobile() ? 54 : 64),
            const SizedBox(
              height: 6,
            ),
          ],
        ),
      ),
    );
  }
}
