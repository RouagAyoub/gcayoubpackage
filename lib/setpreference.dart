import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gcayoubpackage/fetshdefault.dart';
import 'package:gcayoubpackage/showtoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences _pref;
FirebaseAuth _auth = FirebaseAuth.instance;
String userphonenumber;
String setedstaticUrl;
List<String> setmap;

var getedcomercial;
var setedfrommap;

Future<bool> logout() async {
  try {
    await _auth.signOut();
    setpref(false);
    return true;
  } catch (e) {
    showToast(e.toString(), Colors.red);
    return false;
  }
}

Future<bool> setpref(value) async {
  try {
    _pref = await SharedPreferences.getInstance();
    final String key = "login";
    _pref.setBool(key, value);
    return true;
  } catch (e) {
    showToast(e.toString(), Colors.red);
    return false;
  }
}

Future<bool> getpref() async {
  try {
    _pref = await SharedPreferences.getInstance();
    final String key = "login";
    final value = _pref.getBool(key);
    return value;
  } catch (e) {
    showToast(e.toString(), Colors.red);
    return false;
  }
}

Future setphonenumber() async {
  userphonenumber = _auth.currentUser.phoneNumber;
  await getuserdetails();
}

Future getuserdetails() async {
  await fetch(
          setedstaticUrl,
          {
            '${setmap[0]}': "${setmap[1]} $userphonenumber",
            '${setmap[2]}': "${setmap[3]}"
          },
          setedfrommap)
      .then((value) {
    getedcomercial = value[0];
  });
}

setstaticdetails(url, map, frommap) {
  setedstaticUrl = url;
  setmap = map;
  setedfrommap = frommap;
}
