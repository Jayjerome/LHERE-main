import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lhere/Model/quizDetail.dart';
import 'package:lhere/View/Homescreen/Pages/QuizPage/quizcompaniesdata.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../Constants/constants.dart';
import '../../../../Controller/getcompaniesController.dart';
import '../../../../Controller/questionfetechlist.dart';
import '../../../../Widgets/circularbar.dart';
import '../../../../Widgets/primarybutton.dart';
import '../../../../Widgets/secondrybutton.dart';
import '../../../Candidate/screens/introduction/startingscreen.dart';

class quizdesc extends StatefulWidget {
  const quizdesc({Key? key}) : super(key: key);

  @override
  _quizdescState createState() => _quizdescState();
}

class _quizdescState extends State<quizdesc> {
  bool showSpinner = false;
  quizdetailModel quizdetail = quizdetailModel();
  questionafetchlist companyx = questionafetchlist();

  @override
  void initState() {
//
    getquizdata();
  }

  getquizdata() async {
    setState(() {
      showSpinner = true;
    });
    try{
      quizdetail = await companyx.getuquizdata(context);
      if (quizdetail.id!.isNotEmpty) {
        setState(() {
          showSpinner = false;
        });
      }
    }catch(e){
      setState(() {
        showSpinner = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator: Center(child: circlularbar()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Stack(
              children: [
                Container(
                  width: width,
                  height: height,
                ),
                Column(
                  children: [
                    Container(
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back)),
                            Text(
                              "Quiz Infos",
                              style: primarytext,
                            ),
                            Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ],
                        )),
                    smallgap,
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Image.asset(
                          'assets/md.png',
                          fit: BoxFit.fitWidth,
                        )),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black45, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Quiz Details",
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            ),
                            mediumgap,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: width * 0.3,
                                    child: Text(
                                      "Quiz Titel",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Container(
                                    width: width * 0.4,
                                    child: Text(
                                      "${quizdetail.title ?? ""}",
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.start,
                                    ))
                              ],
                            ),
                            smallgap,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: width * 0.3,
                                    child: Text(
                                      "Beschreibung",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Container(
                                    width: width * 0.4,
                                    child: Text(
                                      "${quizdetail.description ?? ""}",
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.start,
                                    ))
                              ],
                            ),
                            smallgap,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: width * 0.3,
                                    child: Text(
                                      "Quiz Termin / Tag",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Container(
                                    width: width * 0.4,
                                    child: Text(
                                      "${quizdetail.date ?? ""}",
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.start,
                                    ))
                              ],
                            ),
                            smallgap,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: width * 0.3,
                                    child: Text(
                                      "Quiz Zeit",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Container(
                                    width: width * 0.4,
                                    child: Text(
                                      "${quizdetail.time ?? ""}",
                                      style: TextStyle(fontSize: 15),
                                    ))
                              ],
                            ),
                            smallgap,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: width * 0.3,
                                    child: Text(
                                      "Unternehmen",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Container(
                                    width: width * 0.4,
                                    child: Text(
                                      "${quizdetail.category ?? ""}",
                                      style: TextStyle(fontSize: 15),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    left: 20,
                    right: 20,
                    bottom: 10,
                    child: Column(
                      children: [
                        smallgap,
                        primarybutton(
                          title: "Quiz starten",
                          onpressed: () {
                            final now = new DateTime.now();
                            String day =
                                DateFormat('EEEE').format(now); // 28/03/2020
                            String hour =
                                DateFormat('Hm').format(now); // 28/03/2020

                            if (quizdetail.date.toString() != '$day' &&
                                '${quizdetail.time}' != hour) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => start(
                                          quizdetail.category.toString())));
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Quiz cannot start now",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black54,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                        ),
                        smallgap,
                        secondrybutton(
                          title: "Quiz Vorbereitung",
                          onpressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => quizpreparatioj()));
                          },
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
