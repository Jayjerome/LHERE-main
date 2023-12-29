import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  signupController signup = signupController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();

  String city = "";
  bool emailok = false;
  String email = "";
  bool showSpinner = false;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> getuserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    namecontroller.text = prefs.getString("name").toString() ?? "";
    emailcontroller.text = prefs.getString("email").toString() ?? "";

    city = prefs.getString("city").toString() ?? "";
    setState(() {});
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
                          child: const Icon(Icons.arrow_back)),
                      Text(
                        "Profil bearbeiten",
                        style: primarytext,
                      ),
                      const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ],
                  )),
                  mediumgap,
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/avatar.png",
                    ),
                    backgroundColor: Colors.white,
                    radius: 70,
                  ),
                  mediumgap,
                  TextField(
                    controller: namecontroller,
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
                      suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
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
                    hint: Text('Stadt'),
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
                              child: Text(item),
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
                      enabled: false,
                      controller: emailcontroller,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          hintText: "Your email",
                          fillColor: Colors.white),
                    ),
                  ),
                  smallgap,
                  primarybutton(
                    title: "Update",
                    onpressed: () {
                      editprofilecontroller edit = editprofilecontroller();
                      edit.updateuser(namecontroller.text, city, context,
                          emailcontroller.text);
                    },
                  ),
                  smallgap,
                  secondrybutton(
                      title: "Passwort ändern Anfrage",
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

  changepasswordrequest() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontroller.text);
      setState(() {
        showSpinner == false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Passwort zurücksetzen"),
              content: const Text("Du erhältst in kürze eine Email"),
              actions: <Widget>[
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
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
                content: const Text("No user found for that email"),
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
  }
}
