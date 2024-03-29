import 'dart:async';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:lhere/Constants/constants.dart';
import 'package:lhere/Controller/updatetasks.dart';

import '../Homescreen/menu.dart';

class profilingcompleted extends StatefulWidget {
String skill;

profilingcompleted(this.skill, {Key? key}) : super(key: key);

  @override
  _profilingcompletedState createState() => _profilingcompletedState();
}

class _profilingcompletedState extends State<profilingcompleted> {



updatetasks up=updatetasks();
  @override
  void initState() {
    // TODO: implement initState
    up.updatethings(widget.skill);
    starttimer();
    super.initState();
  }


  starttimer() {

    var duration = const Duration(seconds: 7);
    return Timer(duration, () async {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const menu()),
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
                  delay: const Duration(seconds: 1),
                  child: Text(
                    "Analysis Completed",textAlign:TextAlign.center,
                    style:Secondtext,
                  )),
              DelayedDisplay(
                delay:const Duration(seconds:2),
                child: SizedBox(
                  width:MediaQuery.of(context).size.width*0.9,

                  child: Image.asset(
                    'assets/boardingg.png',

                  ),),
              ),
              DelayedDisplay(
                delay: const Duration(seconds: 3),
                child: SizedBox(
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
