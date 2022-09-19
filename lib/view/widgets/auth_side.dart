import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/strings.dart';
import '../../utils/utils.dart';

class AuthSide extends StatelessWidget {
  const AuthSide({
    Key? key,
    this.bgImage = 'assets/images/welcome2.jpg',
    this.title = 'Welcome Back!',
    this.subTitle = 'Keep your face always toward the sunshine - and shadows will fall behind you. !',
  }) : super(key: key);
  final String bgImage;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Get.width >= 600,
      child: InkWell(
        onTap: () => Get.toNamed(RouteStr.webHome),
        child: Container(
          height: Get.height,
          width: Get.width * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.cover, image: AssetImage(bgImage)),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.7),
            height: Get.height,
            width: Get.width * 0.4,
            padding: EdgeInsets.only(left: Get.width * 0.04, right: Get.width * 0.04),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  ImgStr.logoLight,
                  height: 68,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: Get.width * 0.1),
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: isTablet() ? 28 : 48, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 24),
                Text(
                  subTitle,
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 88),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
