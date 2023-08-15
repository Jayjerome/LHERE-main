
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lhere/Constants/constants.dart';
import 'package:lhere/View/Candidate/screens/partone/widget/customradio.dart';
import 'package:lhere/View/Homescreen/Pages/QuizPage/quizcompleted.dart';

import '../../../../Model/questionsdata.dart';


class partone extends StatefulWidget {
  List<questiondata> questionlist=[];

  partone(this.questionlist, {Key? key}) : super(key: key);

  @override
  _partoneState createState() => _partoneState();
}

class _partoneState extends State<partone> {
  int questioncount =0;
  int _value = 1;
  int points=0;
  String ans="";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,

          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              //header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      "Quiz",
                      style: GoogleFonts.alata(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize:
                          MediaQuery.of(context).size.height * 0.035),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:Row(
                        children: [
                          Text("Points: $points",style:const TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:20),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //2nd Header
              const SizedBox(
                height: 10,
              ),

              Container(

                  margin:const EdgeInsets.symmetric(horizontal:17),
                  child:CircularCountDownTimer(
                    duration:widget.questionlist.length*10,
                    initialDuration: 0,
                    isReverse:true,
                    controller: CountDownController(),
                    width: MediaQuery.of(context).size.width*0.2,
                    height: MediaQuery.of(context).size.height*0.1,
                    ringColor: Colors.white,
                    ringGradient: null,
                    fillColor:Colors.black,
                    fillGradient: null,
                    backgroundColor: primarycolor,

                    strokeWidth: 15.0,
                    strokeCap: StrokeCap.butt,
                    textStyle: TextStyle(
                    fontSize:MediaQuery.of(context).size.height * 0.025, color: Colors.white, fontWeight: FontWeight.bold),
                    textFormat: CountdownTextFormat.S,
                    isReverseAnimation: true,
                    isTimerTextShown: true,
                    autoStart: true,
                    onStart: () {
                      print('Countdown Started');
                    },
                    onComplete: () {
                      Map userdata={};
                      userdata["points"]=points;
                      userdata["time"]="0";
                      print(points.toString());
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => quizcompleted(userdata)));

                    },
                  )
              ),
              const SizedBox(
                height:10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const SizedBox(width: 20),
                Text("Question ",
                    style: TextStyle(
                        fontSize:MediaQuery.of(context).size.height * 0.02,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                Text("${questioncount+1}/${widget.questionlist.length}",
                    style: TextStyle(
                        fontSize:MediaQuery.of(context).size.height * 0.025,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ]),
              //countdown timer progressbar
              const SizedBox(
                height: 20,
              ),

              //question screen
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 17),
                padding: const EdgeInsets.symmetric(horizontal: 17),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5), //border corner radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), //color of shadow
                      spreadRadius: 5, //spread radius
                      blurRadius: 7, // blur radius
                      offset: const Offset(0, 2), // changes position of shadow
                      //first paramerter of offset is left-right
                      //second parameter is top to down
                    ),
                    //you can set more BoxShadow() here
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${widget.questionlist[questioncount].description}",
                      style: GoogleFonts.alata(
                          fontSize: MediaQuery.of(context).size.height * 0.03, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //options
                    Container(
                      child: Column(
                        children: [
                          MyRadioListTile<int>(
                            value: 1,
                            groupValue: _value,
                            leading: 'A',
                            title: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                    '${widget.questionlist[questioncount].optiona}',maxLines:2,),),
                            onChanged: (value) {
                              setState((){
                                _value=value!;

                                ans=widget.questionlist[questioncount].optiona.toString();
                                print(ans);
                              });
                            }

                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MyRadioListTile<int>(
                            value: 2,
                            groupValue: _value,
                            leading: 'B',
                            title: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                    '${widget.questionlist[questioncount].optionb}',maxLines:2,)),
                              onChanged: (value) {
                                setState((){
                                  _value=value!;
                                  ans=widget.questionlist[questioncount].optionb.toString();
                                });
                              }
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MyRadioListTile<int>(
                            value: 3,
                            groupValue: _value,
                            leading: 'C',
                            title: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                    '${widget.questionlist[questioncount].optionc}',maxLines:2,)),
                              onChanged: (value) {
                                setState((){
                                  _value=value!;
                                  ans=widget.questionlist[questioncount].optionc.toString();
                                });
                              }
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MyRadioListTile<int>(
                            value: 4,
                            groupValue: _value,
                            leading: 'D',
                            title: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                    '${widget.questionlist[questioncount].optiond}',maxLines:2,)),
                              onChanged: (value) {
                                setState((){
                                  _value=value!;
                                  ans=widget.questionlist[questioncount].optiond.toString();
                                });
                              }
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Container(
                width: 300,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(16)),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (questioncount < widget.questionlist.length - 1) {

                      if(widget.questionlist[questioncount].answer==ans)

                        {
                          points=points+10;



                          print("count $points");
                        }
                      questioncount++;

                      } else {
                        if(widget.questionlist[questioncount].answer==ans)

                        {
                          points = points + 10;
                          print(points.toString());
                          print(ans);
                        }
                        Map userdata={};
                        userdata["points"]=points;
                        userdata["time"]="0";
print(points.toString());
                          Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => quizcompleted(userdata)));

                    }});
                  },
                  child: const Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
