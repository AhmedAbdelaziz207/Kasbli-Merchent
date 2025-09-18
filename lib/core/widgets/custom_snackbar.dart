import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

enum SnackBarType { success, error, warning }

class CustomSnackBar {
  static void show(
      BuildContext context, {
        required String message,
        required SnackBarType type,
        Duration duration = const Duration(seconds: 3),
      }) {
    Color backgroundColor;
    Icon icon;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = Colors.green;
        icon = const Icon(Icons.check_circle, color: Colors.white);
        break;
      case SnackBarType.error:
        backgroundColor = Colors.red;
        icon = const Icon(Icons.error, color: Colors.white);
        break;
      case SnackBarType.warning:
        backgroundColor = Colors.orange;
        icon = const Icon(Icons.warning_amber_rounded, color: Colors.white);
        break;
    }

    Flushbar(
      message: message,
      duration: duration,
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.only(top: 56, left: 16, right: 16),
      borderRadius: BorderRadius.circular(8),
      backgroundColor: backgroundColor,
      icon: icon,
      animationDuration: const Duration(milliseconds: 400),
      forwardAnimationCurve: Curves.easeOut,
      reverseAnimationCurve: Curves.easeIn,
    ).show(context);
  }
}
