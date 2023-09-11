import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lhere/View/Candidate/screens/introduction/startingscreen.dart';
import 'package:lhere/View/Homescreen/Pages/QuizPage/quizdescription.dart';
import 'package:lhere/Widgets/primarybutton.dart';
import 'package:lhere/Widgets/secondrybutton.dart';

import '../../../../Constants/constants.dart';

class Quizscreen extends StatefulWidget {
  const Quizscreen({Key? key}) : super(key: key);

  @override
  _QuizscreenState createState() => _QuizscreenState();
}

class _QuizscreenState extends State<Quizscreen> {
  @override
  Widget build(BuildContext context) {
    var wsize = MediaQuery.of(context).size.width;
    var hsize = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: wsize,
            color: primarycolor,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 60, left: 16, right: 16, bottom: 20),
              child: Stack(
                clipBehavior: Clip.none, children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tolle Preise gewinnen",
                            style: GoogleFonts.alata(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.035),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Teste dein Wissen und gewinne",
            textAlign: TextAlign.center,
            style: Secondtext,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Image.asset(
              'assets/bored.png',
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 45, right: 45),
            child: secondrybutton(title: "Quiz", onpressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => quizdesc()));
            }),
          )
        ]),
      ),
    );
  }
}
