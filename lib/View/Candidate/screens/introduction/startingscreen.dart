import 'dart:async';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Controller/questionfetechlist.dart';
import '../../../../Model/questionsdata.dart';
import '../partone/partone.dart';


class start extends StatefulWidget {
  String company;

  start(this.company);

  @override
  _startState createState() => _startState();
}

class _startState extends State<start> {
  final Duration initialDelay = Duration(seconds: 1);
  int count=0;
  late Timer _timer;
  int _start = 9;
  int points=0;
  List<questiondata> questionlist = [];
  questionafetchlist question= questionafetchlist();

  getallquestions()
  async {
    var listq=await question.getquestionalist(widget.company);

    setState(() {
      questionlist=listq;
    });

  }
  @override
  void initState() {
    getallquestions();
    Future.delayed(const Duration(milliseconds: 1000), () {

      startTimer();

    });



    super.initState();


  }


  @override
  void dispose() {
    _timer.cancel();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => partone(questionlist)));
          });
        } else {
          setState(() {

            _start--;

          });
        }
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child:Stack(
                          
                          children:[

                            Positioned(
                              top:200,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Align(

                                  alignment:Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.center,
                                    mainAxisAlignment:MainAxisAlignment.center,
                                    children: [
                                      DelayedDisplay(
                                      delay: initialDelay,
                                      child: Text(
                                        "Get Ready!",textAlign:TextAlign.center,
                                        style: GoogleFonts.share(
                                          fontSize: 28.0,
                                          color: Colors.black87,

                                      ))),
                                      Container(
                                        margin:EdgeInsets.only(top:20),
                                        child: AnimatedTextKit( totalRepeatCount: 1,

                                          animatedTexts: [
                                            ScaleAnimatedText('3',scalingFactor: 0.2 ,textStyle: GoogleFonts.pacifico(
                                              fontSize:128.0,
                                              color: Colors.orange,
                                            ),),
                                            ScaleAnimatedText('2',scalingFactor: 0.2,textStyle: GoogleFonts.pacifico(
                                              fontSize: 98.0,
                                              color: Colors.orange,
                                            ),),
                                            ScaleAnimatedText('1',scalingFactor: 0.2,textStyle: GoogleFonts.pacifico(
                                              fontSize: 98.0,
                                              color: Colors.orange,
                                            ),),


                                          ],
                                        ),
                                      ),
                                      DelayedDisplay(
                                        delay: Duration(seconds: 8),
                                        child: Text(
                                          "Best of Luck",textAlign:TextAlign.center,
                                          style:GoogleFonts.pacifico(
                                            fontSize:38.0,
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),



                          ]),






            )),
        ),

        );
  }
}
