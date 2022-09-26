import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDown extends StatelessWidget {
  final controller;
  final String label;
  final double width;
  final double height;
  final String? initialValue;
  final List<String> items;
  final Color? color;
  final Color? labelColor;
  final Color? borderColor;
  final Color? dropIconColor;
  final bool showLabel;
  final bool showBorder;
  final double borderRadius;
  final controllerName;

  DropDown(
      {Key? key,
      required this.controller,
      this.label = '',
      this.width = double.infinity,
      this.height = 44,
      required this.items,
      this.initialValue,
      this.labelColor,
      this.showLabel = true,
      this.showBorder = true,
      this.borderColor,
      this.controllerName,
      this.color,
      this.borderRadius = 4,
      this.dropIconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.value.text = initialValue == '' || initialValue == null ? controller.value.text : initialValue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showLabel
            ? Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  label,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: labelColor ?? color ?? Colors.black87),
                ),
              )
            : const SizedBox.shrink(),
        showLabel ? const SizedBox(height: 8) : const SizedBox.shrink(),
        Material(
          elevation: 0,
          type: MaterialType.card,
          color: const Color.fromARGB(31, 65, 61, 61),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
                color: color ?? const Color.fromARGB(150, 220, 220, 220),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                border: showBorder ? Border.all(color: borderColor ?? Colors.black12) : null),
            margin: const EdgeInsets.only(left: 0, right: 0),
            child: SizedBox(
              width: width,
              child: Obx(() => DropdownButton<String>(
                    iconEnabledColor: dropIconColor ?? Colors.black54,
                    icon: const Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 32,
                    ),
                    isExpanded: true,
                    iconSize: 24,
                    focusColor: Colors.black12,
                    alignment: Alignment.bottomCenter,
                    elevation: 3,
                    underline: Container(color: Colors.transparent),
                    value: controller.value.text == ' ' || !items.contains(controller.value.text) ? null : controller.value.text,
                    onChanged: (newValue) {
                      controller.value.text = newValue;
                      controller.refresh();
                    },
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Select ' + label,
                        style: const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    items: items.map((data) {
                      return DropdownMenuItem<String>(
                        value: data.toString(),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(data, style: const TextStyle(color: Colors.black87, fontSize: 16)),
                        ),
                      );
                    }).toList(),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
