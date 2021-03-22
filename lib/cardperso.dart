import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Cardpers extends StatelessWidget {
  //Cardpers({Key key}) : super(key: key);

  Cardpers.all({this.wiget, this.onclikcard, this.cardcolor});
  final Widget wiget;
  final Function onclikcard;
  final Color cardcolor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      color: cardcolor,
      child: InkWell(
        splashColor: Colors.amber[800],
        onTap: onclikcard,
        child: Container(
            margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            width: size.width,
            //height: 80,
            child: wiget),
      ),
    );
    ;
  }
}
