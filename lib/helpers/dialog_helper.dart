import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  static void showErrorSnackBar({String? title, String? message}) {
    Get.snackbar(
      title ?? 'Error',
      message ?? 'Something goes wrong!',
      duration: const Duration(seconds: 2),
      colorText: Colors.white,
      backgroundColor: Colors.redAccent,
      margin: EdgeInsets.zero,
      borderRadius: 0,
      snackPosition: SnackPosition.BOTTOM,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
      shouldIconPulse: true,
    );
  }

  static void showSuccessSnackBar(String message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 3),
      colorText: Colors.white,
      margin: const EdgeInsets.all(10.0),
      borderRadius: 5.0,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static void showLoading() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}
