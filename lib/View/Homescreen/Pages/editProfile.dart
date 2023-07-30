import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lhere/Controller/ediitprofileController.dart';
import 'package:lhere/Controller/signupController.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constants/constants.dart';
import '../../../Widgets/primarybutton.dart';
import '../../../Widgets/secondrybutton.dart';

class editProfile extends StatefulWidget {
  const editProfile({Key? key}) : super(key: key);

  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  final _auth = FirebaseAuth.instance;
  signupController signup = signupController();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController citycontroller=TextEditingController();
  TextEditingController namecontroller=TextEditingController();



  String city = "";
  bool emailok = false;
  String email = "";
  bool showSpinner = false;
  var db=FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> getuserdata()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    namecontroller.text=await prefs.getString("name").toString()?? "";
    emailcontroller.text=await prefs.getString("email").toString()?? "";

    city=await prefs.getString("city").toString()?? "";
    setState(()  {


    });


  }

  @override
  void initState() {
    getuserdata();
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
          child: SingleChildScrollView(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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
                            "Edit Profile",
                            style: primarytext,
                          ),
                          Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ],
                      )),mediumgap,
                  CircleAvatar(
                    backgroundImage:AssetImage("assets/avatar.png",),
                    backgroundColor:Colors.white,
                    radius: 70,
                  ),
                  mediumgap,
                  TextField(
                    controller:namecontroller,
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
                  SizedBox(
                    height: 60,
                    child: DropdownSearch<String>(

                      //mode of dropdown
                        mode: Mode.MENU,

                        //to show search box
                        showSearchBox: true,
                        dropdownSearchDecoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                            )),
                        //list of dropdown items
                        items: [
                          "Vienna",
                          "Graz",
                          "Linz",
                          "Salzburg",
                          "Innsbruck",
                          "Villach"
                        ],
                        onChanged: (v) {
                          setState(() {
                            city = v.toString();
                          });
                        },
                        //show selected item
                        selectedItem: city == "" ? "City" : city),
                  ),
                  smallgap,
                  Container(
                    child: TextField(
                      enabled: false,
                      controller:emailcontroller,

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
                  primarybutton(
                    title: "Update",
                    onpressed: () {
editprofilecontroller edit=editprofilecontroller();
edit.updateuser(namecontroller.text, city, context, emailcontroller.text);

                    },
                  ),
                  smallgap,
                  secondrybutton(
                      title: "Password Change Request",
                      onpressed: () {
                       changepasswordrequest();
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  changepasswordrequest()
  async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontroller.text);
      setState(() {
        showSpinner==false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Password Reset"),
              content: new Text(
                  "You will recieve email soon"),
              actions: <Widget>[
                new TextButton(
                  child: new Text("OK"),
                  onPressed: () {
                  Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    } on FirebaseAuthException catch (e) {
      setState(() {
        showSpinner==false;
      });
      if (e.code == 'user-not-found') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Alert"),
                content: const Text(
                    "No user found for that email"),
                actions: <Widget>[
                  TextButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
    } catch (e) {
      print(e);
      setState(() {
        showSpinner==false;
      });
    }
  }

}
