import 'package:flutter/material.dart';
import 'package:lhere/View/Profileanaylsis/profilingcompleted.dart';

import '../../Constants/constants.dart';

class profiling2 extends StatefulWidget {
  const profiling2({Key? key}) : super(key: key);

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
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Profilanalyse",
                      textAlign: TextAlign.center,
                      style: Secondtext,
                    ),
                    mediumgap,
                    Text(
                      "Welcher Bereich spricht dich am meisten an?",
                      style: questionstext,
                      textAlign: TextAlign.left,
                    ),
                    smallgap,
                    InkWell(


                      onTap:(){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => profilingcompleted("Technology"),
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
                            SizedBox(
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
                            const Positioned(
                                bottom:15,
                                right:15,
                                child: Text("Technik",style:TextStyle(color:Colors.white,fontSize:20,fontWeight: FontWeight.bold),))
                          ],
                        ),
                      ),
                    ),
                    smallgap,
                    InkWell(
                      onTap:(){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => profilingcompleted("Kitchen"),
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
                            SizedBox(
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
                            const Positioned(
                                bottom:15,
                                right:15,
                                child: Text("Küche",style:TextStyle(color:Colors.white,fontSize:20,fontWeight: FontWeight.bold),))
                          ],
                        ),
                      ),
                    ),
                    smallgap,
                    InkWell(
                      onTap:(){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => profilingcompleted("Office"),
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
                            SizedBox(
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
                            const Positioned(
                                bottom:15,
                                right:15,
                                child: Text("Büro",style:TextStyle(color:Colors.white,fontSize:20,fontWeight: FontWeight.bold),))
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
