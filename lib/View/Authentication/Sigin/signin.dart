import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lhere/Constants/constants.dart';
import 'package:lhere/View/Authentication/Signup/signup.dart';
import 'package:lhere/View/Authentication/forgotPassword/forgotPassword.dart';
import 'package:lhere/View/Homescreen/Pages/homepage.dart';
import 'package:lhere/View/Homescreen/menu.dart';
import 'package:lhere/View/Profileanaylsis/Introscreen.dart';
import 'package:lhere/View/Profileanaylsis/profiling.dart';
import 'package:lhere/Widgets/primarybutton.dart';
import 'package:lhere/Widgets/secondrybutton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../Controller/signinController.dart';
import '../../../Widgets/circularbar.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final _auth = FirebaseAuth.instance;
  String password = "";
  bool emailok = false;
  String email = "";
  bool showSpinner = false;
  // login function

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  void signIn(String email, String password) async {
    emailok = isEmail(email);
    if (email != "" && password != "" && emailok == true) {
      setState(() {
        showSpinner = true;
      });

      // FirebaseFirestore.instance.collection('Agent').doc(_email);
      UserCredential userCredential;
      try {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        signinController s = signinController();
        String status = await s.getuserdata(email, context);
        if (status == "ok") {
          setState(() {
            showSpinner = false;
          });
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          showSpinner = false;
        });
        if (e.code == 'user-not-found') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text("Alert"),
                  content: new Text("No user found for that email"),
                  actions: <Widget>[
                    new TextButton(
                      child: new Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        } else if (e.code == 'wrong-password') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Alert"),
                  content: const Text("Wrong Password"),
                  actions: <Widget>[
                    new TextButton(
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
      }
    }

    if (email == "" || password == "" || emailok == false) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Alert"),
              content: new Text("Please Enter Values"),
              actions: <Widget>[
                new TextButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
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
          progressIndicator: Center(child: circlularbar()),
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                children: [
                  Center(
                    child: Container(
                        child: Text(
                      "ANMELDUNG",
                      style: primarytext,
                    )),
                  ),
                  Container(
                    width: width * 0.9,
                    height: height * .35,
                    child: Image.asset(
                      'assets/login.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  mediumgap,
                  Container(
                    child: TextField(
                      onChanged: (v) {
                        email = v;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.perm_identity),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[600]),
                          hintText: "Deine Email",
                          fillColor: Colors.white),
                    ),
                  ),
                  smallgap,
                  Container(
                    child: TextField(
                      onChanged: (v) {
                        password = v;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[600]),
                          hintText: "Passwort",
                          fillColor: Colors.white),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => forgotPassword(),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 10),
                        child: Text("Passwort vergessen?", style: secondrytext),
                      ),
                    ),
                  ),
                  smallgap,
                  primarybutton(
                    title: "Anmeldung",
                    onpressed: () {
                      signIn(email, password);
                    },
                  ),
                  smallgap,
                  secondrybutton(
                      title: "Konto erstellen",
                      onpressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => signup(),
                            ));
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
