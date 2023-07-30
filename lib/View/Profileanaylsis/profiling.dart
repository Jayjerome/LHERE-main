import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lhere/Model/Questionsmodel.dart';
import 'package:lhere/View/Profileanaylsis/profiling2.dart';
import 'package:lhere/Widgets/primarybutton.dart';
import 'package:lhere/Widgets/secondrybutton.dart';

import '../../Constants/constants.dart';

class profiling extends StatefulWidget {
  const profiling({Key? key}) : super(key: key);

  @override
  _profilingState createState() => _profilingState();
}

class _profilingState extends State<profiling> {

List ans=[];

  int i=0;
  List<questionsmodel>questionList=
  [
    questionsmodel("Würdest du lieber gerne im Freien oder drinnen arbeiten?","Draußen", "Drinnen"),
    questionsmodel("Möchtest Du einen eher theoretischen oder praktischen Beruf erlernen?","Praktischen Beruf", "Theoretischen Beruf"),
    questionsmodel("In meiner Arbeit will ich präsentieren, reden und überzeugen?","Eher wenig", "Stimmt"),
    questionsmodel("Willst Du viel mit Kunden und Menschen arbeiten?","Ja sehr gerne ", "Eher nicht"),
    questionsmodel("Willst Du viel mit dem Computer arbeiten?","Ja gerne","Eher nicht"),
    questionsmodel("Willst Du einen handwerklichen Beruf erlernen?","Ja","Nein"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(25.0),
          child: Stack(
             children: [
             Container(
               width:MediaQuery.of(context).size.width,
               height:MediaQuery.of(context).size.height,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     "Profile Analysis",textAlign:TextAlign.center,
                     style:Secondtext,
                   ),
                   mediumgap,

                   Text(questionList[i].questionTitle.toString(),
                   style:questionstext,textAlign:TextAlign.left,),
                   mediumgap,
                   mediumgap,
                 ],
               ),
             ),
             Positioned(
               bottom:10,
               left:10,
               right:10,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   primarybutton(title:questionList[i].optionOne,
                       onpressed:() {
                         print(questionList.length);
                         if (i < 5) {
                           setState(() {

                             i++;
                           });
                         }
                         else{
                           Navigator.push(
                               context,
                               new MaterialPageRoute(builder: (context) => profiling2(),
                               ));
                         }
                       }
                     ),
                   smallgap,
                   secondrybutton(title:questionList[i].optionTwo,
                       onpressed:(){
                         if (i < 5) {


                           setState(() {

                             i++;

                           });
                         }
                         else{
                           Navigator.push(
                               context,
                               new MaterialPageRoute(builder: (context) => profiling2(),
                               ));
                         }
                     }),
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
