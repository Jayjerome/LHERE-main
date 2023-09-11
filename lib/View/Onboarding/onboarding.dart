import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lhere/Constants/constants.dart';
import 'package:lhere/View/Authentication/Sigin/signin.dart';
import 'package:lhere/View/Authentication/Signup/signup.dart';
import 'package:lhere/Widgets/primarybutton.dart';

class onboarding extends StatefulWidget {
  const onboarding({Key? key}) : super(key: key);

  @override
  _onboardingState createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            DelayedDisplay(
              delay: Duration(seconds: 1),
              child: Container(
                  width: width,
                  height: height,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    child: Column(
                      children: [
                        mediumgap,
                        Text(
                          "Willkommen",
                          style: primarytext,
                        ),
                        smallgap,
                        Text(
                          "Einfach per App oder Webseite rasch die passende LEHRSTELLE finden.\n"
                              "Wer möchte, kann zusätzlich in der APP durch unser Spiel "
                              "tolle Preise gewinnen und sein Wissen erweitern."
                              "\nViel Freude und Erfolg bei der Lehrstellensuche!",
                          style: secondrytext,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  )),
            ),
            Positioned(
              top: 50,
              bottom: 50,
              left: 10,
              right: 10,
              child: DelayedDisplay(
                delay: Duration(seconds: 2),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.asset(
                    'assets/teenage.jpeg',
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: DelayedDisplay(
                delay: Duration(seconds: 3),
                child: primarybutton(
                  title: "Lehrstelle suchen",
                  onpressed: () {
                    Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => login(),
                        ));
                  },
                ),
              ),
              // child:Container(
              // width: MediaQuery.of(context).size.width,
              // height: 50,
              // child: ElevatedButton(
              //   child: Text('Get Started'),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       new MaterialPageRoute(builder: (context) => signup()),
              //     );
              //   },
              //   onLongPress: () {
              //     print('Long press');
              //   },
              //   // style: ElevatedButton.styleFrom(
              //   //   primary: Colors.white,
              //   //   onPrimary: Colors.black, //change text color of button
              //   //   shape: RoundedRectangleBorder(
              //   //     borderRadius: BorderRadius.circular(16),
              //   //   ),
              //   // ),
              // ))
            )
          ],
        ),
      ),
    );
  }
}
