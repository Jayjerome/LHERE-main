import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:lhere/Model/companyModel.dart';
import 'package:lhere/Model/postModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/constants.dart';

class getcompaniesController {
  String companiesUrl = "${Constants.baseUrl}App/getCompanies.php";

  Future<List<postModel>> getcompanydata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var position = await getCurrentPosition();
    String city = prefs.getString("city").toString();
    String skill = prefs.getString("skill").toString();

    var bodydata = {
      "city": city,
      "skill": skill,
      "latitude": position.latitude.toString(),
      "longitude": position.longitude.toString(),
      "radius": 100000.toString()
    };
    List<postModel> posts = [];

    var url = Uri.parse(companiesUrl);

    var response = await http.post(url, body: bodydata);

    if (response.body == "0 results[]") {
      return posts;
    } else {
      var userdata = await json.decode(response.body);
      var listofcompanies = userdata['data'];
      for (var data in listofcompanies) {
        posts.add(postModel.fromJson(data));
      }
      log(posts.length.toString());

      return posts;
    }
  }

  Future<List<comapnyModel>> getcompanylist() async {
    List<comapnyModel> companylist = [];

    var url = Uri.parse("${Constants.baseUrl}App/getcat.php");
    var response = await http.get(url);

    log(response.body);

    if (response.body == "0 results[]") {
      return companylist;
    } else {
      var userdata = await json.decode(response.body);
      var listofcompanies = userdata['data'];
      for (var data in listofcompanies) {
        companylist.add(comapnyModel.fromJson(data));
      }
      log(companylist.length.toString());

      return companylist;
    }
  }

  Future<List<postModel>> getfilter(String city, String interest, String radius, double latitude, double longitude) async {
    print(city);
    print(interest);
    var bodydata = {
      "city": city,
      "skill": interest,
      "latitude": latitude.toString(),
      "longitude": longitude.toString(),
      "radius": radius.toString()
    };
    List<postModel> posts = [];

    var url = Uri.parse(companiesUrl);

    var response = await http.post(url, body: bodydata);

    log(response.body);

    if (response.body == "0 results[]" || response.body.isEmpty) {
      return posts;
    } else {
      var userdata = await json.decode(response.body);
      var listofcompanies = userdata['data'];
      for (var data in listofcompanies) {
        posts.add(postModel.fromJson(data));
        print('Adding post');
      }

      return posts;
    }
  }

  String companyUrl = "${Constants.baseUrl}App/getcompanydata.php";

  getucompanydata(String id, BuildContext context) async {
    var bodydata = {
      "id": id,
    };
    var url = Uri.parse(companyUrl);

    var response = await http.post(url, body: bodydata);

    log(response.body);

    var userdata = await json.decode(response.body);

    log(response.body);

    comapnyModel userm = comapnyModel.fromJson(userdata["data"][0]);
    return userm;
  }

  Future<void> sendemail(String name, String email, String city,
      String companyemail, String address, File cv, BuildContext context) async {
    var bodydata = json.encode({
      "service_id": "service_jwapcem",
      "template_id": "template_chtxds9",
      "user_id": "Lt3VZf1nD1KeUnx5K",
      "template_params": {
        "city": city,
        "name": name,
        "emailfrom": email,
        "emailto": companyemail,
        "address": address,
        "cv":cv
      }
    });
    var url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send-form");
    var response = await http.post(url, body: bodydata, headers: {
      "Content-Type": 'multipart/form-data',
      "origin": 'http://localhost'
    });

    log(response.body);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Your details are sent."),
    ));
    Navigator.pop(context);
  }

  Future<void> sendMailNew(String name, String email, String city,
      String companyemail, String phone, String postalCode, File cv, BuildContext context) async {
    const String fieldName = 'attachment';
    final String fileName = cv.path.split('/').last;

    final Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };

    final Uri uri = Uri.parse("${Constants.baseUrl}App/sendemail.php");

    final http.MultipartRequest request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..files.add(http.MultipartFile(
        fieldName,
        cv.readAsBytes().asStream(),
        cv.lengthSync(),
        filename: fileName,
      ))
      ..fields['recipient_name'] = name
      ..fields['recipient'] = companyemail
      ..fields['city'] = city
      ..fields['address'] = city
      ..fields['phone'] = phone
      ..fields['code'] = postalCode;

    try {
      final http.Response response = await http.Response.fromStream(await request.send());
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Your details are sent."),
      ));
      Navigator.pop(context);
    } catch (error) {
      print('Error uploading file: $error');
    }
  }

  Future<Position> getCurrentPosition() async {
    // Test if location services are enabled.
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            Exception('Location permissions are permanently denied.'));
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error(Exception('Location permissions are denied.'));
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
