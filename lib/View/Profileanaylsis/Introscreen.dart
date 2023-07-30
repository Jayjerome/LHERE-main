import 'dart:async';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lhere/Constants/constants.dart';
import 'package:lhere/View/Authentication/Sigin/signin.dart';
import 'package:lhere/View/Profileanaylsis/profiling.dart';

class introscreen extends StatefulWidget {
  const introscreen({Key? key}) : super(key: key);

  @override
  _introscreenState createState() => _introscreenState();
}

class _introscreenState extends State<introscreen> {




  @override
  void initState() {
    // TODO: implement initState
    starttimer();
    super.initState();
  }
  starttimer() {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () async {

      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (context) => profiling()),
      );

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DelayedDisplay(
              delay: Duration(seconds: 1),
              child: Text(
                  "Profile Analysis",textAlign:TextAlign.center,
                  style:primarytext)),
          DelayedDisplay(
            delay: Duration(seconds: 2),
            child: Text(
              "Starting Get Ready",textAlign:TextAlign.center,
              style:Secondtext,
            )),
              DelayedDisplay(
                  delay: Duration(seconds: 3),
                  child: Container(
                      width: 250,
                      height:150,
                      child: Image.asset("assets/load.gif")),),

            ],
          ),
        ),
      ),
    );
  }
}
