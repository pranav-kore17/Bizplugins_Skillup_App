import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizplugins_skillup/utils/colors.dart';

class ConfirmDialog {
  static void show({
    required String title,
    required String message,
    String confirmText = "Confirm",
    String cancelText = "Cancel",
    Color confirmColor = Colors.red,
    IconData? icon,
    bool barrierDismissible = false,
    required VoidCallback onConfirm,
  }) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        actionsPadding: const EdgeInsets.only(right: 10, bottom: 10),

        /// TITLE + ICON
        title: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: confirmColor),
              const SizedBox(width: 8),
            ],
            Expanded(child: Text(title)),
          ],
        ),

        /// MESSAGE
        content: Text(
          message,
          style: const TextStyle(fontSize: 14),
        ),

        /// ACTIONS
        actions: [
          /// Cancel Button
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              cancelText,
              style: TextStyle(
                color: primaryPurple,
              ),
            ),
          ),

          /// Confirm Button
          TextButton(
            onPressed: () {
              Get.back();
              onConfirm();
            },
            child: Text(
              confirmText,
              style: TextStyle(
                color: confirmColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
  }
}
