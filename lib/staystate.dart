import 'package:flutter/material.dart';
import 'package:gcayoubpackage/changepage.dart';
import 'package:gcayoubpackage/setpreference.dart';

class Staystate extends StatefulWidget {
  final loginpage, homepage;
  Staystate({
    Key key,
    this.loginpage,
    this.homepage,
  }) : super(key: key);

  @override
  _StaystateState createState() =>
      _StaystateState(loginpage: loginpage, homepage: homepage);
}

class _StaystateState extends State<Staystate> {
  final loginpage, homepage;

  _StaystateState({this.loginpage, this.homepage});
  @override
  void initState() {
    getprefer();
    super.initState();
  }

  getprefer() async {
    await getpref().then((value) async {
      if (value == null || value == false) {
        changeremplacepage(context, loginpage);
      } else {
        await setphonenumber()
            .whenComplete(() => changeremplacepage(context, homepage));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //hna mba3da tji animation
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
