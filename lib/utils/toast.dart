import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { normal, success, fail }

class ShowToast {
  static normal(String message) {
    ShowToast.tt(message, ToastType.normal);
  }

  static success(String message) {
    ShowToast.tt(message, ToastType.success);
  }

  static error(String message) {
    ShowToast.tt(message, ToastType.fail);
  }

  static tt(String message, ToastType toastType) {
    Color toastColor;
    switch (toastType) {
      case ToastType.normal:
        toastColor = Color(0xff404351);
        break;
      case ToastType.success:
        toastColor = Color(0xff404351);
        break;
      case ToastType.fail:
        toastColor = Color(0xff404351);
        break;
    }
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: toastColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
