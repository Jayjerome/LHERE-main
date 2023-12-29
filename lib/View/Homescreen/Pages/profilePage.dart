import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lhere/View/Authentication/Sigin/signin.dart';
import 'package:lhere/View/Homescreen/Pages/editProfile.dart';
import 'package:lhere/Widgets/secondrybutton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Constants/constants.dart';
class profilescren extends StatefulWidget {
  const profilescren({Key? key}) : super(key: key);

  @override
  _profilescrenState createState() => _profilescrenState();
}

class _profilescrenState extends State<profilescren> {
  // var db=FirebaseFirestore.instance;
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  var name="";

  var city="";
  var address="";
  var email="";
  var points="";
  var skill="";
  String title="";
  Future<void> getuserdata()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myname=await prefs.getString("name").toString()?? "";
    String myemail=await prefs.getString("email").toString()?? "";
    String mypoint=await prefs.getString("points").toString()?? "";
    String myskill=await prefs.getString("skill").toString()?? "";
    String mycity=await prefs.getString("city").toString()?? "";
    log(city);
    setState(() {
     name=myname;
     email=myemail;
     city=mycity;
     points=mypoint;
     skill=myskill;

    });


  }

  @override
  void initState() {
getuserdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var wsize=MediaQuery.of(context).size.width;
    var hsize=MediaQuery.of(context).size.height;
    return Scaffold(

      body: SingleChildScrollView(

        child: Column(
          children: [

            Container(
              width:wsize,
              color:primarycolor,
              child:Padding(
                padding: const EdgeInsets.only(top:60,left:16,right:16,bottom:20),
                child: Stack(

                  clipBehavior: Clip.none, children: [

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Mein Profil",style:GoogleFonts.alata(color:Colors.white,fontWeight:FontWeight.bold,fontSize: MediaQuery.of(context).size.height*0.035),),
                            IconButton(onPressed:(){
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(builder: (context) => editProfile(),
                                  ));
                            }, icon:Icon(Icons.edit,color:Colors.white,))
                          ],
                        ),
                        smallgap,smallgap,
                        smallgap,smallgap,
                      ],
                    ),

                    Positioned(
                    top:hsize*0.08,
                      left:wsize*0.3,


                      child: CircleAvatar(
                        backgroundImage:AssetImage("assets/avatar.png",),
                        backgroundColor:Colors.white,
                        radius: 60,
                      ),
                    ),

                  ],
                ),
              ),
            ),

            SizedBox(height:hsize*0.1,),
            Text(
              "$name",
              style: TextStyle(
                fontSize: 18,

                fontWeight: FontWeight.bold,
              ), ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(height:10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          "Punkte verdient",
                          style: TextStyle(
                            fontSize: 15,


                          ), ),
                        Text(
                          "$points",
                          style: TextStyle(
                            fontSize: 15,


                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width:double.infinity,
                    height:1,
                    color:Colors.black12,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 15,


                          ), ),
                        Text(
                          "$email",
                          style: TextStyle(
                            fontSize: 15,


                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    width:double.infinity,
                    height:1,
                    color:Colors.black12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          "Interesse",
                          style: TextStyle(
                            fontSize: 15,


                          ), ),
                        Text(
                          "$skill",
                          style: TextStyle(
                            fontSize: 15,


                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    width:double.infinity,
                    height:1,
                    color:Colors.black12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          "Stadt",
                          style: TextStyle(
                            fontSize: 15,


                          ), ),
                        Text(
                          "$city",
                          style: TextStyle(
                            fontSize: 15,


                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    width:double.infinity,
                    height:1,
                    color:Colors.black12,
                  ),
                ],
              ),
            ),

        Container(
          margin: EdgeInsets.only(top: 10, left: 45, right: 45),

          child: secondrybutton(title:"Logout", onpressed:() async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            auth.signOut();
            prefs.setString("loggedin", "not");

            Navigator.pushAndRemoveUntil<
                dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (
                    BuildContext context) =>
                    login(),
              ),
                  (
                  route) => false, //if you want to disable back feature set to false
            );
          })),
            smallgap,
            InkWell(
                onTap: () async {
                  if (await canLaunchUrl(Uri.parse(
                  'https://lehreyourfuture.com/contactus.html'))) {
                  await launchUrl(Uri.parse(
                  'https://lehreyourfuture.com/contactus.html'));
                  } else {
                  throw 'Could not launch url';
                  }
                },
                child: Text('Fragen? Kontakt', style: TextStyle(
                  color: primarycolor
                ),)),

          ],
        ),
      ),
    );
  }
}