import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lhere/View/Homescreen/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/constants.dart';
import '../View/Profileanaylsis/Introscreen.dart';

class signinController {
  String signinUrl = "${Constants.baseUrl}App/getuserdata.php";

  getuserdata(String email, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    log(email);
    var bodydata = {
      "email": email,
    };
    var url = Uri.parse(signinUrl);

    var response = await http.post(url, body: jsonEncode(bodydata));
    log(response.toString());
    log(response.body);
    if (response.body == "notfound") {
    } else {
      var userdata = await json.decode(response.body);
      String fullname = userdata['data'][0]['fullname'];
      String id = userdata['data'][0]['id'];
      String emailget = userdata['data'][0]['email'];
      String city = userdata['data'][0]['city'];
      String skill = userdata['data'][0]['skill'];
      String point = userdata['data'][0]['points'];

      prefs.setString("name", fullname);
      prefs.setString("id", id);
      prefs.setString("email", emailget);
      prefs.setString("city", city);
      prefs.setString("skill", skill);
      prefs.setString("points", point);
      prefs.setString("loggedin", "yes");

      if (skill == "no") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const introscreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => const menu()));
      }

      return "ok";
    }
  }
}
