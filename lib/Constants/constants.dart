import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///firebase account credentials:
///email:lhere.your.future@gmail..
///password:Rrizvi175

var primarytext =
    GoogleFonts.share(fontSize: 30.0, fontWeight: FontWeight.bold);

var Secondtext = GoogleFonts.pacifico(fontSize: 30.0, color: Colors.orange);
var questionstext = GoogleFonts.share(fontSize: 40, color: Colors.black87);
var secondrytext = const TextStyle(fontSize: 14, color: Color(0xff808077));
var biggap = const SizedBox(
  height: 50,
);
var mediumgap = const SizedBox(
  height: 30,
);
var smallgap = const SizedBox(
  height: 15,
);
var primarycolor = const Color(0xffef801a);

var boxdecor = const BoxDecoration(
  //DecorationImage
  //Border.all
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(10.0),
    topRight: Radius.circular(10.0),
    bottomLeft: Radius.circular(10.0),
    bottomRight: Radius.circular(10.0),
  ),

  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 2,
      offset: Offset(2, 5),
    ), //BoxShadow
    //BoxShadow
  ],
);

class Constants {
  static String baseUrl = "https://lehreyourfuture.com/";
  String signupUrl = "App/registeruser.php";
}

bool isStrongPassword(String password) {
  final hasUppercase = password.contains(RegExp(r'[A-Z]'));
  final hasLowercase = password.contains(RegExp(r'[a-z]'));
  final hasDigits = password.contains(RegExp(r'[0-9]'));
  final hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  final isMinimumLength = password.length >= 8;

  return hasUppercase && hasLowercase && hasDigits && hasSpecialCharacters && isMinimumLength;
}

