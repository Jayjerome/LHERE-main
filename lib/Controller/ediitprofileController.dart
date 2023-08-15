import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class editprofilecontroller
{

  String baseUrl="https://lehreyourfuture.com";
  String updateUrl="App/updateuser.php";
  updateuser(String fullname,String city,BuildContext context,String email)
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    log("$email.$fullname.$city");
    var bodydata={
      "fullname":fullname,
      "city":city,
      "email":email

    };
    var url=Uri.parse(baseUrl+updateUrl);
    var response= await http.post(url,body:bodydata);
    log(response.body);
    prefs.setString("name", fullname);
    prefs.setString("city", city);
    if(response.statusCode==200)
    {

      Fluttertoast.showToast(
          msg: "Successfully Updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);


    }
    else
    {
      Fluttertoast.showToast(
          msg:"Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);

    }


  }}





