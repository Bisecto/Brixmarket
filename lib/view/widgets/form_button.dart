import 'package:flutter/material.dart';

import '../../config/theme/color.dart';

class FormButton extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final Function() onPressed;
  final double width;
  final double height;
  final double textSize;
  final bool disableButton;
  final FontWeight weight;

  const FormButton({
    Key? key,
    this.text = '',
    this.textSize = 16,
    required this.onPressed,
    this.bgColor = Pallet.secondaryColor,
    this.disableButton = false,
    this.width = double.infinity,
    this.height = 42,
    this.weight = FontWeight.w300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 24, 0, 0),
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: (disableButton) ? null : onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: textSize, fontWeight: weight),
        ),
        style: ElevatedButton.styleFrom(
          primary: bgColor,
          fixedSize: const Size(double.infinity, 48),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class FormBorderButton extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final Color? txtColor;
  final Function() onPressed;
  final double width;

  const FormBorderButton({Key? key, this.text = '', required this.onPressed, this.bgColor, this.width = double.infinity, this.txtColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 24, 0, 0),
      width: width,
      height: 42,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black54,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: txtColor),
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: bgColor,
          fixedSize: const Size(double.infinity, 35),
          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: txtColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class FormIconButton extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final Function()? onPressed;
  final double width;
  final double height;
  final double fontSize;
  final bool hasIcon;
  final double marginTop;

  const FormIconButton(
      {Key? key,
      this.text = '',
      required this.onPressed,
      this.marginTop = 24,
      this.bgColor,
      this.height = 35,
      this.width = double.infinity,
      this.fontSize = 14,
      this.hasIcon = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, marginTop, 0, 0),
        width: width,
        height: height,
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.arrow_back,
                size: hasIcon ? 12 : 0,
              ),
              style: ElevatedButton.styleFrom(
                primary: bgColor ?? Pallet.secondaryColor,
                fixedSize: const Size(double.infinity, 48),
                textStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              label: Text(
                text,
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w100),
              ),
              onPressed: onPressed,
            )));
  }
}
