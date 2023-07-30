import 'dart:async';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lhere/Constants/constants.dart';
import 'package:lhere/Controller/updatetasks.dart';
import 'package:lhere/View/Authentication/Sigin/signin.dart';
import 'package:lhere/View/Homescreen/Pages/homepage.dart';
import 'package:lhere/View/Homescreen/menu.dart';
import 'package:lhere/View/Profileanaylsis/profiling.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Widgets/secondrybutton.dart';

class quizcompleted extends StatefulWidget {
  var data;

  quizcompleted(this.data);

  @override
  _quizcompletedState createState() => _quizcompletedState();
}

class _quizcompletedState extends State<quizcompleted> {
  updatetasks up = updatetasks();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DelayedDisplay(
                  delay: Duration(seconds: 1),
                  child: Text(
                    "Quiz Completed",
                    textAlign: TextAlign.center,
                    style: Secondtext,
                  )),
              DelayedDisplay(
                delay: Duration(seconds: 2),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.asset(
                    'assets/boardingg.png',
                  ),
                ),
              ),
              DelayedDisplay(
                delay: Duration(seconds: 3),
                child: Column(
                  children: [
                    Text(
                      "${widget.data['points']}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Point Achieved",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 45, right: 45),
                        child: secondrybutton(
                            title: "Submit Score",
                            onpressed: () async {
                              up.updatepoints(widget.data['points'].toString());
                              Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => menu(),
                                ),
                                (route) =>
                                    false, //if you want to disable back feature set to false
                              );
                            }))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
