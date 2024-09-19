import 'package:flutter/material.dart';

import '../../config/theme/color.dart';

class SignUpHomeButtons extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final Function() onPressed;
  final double width;
  final double height;
  final double fontSize;

  const SignUpHomeButtons({Key? key, this.text = 'Submit', required this.onPressed, this.bgColor, this.height = 50, this.width = double.infinity, this.fontSize = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 24, 0, 0),
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: const Color.fromARGB(255, 29, 28, 28), fontSize: fontSize, fontWeight: FontWeight.w500)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Pallet.btnSignColor,
          fixedSize: Size(double.infinity, height),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4), side: const BorderSide(color: Colors.black26)),
        ),
      ),
    );
  }
}
