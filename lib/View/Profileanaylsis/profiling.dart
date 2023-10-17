
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
    questionsmodel("Würdest du lieber gerne im Freien oder im Innenbereich arbeiten?","im Freien", "im Innenbereich"),
    questionsmodel("Interessierst du dich eher für einen Beruf der praktisch (z.B. Technik) oder eher theoretisch (z.B. Büro) ist?","Praktischen Beruf", "Theoretischen Beruf"),
    questionsmodel("In meiner Arbeit will ich präsentieren, reden und überzeugen?","Eher wenig", "Stimmt"),
    questionsmodel("Arbeitest du gerne viel mit Menschen zusammen?","Ja sehr gerne ", "Eher nicht"),
    questionsmodel("Arbeitest du gerne viel mit dem Tablet oder Computer?","Ja gerne","Eher nicht"),
    questionsmodel("Kannst du dir vorstellen einen handwerklichen Beruf zu erlernen?","Ja","Nein"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(25.0),
          child: Stack(
             children: [
             SizedBox(
               width:MediaQuery.of(context).size.width,
               height:MediaQuery.of(context).size.height,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     "Profilanalyse",textAlign:TextAlign.center,
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
                               MaterialPageRoute(builder: (context) => const profiling2(),
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
                               MaterialPageRoute(builder: (context) => const profiling2(),
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
