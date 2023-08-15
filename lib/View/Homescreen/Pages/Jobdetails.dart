import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lhere/Controller/getcompaniesController.dart';
import 'package:lhere/Model/companyModel.dart';
import 'package:lhere/Model/postModel.dart';
import 'package:lhere/Utils/styles.dart';
import 'package:lhere/Widgets/primarybutton.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Constants/constants.dart';
import 'email_form.dart';

class JobDetail extends StatefulWidget {
  final postModel data;

  const JobDetail(this.data, {Key? key}) : super(key: key);

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  bool desc = true;
  bool company = false;
  String baseUrl = "https://quizzinger.com/there/company/images";
  comapnyModel companydata = comapnyModel();
  getcompaniesController companyx = getcompaniesController();

  @override
  void initState() {
    super.initState();
    getcompanydata();
  }

  getcompanydata() async {
    companydata =
        await companyx.getucompanydata(widget.data.company_id!, context);
  }

  @override
  Widget build(BuildContext context) {
    var wsize = MediaQuery.of(context).size.width;
    var hsize = MediaQuery.of(context).size.height;
    final styles = TextStyles();
    return Stack(
      children: [
        Scaffold(
          body: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar.large(
                expandedHeight: 270,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 50, bottom: 20),
                  title: Text(
                    "Job Details",
                    style: GoogleFonts.alata(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  background: Stack(
                    children: [
                      Container(
                        height: 320,
                        child: FadeInImage.assetNetwork(
                          width: double.infinity,
                          placeholder: "assets/place.png",
                          image: widget.data.image ?? '',
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: primarycolor,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0, 0.4, 0.72, 1],
                            colors: [
                              Colors.black45,
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black45,
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                leading: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: primarycolor,
                title: Text(
                  "Job Details",
                  style: GoogleFonts.alata(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.035,
                  ),
                ),
              ),
            ],
            body: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).padding.bottom + 100,
              ),
              children: [
                smallgap,
                Text("${widget.data.title}", style: styles.title),
                smallgap,
                Row(
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
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: desc ? primarycolor : Colors.black12),
                          color: desc ? primarycolor : Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        width: wsize * 0.45,
                        child: Center(
                            child: Text(
                          "Description",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
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
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: company ? primarycolor : Colors.black12),
                            color: company ? primarycolor : Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        width: wsize * 0.45,
                        child: Center(
                          child: Text(
                            "Company",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: company ? Colors.white : Colors.black87),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: desc,
                  child: SizedBox(
                    width: wsize * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //about
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 24),
                            Text("About Opportunity", style: styles.title),
                            const SizedBox(height: 12),
                            Text(
                              "${widget.data.description}",
                              style: styles.subtitle1,
                            ),
                          ],
                        ),
                        //salary
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            smallgap,
                            Text(
                              "Salary",
                              style: styles.title,
                            ),
                            const SizedBox(
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
                  ),
                ),
                Visibility(
                  visible: company,
                  child: SizedBox(
                    width: wsize * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //about
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 28,
                            ),
                            Text("Company Name", style: styles.title),
                            const SizedBox(
                              height: 3,
                            ),
                            Text("${companydata.name}",
                                style: styles.subtitle1),
                          ],
                        ),
                        //salary
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            smallgap,
                            Text("About Company", style: styles.title),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              companydata.about.toString(),
                              style: styles.subtitle1,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: Platform.isIOS ? MediaQuery.of(context).padding.bottom : 16,
          left: 16,
          right: 16,
          child: primarybutton(
            title: "Apply for job",
            onpressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EmailForm(companydata.email, companydata.image),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
