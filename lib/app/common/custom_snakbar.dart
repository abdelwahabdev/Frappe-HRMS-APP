import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message,
    {bool isError = true,
    Duration duration = const Duration(milliseconds: 1500),
    bool isTopSnakbar = true}) {
  if (!Get.isSnackbarOpen) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor:
          isError ? Colors.red : const Color.fromRGBO(0, 230, 118, 1),
      message: message,
      duration: duration,
      snackPosition: isTopSnakbar ? SnackPosition.TOP : SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(25),
      borderRadius: 10,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    ));
  }
}
