import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lhere/Model/companyModel.dart';
import 'package:lhere/View/Homescreen/Pages/QuizPage/compnycontent.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../Constants/constants.dart';
import '../../../../Controller/getcompaniesController.dart';
import '../../../../Widgets/primarybutton.dart';
import '../../../../Widgets/secondrybutton.dart';
import '../../../Candidate/screens/introduction/startingscreen.dart';

class quizpreparatioj extends StatefulWidget {
  const quizpreparatioj({Key? key}) : super(key: key);

  @override
  _quizpreparatiojState createState() => _quizpreparatiojState();
}

class _quizpreparatiojState extends State<quizpreparatioj> {
  bool showSpinner = false;
  List<comapnyModel> compnylist = [];
  getcompaniesController getcompany = getcompaniesController();
  bool loading = true;
  String baseUrl = "https://quizzinger.com/there/company/images";

  bool nodata = false;
  getallcompanies() async {
    compnylist.clear();
    var listq = await getcompany.getcompanylist();

    setState(() {
      compnylist = listq;
      log(compnylist.length.toString());
      if (compnylist.length == 0) {
        loading = false;
        nodata = true;
      } else {
        loading = false;
        nodata = false;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getallcompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            children: [
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back)),
                  Text(
                    "Quiz Preparation",
                    style: primarytext,
                  ),
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ],
              )),
              mediumgap,
              !loading
                  ? GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: compnylist.length,
                      itemBuilder: (ctx, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => companycontentDetail(
                                        compnylist[index])));
                          },
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    height: 80,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(7),
                                            topRight: Radius.circular(7)),
                                        child: FadeInImage(
                                          placeholder:
                                              AssetImage("assets/place.png"),
                                          image: NetworkImage(
                                              "$baseUrl/${compnylist[index].image}"),
                                          fit: BoxFit.cover,
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                "assets/place.png",
                                                fit: BoxFit.cover);
                                          },
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Container(
                                      child: Text(
                                        '${compnylist[index].name}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                    )
                  : nodata == true
                      ? Center(
                          child: Container(
                              width: 250,
                              height: 150,
                              child: Text("No Results")))
                      : Center(
                          child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 128.0),
                          child: Container(
                              width: 250,
                              height: 150,
                              child: Image.asset("assets/load.gif")),
                        ))
            ],
          ),
        ),
      ),
    );
  }
}
