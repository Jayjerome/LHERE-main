import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lhere/Controller/getcompaniesController.dart';
import 'package:lhere/Model/companyModel.dart';
import 'package:lhere/Widgets/primarybutton.dart';
import 'package:lhere/Widgets/secondrybutton.dart';

import '../../../Constants/constants.dart';
import 'email_form.dart';

class jobdetail extends StatefulWidget {
  var data;

  jobdetail(this.data);

  @override
  _jobdetailState createState() => _jobdetailState();
}

class _jobdetailState extends State<jobdetail> {
  bool desc = true;
  bool company = false;
  comapnyModel companydata = comapnyModel();
  getcompaniesController companyx = getcompaniesController();

  @override
  void initState() {
//
    getcompanydata();
  }

  getcompanydata() async {
    companydata =
        await companyx.getucompanydata(widget.data.company_id, context);
  }

  @override
  Widget build(BuildContext context) {
    var wsize = MediaQuery.of(context).size.width;
    var hsize = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                width: wsize,
                color: primarycolor,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 0, right: 0, bottom: 20),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  )),
                              Text(
                                "Jobdetails",
                                style: GoogleFonts.alata(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.035),
                              ),
                            ],
                          ),
                          smallgap,
                          smallgap,
                          smallgap,
                          smallgap,
                        ],
                      ),
                      Positioned(
                        top: hsize * 0.1,
                        left: wsize * 0.38,
                        right: wsize * 0.38,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 5)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(75),
                              child: FadeInImage.assetNetwork(
                                placeholder: "assets/place.png",
                                image: "${widget.data.image}",
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              mediumgap,
              smallgap,
              smallgap,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "${widget.data.title}",
                  style: TextStyle(
                    fontSize: hsize * 0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              mediumgap,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (desc) {
                          setState(() {
                            desc = false;
                            company = true;
                          });
                        } else {
                          setState(() {
                            desc = true;
                            company = false;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: desc ? primarycolor : Colors.black12),
                            color: desc ? primarycolor : Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        width: wsize * 0.45,
                        child: Center(
                            child: Text(
                          "Beschreibung",
                          style: TextStyle(
                              color: desc ? Colors.white : Colors.black87),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (company) {
                          setState(() {
                            company = false;
                            desc = true;
                          });
                        } else {
                          setState(() {
                            desc = false;
                            company = true;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: company ? primarycolor : Colors.black12),
                            color: company ? primarycolor : Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        width: wsize * 0.45,
                        child: Center(
                            child: Text(
                          "Unternehmen",
                          style: TextStyle(
                              color: company ? Colors.white : Colors.black87),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                  visible: desc,
                  child: Container(
                    width: wsize * 0.9,
                    margin: EdgeInsets.only(bottom: 100),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //about
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 28,
                            ),
                            Text(
                              "Stellenbeschreibung",
                              style: TextStyle(
                                fontSize: hsize * 0.022,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${widget.data.description}",
                              style: TextStyle(
                                  fontSize: hsize * 0.020,
                                  color: Colors.black45),
                            ),
                          ],
                        ),
                        //salary
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            smallgap,
                            Text(
                              "Gehalt",
                              style: TextStyle(
                                fontSize: hsize * 0.022,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${widget.data.salary}",
                              style: TextStyle(
                                  fontSize: hsize * 0.020,
                                  color: Colors.black45),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              Visibility(
                  visible: company,
                  child: Container(
                    width: wsize * 0.9,
                    margin: EdgeInsets.only(bottom: 100),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //about
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 28,
                            ),
                            Text(
                              "Unternehmen",
                              style: TextStyle(
                                fontSize: hsize * 0.022,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${companydata.name}",
                              style: TextStyle(
                                  fontSize: hsize * 0.020,
                                  color: Colors.black45),
                            ),
                          ],
                        ),
                        //salary
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            smallgap,
                            Text(
                              "Stellenbeschreibung",
                              style: TextStyle(
                                fontSize: hsize * 0.022,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              companydata.about.toString(),
                              style: TextStyle(
                                  fontSize: hsize * 0.020,
                                  color: Colors.black45),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          ),
          Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: secondrybutton(
                title: "Bewerben oder Schnuppern",
                onpressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) =>
                            emailform(companydata.email, companydata.image),
                      ));
                },
              ))
        ],
      ),
    );
  }
}
