
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lhere/Constants/constants.dart';
import 'package:lhere/Widgets/primarybutton.dart';
import 'package:lhere/Widgets/secondrybutton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Sigin/signin.dart';

class forgotPassword extends StatefulWidget {
  const forgotPassword({Key? key}) : super(key: key);

  @override
  _forgotPasswordState createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  final _auth = FirebaseAuth.instance;
  String password = "";
  bool emailok = false;
  String email = "";
  bool showSpinner = false;
  // login function

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

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
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                children: [
                  Center(
                    child: Container(
                        child: Text(
                      "Passwort vergessen",
                      style: primarytext,
                    )),
                  ),
                  SizedBox(
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
                          prefixIcon: const Icon(Icons.perm_identity),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          hintText: "Deine E-Mail",
                          fillColor: Colors.white),
                    ),
                  ),
                  smallgap,
                  primarybutton(
                    title: "Kennwort ändern",
                    onpressed: () async {
                      setState(() {
                        showSpinner == true;
                      });
                      emailok = isEmail(email);
                      if (emailok && email != "") {
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email);
                          setState(() {
                            showSpinner == false;
                          });
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Passwort zurücksetzen"),
                                  content:
                                      const Text("Sie erhalten bald eine E-Mail"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil<dynamic>(
                                          context,
                                          MaterialPageRoute<dynamic>(
                                            builder: (BuildContext context) =>
                                                const login(),
                                          ),
                                          (route) =>
                                              false, //if you want to disable back feature set to false
                                        );
                                      },
                                    ),
                                  ],
                                );
                              });
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            showSpinner == false;
                          });
                          if (e.code == 'user-not-found') {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Alert"),
                                    content: const Text(
                                        "Für diese E-Mail wurde kein Benutzer gefunden"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text("OK"),
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
                            showSpinner == false;
                          });
                        }
                      } else {
                        setState(() {
                          showSpinner == false;
                        });
                        Fluttertoast.showToast(
                            msg:
                                "Geben Sie Ihre E-Mail-Adresse ein oder bestätigen Sie die E-Mail-Adresse",
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
                  smallgap,
                  smallgap,
                  secondrybutton(
                      title: "Anmelden",
                      onpressed: () {
                        Navigator.pop(context);
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
