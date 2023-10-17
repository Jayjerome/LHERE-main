import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lhere/Controller/getcompaniesController.dart';
import 'package:lhere/Controller/signupController.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../Constants/constants.dart';
import '../../../Widgets/circularbar.dart';
import '../../../Widgets/secondrybutton.dart';

class emailform extends StatefulWidget {

  String? email;
  String? image;


  emailform(this.email, this.image);

  @override
  _emailformState createState() => _emailformState();
}

class _emailformState extends State<emailform> {
  final _auth = FirebaseAuth.instance;
  signupController signup = signupController();
  String address = "";
  String confirmpassword = "";
  String fullname = "";


  String city = "";
  bool emailok = false;
  String email = "";
  bool showSpinner = false;
  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator:Center(child:  circlularbar()),

          child: SingleChildScrollView(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                children: [
                  Container(
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back)),
                          SizedBox(width:10,),
                          Text(
                            "Email to Company",
                            style: primarytext,
                          ),

                        ],
                      )),
                  smallgap,
                  Container(
                      width:MediaQuery.of(context).size.width*0.8,
                      height:MediaQuery.of(context).size.height*0.24,

                      child:ClipRRect(
                          borderRadius:BorderRadius.only(topLeft:Radius.circular(7),topRight:Radius.circular(7)),
                          child:FadeInImage.assetNetwork(
                            placeholder: "assets/place.png",
                            image: "https://company.lehreyourfuture.com/images/${widget.image}",
                            fit: BoxFit.cover,

                          ))
                  ),
                  mediumgap,
                  TextField(
                    onChanged: (v) {
                      fullname = v;
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.account_circle_sharp),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        hintText: "Full Name",
                        fillColor: Colors.white),
                  ),
                  smallgap,
                  DropdownButtonFormField2(
                    decoration: const InputDecoration(
                      isDense: true,
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: Icon(
                          Icons.keyboard_arrow_down_sharp
                      ),
                      contentPadding: EdgeInsets.zero,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                    ),
                    hint: Text('City'),
                    isExpanded: true,
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(right: 10),
                    dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    items: const [
                      "Vienna",
                      "Graz",
                      "Linz",
                      "Salzburg",
                      "Innsbruck",
                      "Villach"
                    ]
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                          item),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        city = value.toString();
                      });
                    },
                  ),
                  smallgap,
                  Container(
                    child: TextField(
                      onChanged: (v) {
                        email = v;
                        emailok=isEmail(email);
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[600]),
                          hintText: "Your email",
                          fillColor: Colors.white),
                    ),
                  ),
                  smallgap,
                  Container(
                    child: TextField(
                      onChanged: (v) {
                        address = v;
                      },
                      maxLines:1,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.pin_drop_rounded),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[600]),
                          hintText: "Address",
                          fillColor: Colors.white),
                    ),
                  ),


                  smallgap,
                  secondrybutton(
                      title: "Email",
                      onpressed: () {
                       register();
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> register() async {

    if (fullname != ""&&
        city != "" &&
        emailok && address!="" &&
        email != "") {
setState(() {
  showSpinner=true;
});
      getcompaniesController company=getcompaniesController();
      company.sendemail(fullname, email, city, widget.email.toString(), address, context);
    } else {
      setState(() {
        showSpinner=false;
      });
      Fluttertoast.showToast(
          msg: "Please check credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  // savetodatabase() {}
}
