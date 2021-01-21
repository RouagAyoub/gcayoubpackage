import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Cardpers extends StatelessWidget {
  //Cardpers({Key key}) : super(key: key);
  Cardpers();
  // Size size;
  Function onclik;
  String name = "";
  String phonenumber = "";
  String position = "";
  Cardpers.all({this.name, this.phonenumber, this.position, this.onclik});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: onclik,
        child: Container(
          margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
          width: size.width,
          //height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Client : $name",
                  style: TextStyle(
                    fontSize: 20,
                  )),
              Text(
                "pho N° :$phonenumber",
                style: TextStyle(fontSize: 17, color: Colors.white70),
              ),
              Text(
                "position :" + (position ?? "dd"),
                style: TextStyle(fontSize: 17, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
