import 'package:flutter/material.dart';

import '../../config/theme/color.dart';

class FormButton extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final Function() onPressed;
  final double width;
  final double? height;
  final double? radius;
  final double? size;
  final double? top;
  final double? elevation;
  final Color txtColor;

  const FormButton(
      {Key? key,
      this.text = 'Submit',
      required this.onPressed,
      this.bgColor,
      this.width = double.infinity,
      this.height = 45,
      this.radius = 50,
      this.size = 16,
      this.elevation,
      this.top,
      this.txtColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, top ?? 24, 0, 0),
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: txtColor, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          elevation: elevation, backgroundColor: bgColor ?? Pallet.secondaryColor,
          fixedSize: Size(double.infinity, height!),
          textStyle: TextStyle(fontSize: size!, fontWeight: FontWeight.w600, color: txtColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!),
          ),
        ),
      ),
    );
  }
}
