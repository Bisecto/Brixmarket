import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType inputType;
  final int maxLines;
  final double width;
  final double height;
  final bool isEnabled;

  const SearchInput({
    Key? key,
    required this.controller,
    this.label = '',
    this.hint = '',
    this.width = 200,
    this.height = 42,
    this.inputType = TextInputType.text,
    this.maxLines = 1,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label == ''
            ? const SizedBox.shrink()
            : Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                color: Colors.white,
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
              ),
        const SizedBox(
          height: 8,
        ),
        Material(
          elevation: 0,
          type: MaterialType.card,
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Container(
            height: height,
            width: width,
            padding: const EdgeInsets.only(left: 16, right: 8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: TextField(
                        controller: controller,
                        keyboardType: inputType,
                        maxLines: maxLines,
                        enabled: isEnabled,
                        decoration: InputDecoration(border: InputBorder.none, hintText: hint, hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
                        onChanged: (text) {}),
                  ),
                ),
                Icon(Icons.search)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
