import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(message, colores) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: colores,
      textColor: Colors.black,
      fontSize: 13.0);
}
