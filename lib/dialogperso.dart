import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Dialogperso {
  void showdialog(BuildContext context, widget) {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, setState) {
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
}
