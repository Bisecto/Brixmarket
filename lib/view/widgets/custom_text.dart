import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../config/theme/color.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final TextAlign? textAlign;
  final double? spacing;
  final int maxLines;
  final bool underline;

  const CustomText({
    Key? key,
    this.text,
    this.size,
    this.color,
    this.weight,
    this.spacing = 0,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.underline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textDirection: TextDirection.ltr,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        decoration:
            (underline) ? TextDecoration.underline : TextDecoration.none,
        letterSpacing: spacing!,
        fontSize: size ?? 16,
        color: color ?? Colors.black,
        fontWeight: weight ?? FontWeight.normal,
      ),
    );
  }
}

class TextStyles {
  static textHeadings(
      {required String textValue, double textSize = 18, Color? textColor}) {
    return Text(
      textValue,
      textDirection: TextDirection.ltr,
      style: TextStyle(
          fontStyle: FontStyle.normal,
          color: textColor,
          fontSize: textSize,
          fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    );
  }

  static textSubHeadings({
    required String textValue,
    double textSize = 14,
    Color? textColor,
    bool centerText = false,
  }) {
    return Text(
      textValue,
      textDirection: TextDirection.ltr,
      style: TextStyle(
          fontStyle: FontStyle.normal,
          color: textColor,
          fontSize: textSize,
          fontWeight: FontWeight.bold),
      textAlign: (centerText) ? TextAlign.center : TextAlign.start,
    );
  }

  static textDetails({
    required String textValue,
    double textSize = 12,
    double lineSpacing = 1.1,
    Color? textColor = Colors.white,
    bool centerText = false,
  }) {
    return Text(
      textValue,
      textDirection: TextDirection.ltr,
      textAlign: (centerText) ? TextAlign.center : TextAlign.start,
      style: TextStyle(
          fontStyle: FontStyle.normal,
          color: textColor,
          fontSize: textSize,
          fontWeight: FontWeight.w400,
          height: lineSpacing),
    );
  }

  static richTexts(
      {String? text1,
      String? text2,
      double size = 16,
      String text3 = '',
      String text4 = '',
      FontWeight? weight = FontWeight.w400,
      Function? onPress1,
      bool centerText = false,
      Color? color2 = Pallet.secondaryColor,
      Color? color = const Color.fromARGB(255, 73, 71, 71),
      TextDecoration decoration = TextDecoration.none,
      Function? onPress2}) {
    return RichText(
      textAlign: (centerText) ? TextAlign.center : TextAlign.justify,
      textDirection: TextDirection.ltr,
      softWrap: true,
      text: TextSpan(children: [
        TextSpan(
          text: text1,
          style: TextStyle(
              fontStyle: FontStyle.normal,
              color: color,
              fontSize: size,
              fontWeight: weight),
        ),
        TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              onPress1!();
            },
          text: text2,
          style: TextStyle(
              decoration: decoration,
              fontStyle: FontStyle.normal,
              color: color2,
              fontSize: size,
              fontWeight: weight),
        ),
        TextSpan(
          text: text3,
          style: TextStyle(
              fontStyle: FontStyle.normal,
              color: color,
              fontSize: size,
              fontWeight: weight),
        ),
        TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onPress2!();
              },
            text: text4,
            style: TextStyle(color: color, fontSize: size, fontWeight: weight)),
      ]),
    );
  }
}
