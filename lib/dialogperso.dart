import 'package:flutter/material.dart';

void showdialog(context, widget) {
  Size size = MediaQuery.of(context).size;
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Builder(builder: (builder) {
            return Container(
                height: size.height - 20,
                width: size.width - 20,
                child: widget);
          }),
        );
      },
    ),
  );
}
