import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showToast({
  required String title,
  String? subTitle,
  SnackPosition? position,
}) {
  if (Get.isSnackbarOpen) {
    Get.closeAllSnackbars();
  }
  Get.snackbar(
    title,
    subTitle ?? '',
    messageText:
        StringUtils.isNullOrEmpty(subTitle) ? const SizedBox.shrink() : null,
    snackPosition: position ?? SnackPosition.BOTTOM,
    duration: const Duration(seconds: 1),
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
  );
}


 SnackBar orderSuccessSnackbar = SnackBar(
  content: Text('strOrderPlacedSuccessfully'.tr),
  behavior: SnackBarBehavior.floating,
  backgroundColor: const Color(0xff598216),
  elevation: 5,
  duration: const Duration(seconds: 2),
);

class StringUtils {
  static bool isNullOrEmpty(String? s) =>
      (s == null || s.isEmpty) ? true : false;
}
