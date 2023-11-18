import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
  String phoneNumber = "";
  String confirmpassword = "";
  String fullname = "";
  TextEditingController cityController = TextEditingController();
  var lat = 0.0, long = 0.0;
  String city = "";
  String postalCode = "";
  bool emailok = false;
  String email = "";
  bool showSpinner = false;
  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  getLocation() async {
    try {
      var position = await getCurrentPosition();

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      setState(() {
        long = position.longitude;
        lat = position.latitude;
        city = placemarks[0].locality.toString();
        cityController.text = city;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Position> getCurrentPosition() async {
    // Test if location services are enabled.
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            Exception('Location permissions are permanently denied.'));
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error(Exception('Location permissions are denied.'));
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
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
                            "E-Mail an Unternehmen",
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
                        hintText: "Vorname Nachname",
                        fillColor: Colors.white),
                  ),
                  smallgap,
                  TextField(
                    controller: cityController,
                    onChanged: (v) {
                      city = v;
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_city),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        hintText: "Ort",
                        suffixIcon: InkWell(
                            onTap: () {
                              getLocation();
                            },
                            child: const Icon(Icons.gps_fixed)),
                        fillColor: Colors.white),
                  ),
                  smallgap,
                  TextField(
                    onChanged: (v) {
                      postalCode = v;
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.streetview),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        hintText: "Postleitzahl",
                        fillColor: Colors.white),
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
                          hintText: "Deine E-Mail",
                          fillColor: Colors.white),
                    ),
                  ),
                  smallgap,
                  Container(
                    child: TextField(
                      onChanged: (v) {
                        phoneNumber = v;
                      },
                      maxLines:1,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[600]),
                          hintText: "Telefonnummer",
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
        emailok && phoneNumber!="" &&
        email != "") {
      setState(() {
        showSpinner=true;
      });
      getcompaniesController company=getcompaniesController();
      company.sendemail(fullname, email, city, widget.email.toString(), phoneNumber, context);
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
