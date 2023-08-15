import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lhere/Controller/getcompaniesController.dart';
import 'package:lhere/Controller/signupController.dart';
import 'package:lhere/Widgets/primarybutton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/constants.dart';
import '../../../Widgets/circularbar.dart';

class EmailForm extends StatefulWidget {
  final String? email;
  final String? image;

  const EmailForm(this.email, this.image, {Key? key}) : super(key: key);

  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _auth = FirebaseAuth.instance;
  signupController signup = signupController();
  String address = "";
  String confirmpassword = "";
  String fullname = "";
  String baseUrl = "https://company.lehreyourfuture.com/images/";

  String city = "";
  bool emailok = false;
  String email = "";
  bool showSpinner = false;
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
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 32,
        centerTitle: false,
        leading: CupertinoButton(
          padding: const EdgeInsets.only(left: 16),
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
          "Email to Company",
          style: GoogleFonts.alata(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator: const Center(child: circlularbar()),
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                children: [
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.8,
                  //   height: MediaQuery.of(context).size.height * 0.24,
                  //   child: ClipRRect(
                  //     borderRadius: const BorderRadius.only(
                  //         topLeft: Radius.circular(7),
                  //         topRight: Radius.circular(7)),
                  //     child: FadeInImage.assetNetwork(
                  //       placeholder: "assets/place.png",
                  //       image: "$baseUrl/${widget.image}",
                  //       fit: BoxFit.cover,
                  //       imageErrorBuilder: (context, error, stackTrace) =>
                  //           Container(
                  //         color: primarycolor,
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                  SizedBox(
                    height: 60,
                    child: DropdownSearch<String>(

                        //mode of dropdown
                        mode: Mode.MENU,

                        //to show search box
                        showSearchBox: true,
                        dropdownSearchDecoration: const InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                            )),
                        //list of dropdown items
                        items: const [
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
                      onChanged: (v) {
                        email = v;
                        emailok = isEmail(email);
                      },
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
                  Container(
                    child: TextField(
                      onChanged: (v) {
                        address = v;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.pin_drop_rounded),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          hintText: "Address",
                          fillColor: Colors.white),
                    ),
                  ),
                  mediumgap,
                  primarybutton(
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
    if (fullname != "" &&
        city != "" &&
        emailok &&
        address != "" &&
        email != "") {
      setState(() {
        showSpinner = true;
      });
      getcompaniesController company = getcompaniesController();
      company.sendemail(
          fullname, email, city, widget.email.toString(), address, context);
    } else {
      setState(() {
        showSpinner = false;
      });
      Fluttertoast.showToast(
          msg: "Please Check Credentials",
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
