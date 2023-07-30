import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lhere/Constants/constants.dart';
import 'package:http/http.dart' as http;

import '../View/Authentication/Sigin/signin.dart';

class signupController {
  String signupUrl = "${Constants.baseUrl}App/registeruser.php";
  addsignup(String fullname, String city, String email, String password,
      BuildContext context, String lat, String long) async {

    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    var map = <String, dynamic>{};
    map['fullname'] = fullname;
    map['city'] = city;
    map['latitude'] = lat;
    map['longitude'] = long;
    map['email'] = email;
    map['password'] = password;
    var url = Uri.parse(signupUrl);

    var response = await http.post(url, body: jsonEncode(map), headers: headers);

    log(response.body.toString());
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Successfully Registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => login()));
    } else {
      Fluttertoast.showToast(
          msg: "Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
