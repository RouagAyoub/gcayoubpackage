library gcayoubpackage;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loginwidg {
  Widget loginpage(Widget instack, _phoneno) {
    final _formkey = GlobalKey<FormState>();
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Container(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Text("data"),
                  Row(children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _phoneno,

                          decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.greenAccent, width: 5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 5.0),
                            ),
                            hintText: 'Mobile Number',
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            if (value.length < 4 || value.length > 14) {
                              return 'Votre numéro est incorrect !';
                            } else if (value.startsWith('0')) {
                              _phoneno.text = value.replaceFirst('0', '');
                            }
                          },
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
