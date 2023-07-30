import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lhere/Constants/constants.dart';


import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../View/Authentication/Sigin/signin.dart';

class updatetasks {


  String updateUrl = "${Constants.baseUrl}App/updateskill.php";

  updatethings(String skill) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("skill", skill);
    String email = await prefs.getString("email").toString();
    var bodydata = {
      "skill": skill,
      "email": email
    };
    var url = Uri.parse(updateUrl);

    var response = await http.post(url, body: bodydata);
    log(response.body);
  }

  updatepoints(String points) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("points", points);
    String email = await prefs.getString("email").toString();
    var bodydata = {
      "points": points,
      "email": email
    };
    var url = Uri.parse("${Constants.baseUrl}App/updatepoints.php");

    var response = await http.post(url, body: bodydata);
    log(response.body);
  }
}


