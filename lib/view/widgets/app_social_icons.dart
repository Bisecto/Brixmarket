import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/res/strings.dart';
import 'package:flutter/material.dart';

import '../../libs/launch_urls.dart';

class AppSocialIcons extends StatelessWidget {
  const AppSocialIcons({Key? key, this.iconSize = 18, this.iconColor = Pallet.whiteColor, this.space = 16, this.lightBg = false}) : super(key: key);
  final double iconSize;
  final Color iconColor;
  final double space;
  final bool lightBg;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OpenUrl(
          url: Str.WhatsappLink,
          //phone: Str.contactPhone1.replaceAll(' ', ''),
          widget: Icon(
            Icons.whatsapp,
            color: iconColor,
            size: iconSize,
          ),
        ),
        SizedBox(width: space),
        OpenUrl(
          url: Str.facebookLink,
          widget: Icon(
            Icons.facebook,
            color: iconColor,
            size: iconSize + 2,
          ),
        ),
        SizedBox(width: space - 4),
        OpenUrl(
          url: Str.instagramLink,
          widget: Image.asset(
            'assets/images/instagram1.png',
            color: iconColor,
            height: iconSize + 6,
          ),
        ),
        SizedBox(width: space - 6),
        OpenUrl(
          url: Str.linkedInLink,
          widget: Image.asset(
            'assets/images/linkedin.png',
            color: iconColor,
            height: iconSize,
          ),
        ),
      ],
    );
  }
}
