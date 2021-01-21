library gcayoubpackage;

import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum Returned { evfine, error }

class Authentification {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId;
  TextEditingController _codecontroler = TextEditingController();
  Future<Returned> number(BuildContext context, List<String> values) async {
    final PhoneCodeAutoRetrievalTimeout _codeAutoRetrievalTimeout =
        (String verificationId) {
      //this.verificationId = verificationId;
    };

    final PhoneVerificationCompleted _verificationCompleted =
        (AuthCredential credential) async {
      AuthResult result = await _auth.signInWithCredential(credential);

      if (result.user != null) {
        return Returned.evfine;
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
              FlatButton(
                color: Colors.blue,
                onPressed: () async {
                  final code = _codecontroler.text.trim();
                  try {
                    AuthCredential credential = PhoneAuthProvider.getCredential(
                        verificationId: verificationId, smsCode: code);
                    AuthResult authResult =
                        await _auth.signInWithCredential(credential);
                    if (authResult.user != null) {
                      return Returned.evfine;
                    } else {
                      return Returned.error;
                    }
                  } catch (e) {
                    return Returned.error;
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

    final PhoneVerificationFailed _verificationFailed =
        (AuthException authException) {
      return Returned.error;
    };

    try {
      await _auth
          .verifyPhoneNumber(
        phoneNumber: values[0].trim(),
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
        codeSent: codeSent,
        timeout: const Duration(seconds: 20),
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
      )
          .whenComplete(() {
        return Returned.evfine;
      });
    } catch (e) {
      return Returned.error;
    }
    return Returned.evfine;
  }
}
