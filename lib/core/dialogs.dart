import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/theme/color.dart';
import '../utils/utils.dart';
import '../view/widgets/custom_text.dart';

class MSG {
  static snackBar(String message, {String title = 'Message'}) {
    try {
      Get.snackbar(
        title,
        message,
        icon: const Icon(Icons.check_circle_outline, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        maxWidth: 400.0,
      );
    } catch (e) {
      dnd(e);
    }
  }

  static errorSnackBar(String message, {String title = 'Error massage'}) {
    // if (Get.isSnackbarOpen) {
    //   Get.closeAllSnackbars();
    // }
    try {
      Get.snackbar(title, message,
          icon: const Icon(Icons.warning_amber_outlined, color: Colors.white),
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFF86666),
          colorText: Colors.white,
          maxWidth: 400.0);
    } catch (e) {
      dnd(e);
    }
  }
}

errorDialog(String message, {title = 'Error message', String btnCancel = 'Cancel', String btnContinue = 'Proceed', Function? onTapContinue, bool showButtons = false}) {
  Get.defaultDialog(
    title: title,
    radius: 0,
    titlePadding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
    titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Pallet.errorTextColor),
    backgroundColor: Pallet.errorBackgroundColor,

    content: Column(
      children: [
        Row(
          children: [
            const Icon(Icons.warning, color: Pallet.errorTextColor),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                message,
                style: const TextStyle(color: Pallet.errorTextColor),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        Visibility(
          visible: showButtons,
          child: Column(
            children: [
              const SizedBox(height: 15),
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                    onTapContinue!();
                      },
                      child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(color: Pallet.primaryColorDark, borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: CustomText(
                        text: btnContinue,
                        size: 16,
                        color: Pallet.whiteColor,
                        textAlign: TextAlign.center,
                      ),
                    ),
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: SizedBox(
                      height: 35,
                      child: Center(
                        child: CustomText(
                          text: btnCancel,
                          size: 16,
                          color: Pallet.blueGray,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

successAlert(String message, {title = 'Success message'}) {
  Get.defaultDialog(
    title: title,
    radius: 0,
    titlePadding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
    titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Pallet.successTextColor),
    backgroundColor: Pallet.successBackgroundColor,
    content: Row(
      children: [
        const Icon(Icons.check_circle_outline, color: Pallet.successTextColor),
        const SizedBox(width: 8),
        Text(
          message,
          style: const TextStyle(color: Pallet.successTextColor),
        ),
        const SizedBox(width: 8),
      ],
    ),
  );
}
