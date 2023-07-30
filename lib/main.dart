import 'dart:async';
import 'dart:io';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lhere/Constants/constants.dart';
import 'package:lhere/View/Homescreen/menu.dart';
import 'package:lhere/View/Onboarding/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lhere/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'httpoverrides.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MaterialApp(
      theme: ThemeData(
        //2
        primaryColor: Color(0xffef801a),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat',
        //3
        visualDensity: VisualDensity.adaptivePlatformDensity,

        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          primary: Color(0xffef801a), //change background color of button
          onPrimary: Colors.white, //change text color of button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        )),
      ),
      debugShowCheckedModeBanner: false,
      title: "LEHRE YOUR FUTURE",
      home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MAppState createState() => _MAppState();
}

class _MAppState extends State<MyApp> {
  @override
  void initState() {
    startSplashScreen();

    super.initState();
  }

  startSplashScreen() {
    var duration = const Duration(seconds: 4);
    return Timer(duration, () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String loggin = await prefs.getString("loggedin").toString();

      if (loggin != "yes") {
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => onboarding()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => menu()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          mediumgap,
          Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Image.asset("assets/mainlogo.jpg")),
          DelayedDisplay(
            delay: Duration(seconds: 1),
            child: Container(
                width: 250, height: 150, child: Image.asset("assets/load.gif")),
          ),
        ],
      ),
    ));
  }
}
