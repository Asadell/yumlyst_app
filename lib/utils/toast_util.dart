import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType {
  success,
  error,
  warning,
  info,
}

class ToastUtil {
  static void show({
    required String message,
    ToastType type = ToastType.info,
    ToastGravity gravity = ToastGravity.TOP,
    Duration duration = const Duration(seconds: 2),
  }) {
    Color backgroundColor;
    Color textColor = Colors.white;

    switch (type) {
      case ToastType.success:
        backgroundColor = Colors.green;
        break;
      case ToastType.error:
        backgroundColor = Colors.redAccent;
        break;
      case ToastType.warning:
        backgroundColor = Colors.orangeAccent;
        break;
      case ToastType.info:
      default:
        backgroundColor = Colors.blueAccent;
        break;
    }

    Fluttertoast.showToast(
      msg: message,
      backgroundColor: backgroundColor,
      textColor: textColor,
      gravity: gravity,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: duration.inSeconds,
    );
  }

  static void showSuccess(String message) {
    show(message: message, type: ToastType.success);
  }

  static void showError(String message) {
    show(message: message, type: ToastType.error);
  }

  static void showWarning(String message) {
    show(message: message, type: ToastType.warning);
  }

  static void showInfo(String message) {
    show(message: message, type: ToastType.info);
  }
}
