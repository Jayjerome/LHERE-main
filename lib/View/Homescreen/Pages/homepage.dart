import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lhere/Constants/constants.dart';
import 'package:lhere/Controller/getcompaniesController.dart';
import 'package:lhere/Utils/styles.dart';
import 'package:lhere/View/Homescreen/Pages/Filterscreen.dart';
import 'package:lhere/View/Homescreen/Pages/jobdetails.dart';
import 'package:lhere/Widgets/boxbutton.dart';
import 'package:lhere/Widgets/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Model/postModel.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String title = "";
  String baseUrl = "https://quizzinger.com/there/company/images";
  String city = "";
  bool loading = true;
  bool nodata = false;

  getcompaniesController getcompany = getcompaniesController();
  Future<void> getfilterdata(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const filterscreen(),
        ));

    print('result - ${result['city']}');
    if (result['city'] == "" && result['interest'] == "") {
    } else {
      print('else');
      getallfilterposts(result['city'] ?? '', result['interest']);
    }
  }

  Future<void> getuserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String titleget = prefs.getString("name").toString() ?? "";
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

  List<postModel> postlist = [];

  getallposts() async {
    postlist.clear();
    var listq = await getcompany.getcompanydata();

    print(listq);
    setState(() {
      postlist = listq;
      log(postlist.length.toString());
      if (postlist.isEmpty) {
        loading = false;
        nodata = true;
      } else {
        loading = false;
        nodata = false;
      }
    });
  }

  getallfilterposts(String city, String interest) async {
    setState(() {
      loading = true;
      nodata = false;
    });
    postlist.clear();
    var listq = await getcompany.getfilter(city, interest);

    setState(() {
      postlist = listq;
      log(postlist.length.toString());
      if (postlist.isEmpty) {
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
    final styles = TextStyles();
    return Scaffold(
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
                    top: 60, left: 16, right: 16, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Hello,",
                          style: GoogleFonts.alata(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.035),
                        ),
                        Text(
                          " $title !",
                          style: GoogleFonts.alata(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.035,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Find best services here",
                      style: GoogleFonts.alata(
                          color: Colors.white70,
                          fontSize: MediaQuery.of(context).size.height * 0.025),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            SearchScreen.open(context, postlist);
                          },
                          child: Container(
                            width: wsize * 0.8,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Filter"),
                                  Icon(
                                    CupertinoIcons.search,
                                    size: 19,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            getfilterdata(context);
                          },
                          child: Image.asset(
                            "assets/filter.png",
                            color: Colors.white,
                            width: 25,
                            height: 25,
                          ),
                        )
                      ],
                    )
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
                    "Explore",
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
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              height: hsize * 0.50,
              child: loading
                  ? nodata == true
                      ? const Center(
                          child: SizedBox(
                              width: 250,
                              height: 150,
                              child: Text("No Results")))
                      : Center(
                          child: SizedBox(
                              width: 250,
                              height: 150,
                              child: Image.asset("assets/load.gif")))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: postlist.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final post = postlist[index];
                        return CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JobDetail(post)),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              // padding: EdgeInsets.symmetric(horizontal: 8),
                              width: wsize * 0.8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 3,
                                    offset: Offset(2, 5),
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2,
                                    offset: Offset(2, 0),
                                  ), //BoxShadow
                                  //BoxShadow
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: 229,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20)),
                                          child: FadeInImage.assetNetwork(
                                            imageErrorBuilder:
                                                (context, error, stackTrace) =>
                                                    Container(
                                              color: Colors.amber,
                                            ),
                                            placeholder: "assets/place.png",
                                            image: post.image!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        child: Container(
                                          height: 120,
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: [0, 0.6, 1],
                                              colors: [
                                                Colors.transparent,
                                                Colors.black12,
                                                Colors.black45,
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 12,
                                        left: 8,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              "${post.city}, Austria",
                                              style: styles.titleLight,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Text(
                                      "${post.title}",
                                      style: styles.title,
                                      maxLines: 4,
                                    ),
                                  ),
                                  if (title.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Text(
                                        "${post.skill}",
                                        style: styles.subtitle1,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: boxbutton(
                                      title: "Details",
                                      onpressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  JobDetail(post)),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            )

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
    );
  }
}
