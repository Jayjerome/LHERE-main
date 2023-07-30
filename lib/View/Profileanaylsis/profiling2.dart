import 'package:flutter/material.dart';
import 'package:lhere/Model/Questionsmodel.dart';
import 'package:lhere/View/Profileanaylsis/profilingcompleted.dart';
import 'package:lhere/Widgets/primarybutton.dart';
import 'package:lhere/Widgets/secondrybutton.dart';

import '../../Constants/constants.dart';

class profiling2 extends StatefulWidget {
  @override
  _profiling2State createState() => _profiling2State();
}

class _profiling2State extends State<profiling2> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Profile Analysis",
                      textAlign: TextAlign.center,
                      style: Secondtext,
                    ),
                    mediumgap,
                    Text(
                      "Which category do you like more?",
                      style: questionstext,
                      textAlign: TextAlign.left,
                    ),
                    smallgap,
                    InkWell(


                        onTap:(){
                          Navigator.push(
                              context,
                              new MaterialPageRoute(builder: (context) => profilingcompleted("Technology"),
                              ));

                      },
                      child: Container(
                        width: width,
                        height: height * 0.14,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black87),
                        child:Stack(
                          children: [
                            Container(
                              width: width,
                              height: height * 0.14,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),

                                  child: Image.asset("assets/tech.jpg",fit:BoxFit.cover,)),
                            ),
                            Container(
                              width: width,
                              height: height * 0.14,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.black26),
                            ),
                            Positioned(
                              bottom:15,
                                right:15,
                                child: Text("Technical Work",style:TextStyle(color:Colors.white,fontSize:20,fontWeight: FontWeight.bold),))
                          ],
                        ),
                      ),
                    ),
                    smallgap,
                    InkWell(
                      onTap:(){
                        Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => profilingcompleted("Kitchen"),
                            ));
                      },
                      child: Container(
                        width: width,
                        height: height * 0.14,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black87),
                        child:Stack(
                          children: [
                            Container(
                              width: width,
                              height: height * 0.14,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),

                                  child: Image.asset("assets/cook.jpg",fit:BoxFit.cover,)),
                            ),
                            Container(
                              width: width,
                              height: height * 0.14,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.black26),
                            ),
                            Positioned(
                                bottom:15,
                                right:15,
                                child: Text("Kitchen Work",style:TextStyle(color:Colors.white,fontSize:20,fontWeight: FontWeight.bold),))
                          ],
                        ),
                      ),
                    ),
                    smallgap,
                    InkWell(
                      onTap:(){
                        Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => profilingcompleted("Office"),
                            ));
                      },
                      child: Container(
                        width: width,
                        height: height * 0.14,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black87),
                        child:Stack(
                          children: [
                            Container(
                              width: width,
                              height: height * 0.14,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),

                                  child: Image.asset("assets/office.jpg",fit:BoxFit.cover,)),
                            ),
                            Container(
                              width: width,
                              height: height * 0.14,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.black26),
                            ),
                            Positioned(
                                bottom:15,
                                right:15,
                                child: Text("Office Work",style:TextStyle(color:Colors.white,fontSize:20,fontWeight: FontWeight.bold),))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   left: 0,
              //   right:0 ,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       primarybutton(
              //           title: "Next",
              //           onpressed: () {
              //
              //           }),
              //       smallgap,
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}