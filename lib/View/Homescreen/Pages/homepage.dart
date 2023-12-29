import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lhere/Constants/constants.dart';
import 'package:lhere/Controller/getcompaniesController.dart';
import 'package:lhere/View/Homescreen/Pages/Filterscreen.dart';
import 'package:lhere/View/Homescreen/Pages/Jobdetails.dart';
import 'package:lhere/Widgets/boxbutton.dart';
import 'package:lhere/Widgets/primarybutton.dart';
import 'package:lhere/Widgets/secondrybutton.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Model/postModel.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  String title = "";
  String baseUrl = "https://quizzinger.com/lhere/company/images";
  String city = "";
  bool loading = true;
  bool nodata = false;

  getcompaniesController getcompany = getcompaniesController();

  Future<void> getfilterdata(BuildContext context) async {
    final result = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => filterscreen(),
        ));

    if (result['city'] == "" && result['interest'] == "") {
    } else {
      getallfilterposts(result['city'], result['interest'], result['radius'],
          result["latitude"], result["longitude"]);
    }
  }

  Future<void> getuserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String titleget = await prefs.getString("name").toString() ?? "";
    setState(() {
      title = titleget;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getuserdata();
    getallposts();

    super.initState();
  }

  List<postModel> postllist = [];

  getallposts() async {
    postllist.clear();
    var listq = await getcompany.getcompanydata();

    print(listq);
    setState(() {
      postllist = listq;
      log(postllist.length.toString());
      if (postllist.length == 0) {
        loading = false;
        nodata = true;
      } else {
        loading = false;
        nodata = false;
      }
    });
  }

  getallfilterposts(String city, String interest, String radius,
      double latitude, double longitude) async {
    setState(() {
      loading = true;
      nodata = false;
    });
    postllist.clear();
    var listq =
        await getcompany.getfilter(city, interest, radius, latitude, longitude);
    setState(() {
      postllist = listq;
      if (postllist.isEmpty) {
        loading = false;
        nodata = true;
      } else {
        loading = false;
        nodata = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var wsize = MediaQuery.of(context).size.width;
    var hsize = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: primarycolor,
      ),
      child: Scaffold(
        // backgroundColor: primarycolor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: wsize,
                decoration: BoxDecoration(
                  color: primarycolor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 60, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Hallo,",
                                style: GoogleFonts.alata(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.035),
                              ),
                              Text(
                                " $title !",
                                style: GoogleFonts.alata(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.035,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Finde deine Lehrstelle",
                            style: GoogleFonts.alata(
                                color: Colors.white70,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              getfilterdata(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              width: wsize * .88,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Suchfilter'),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Image.asset(
                                      "assets/filter.png",
                                      color: Colors.black,
                                      width: 25,
                                      height: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Entdecke",
                      style: GoogleFonts.alata(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.032),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: MediaQuery.of(context).size.height * 0.022,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  width: wsize,
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  height: hsize * 0.50,
                  child: loading
                      ? nodata == true
                          ? Center(
                              child: SizedBox(
                                  width: 250,
                                  height: 150,
                                  child: Text(
                                    "No Results",
                                    style: TextStyle(color: Colors.black),
                                  )))
                          : Center(
                              child: SizedBox(
                                  width: 250,
                                  height: 150,
                                  child: Image.asset("assets/load.gif")))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: postllist.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              width: wsize * 0.8,
                              decoration: boxdecor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      SizedBox(
                                          width: wsize * 0.8,
                                          height: hsize * 0.24,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(7),
                                                  topRight: Radius.circular(7)),
                                              child: FadeInImage.assetNetwork(
                                                placeholder: "assets/place.png",
                                                image:
                                                    "${postllist[index].image}",
                                                fit: BoxFit.cover,
                                              ))),
                                      Positioned(
                                          bottom: 10,
                                          left: 10,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.red,
                                              ),
                                              Text(
                                                "${postllist[index].city},Austria",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "${postllist[index].title}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10),
                                    child: Text(
                                      "${postllist[index].skill}",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black54),
                                    ),
                                  ),
                                  Spacer(),
                                  boxbutton(
                                      title: "Einzelheiten",
                                      onpressed: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) => jobdetail(
                                                    postllist[index])));
                                      }),
                                ],
                              ),
                            );
                          }))

              // Container(
              //   width: wsize,
              //   margin:EdgeInsets.symmetric(vertical: 0,horizontal:8),
              //   height:hsize*0.5,
              //   child:   FutureBuilder(
              //       future: getcompany.getcompanydata(),
              //       builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
              //         if (asyncSnapshot.data == null) {
              //           return Center(child:  Container(
              //               width: 250,
              //               height:150,
              //               child: Image.asset("assets/load.gif")));
              //         } else {
              //           if(asyncSnapshot.hasError)
              //             {
              //               return Center(child:  Container(
              //                   width: 250,
              //                   height:150,
              //                   child: Image.asset("assets/bored.png")));
              //             }
              //           else{
              //             return  ListView.builder(
              //                 shrinkWrap: true,
              //                 itemCount:asyncSnapshot.data.length,
              //                 scrollDirection:Axis.horizontal,
              //                 itemBuilder: (BuildContext context,int index){
              //                   return Container(
              //                     margin:EdgeInsets.all(10),
              //                     height: hsize*0.5,
              //                     width:wsize*0.8,
              //                     decoration: boxdecor,
              //                     child:Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                       children: [
              //
              //
              //                         Column(
              //
              //                           crossAxisAlignment: CrossAxisAlignment.start,
              //                           children: [
              //                             Stack(
              //                               children: [
              //                                 Container(
              //                                     width:wsize*0.8,
              //                                     height: hsize*0.24,
              //
              //                                     child:ClipRRect(
              //                                         borderRadius:BorderRadius.only(topLeft:Radius.circular(7),topRight:Radius.circular(7)),
              //                                         child:FadeInImage.assetNetwork(
              //                                           placeholder: "assets/place.png",
              //                                           image: "$baseUrl/${asyncSnapshot.data[index].image}",
              //                                           fit: BoxFit.cover,
              //
              //                                         ))
              //                                 ),
              //                                 Positioned(
              //                                     bottom:10,
              //                                     left:10,
              //                                     child: Row(
              //                                       children: [
              //                                         Icon(Icons.location_on,color:Colors.red,),
              //                                         Text("${asyncSnapshot.data[index].city},Austria",style:TextStyle(color:Colors.white),)
              //
              //                                       ],
              //                                     ))
              //                               ],
              //                             ),
              //                             Padding(
              //                               padding: const EdgeInsets.all(10.0),
              //                               child: Text("${asyncSnapshot.data[index].title}",style:TextStyle(fontWeight:FontWeight.bold,fontSize:hsize*0.029),),
              //                             ),
              //                             Padding(
              //                               padding: const EdgeInsets.symmetric(vertical:5.0,horizontal:10),
              //                               child: Text("${asyncSnapshot.data[index].skill}",style:TextStyle(fontSize:hsize*0.028,color:Colors.black54),),
              //                             ),
              //
              //                           ],
              //                         ),
              //                         boxbutton(title: "Details", onpressed: (){
              //
              //
              //                           Navigator.push(
              //                               context,
              //                               new MaterialPageRoute(builder: (context) => jobdetail(asyncSnapshot.data[index])));
              //                         }),
              //
              //
              //
              //                       ],
              //                     ),
              //                   );
              //                 }
              //             );
              //           }
              //
              //         }
              //       }),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
