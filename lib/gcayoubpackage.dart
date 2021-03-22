library gcayoubpackage;

import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gcayoubpackage/changepage.dart';
import 'package:gcayoubpackage/setpreference.dart';

class Authentification {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId;
  TextEditingController _codecontroler = TextEditingController();
  number(BuildContext context, String values, homepage) async {
    final PhoneCodeAutoRetrievalTimeout _codeAutoRetrievalTimeout =
        (String verificationId) {
      //this.verificationId = verificationId;
    };

    final PhoneVerificationCompleted _verificationCompleted =
        (AuthCredential credential) async {
      var result = await _auth.signInWithCredential(credential);

      if (result.user != null) {
        changeremplacepage(context, homepage);
      }
    };

    final PhoneCodeSent codeSent =
        (String verification, [int forceResendingToken]) async {
      this.verificationId = verification;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirmation Code'),
            content: Container(
              height: 85,
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'check your sms'),
                    controller: _codecontroler,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  final code = _codecontroler.text.trim();
                  try {
                    AuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: verificationId, smsCode: code);
                    var authResult =
                        await _auth.signInWithCredential(credential);
                    if (authResult.user != null) {
                      await setpref(true).then((value) => value
                          ? changeremplacepage(context, homepage)
                          : poprefresh(context));
                    } else {
                      poprefresh(context);
                    }
                  } catch (e) {
                    poprefresh(context);
                  }
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_alarm,
                      color: Colors.deepOrange,
                    ),
                    Text('valid')
                  ],
                ),
              ),
            ],
          );
        },
      );
    };

    final PhoneVerificationFailed _verificationFailed = (var authException) {};

    await _auth.verifyPhoneNumber(
      phoneNumber: values.trim(),
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
      codeSent: codeSent,
      timeout: const Duration(seconds: 20),
      verificationCompleted: _verificationCompleted,
      verificationFailed: _verificationFailed,
    );
  }
}
