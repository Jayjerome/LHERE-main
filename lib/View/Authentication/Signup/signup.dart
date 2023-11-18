// import 'package:geocoding/geocoding.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lhere/Controller/signupController.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../Constants/constants.dart';
import '../../../Widgets/circularbar.dart';
import '../../../Widgets/primarybutton.dart';
import '../../../Widgets/secondrybutton.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  final _auth = FirebaseAuth.instance;
  signupController signup = signupController();
  String password = "";
  String confirmpassword = "";
  String fullname = "";
  TextEditingController cityController = TextEditingController();
  String city = "";
  bool emailok = false;
  String email = "";
  bool showSpinner = false;
  var currentLocation;
  var lat = 0.0, long = 0.0;
  Map<String, dynamic> address = {};
  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

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
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator: const Center(child: circlularbar()),
          child: SingleChildScrollView(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            "Konto erstellen",
                            style: primarytext,
                          ),
                          const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ],
                      )),
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
                  // smallgap,
                  // DropdownButtonFormField2(
                  //   decoration: const InputDecoration(
                  //     isDense: true,
                  //     fillColor: Colors.white,
                  //     filled: true,
                  //     suffixIcon: Icon(
                  //         Icons.keyboard_arrow_down_sharp
                  //     ),
                  //     contentPadding: EdgeInsets.zero,
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(15)),
                  //       borderSide: BorderSide(width: 1, color: Colors.grey),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(15)),
                  //       borderSide: BorderSide(width: 1, color: Colors.grey),
                  //     ),
                  //   ),
                  //   hint: Text('City'),
                  //   isExpanded: true,
                  //   icon: const Icon(
                  //     Icons.location_on,
                  //     color: Colors.white,
                  //   ),
                  //   iconSize: 30,
                  //   buttonHeight: 60,
                  //   buttonPadding: const EdgeInsets.only(right: 10),
                  //   dropdownDecoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: Colors.white),
                  //   items: [
                  //     "Vienna",
                  //     "Graz",
                  //     "Linz",
                  //     "Salzburg",
                  //     "Innsbruck",
                  //     "Villach"
                  //   ]
                  //       .map((item) => DropdownMenuItem<String>(
                  //     value: item,
                  //     child: Text(
                  //         item),
                  //   ))
                  //       .toList(),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       city = value.toString();
                  //     });
                  //   },
                  // ),
                  smallgap,
                  Container(
                    child: TextField(
                      onChanged: (v) {
                        email = v;
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
                          prefixIcon: const Icon(Icons.lock),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          hintText: "Passwort",
                          fillColor: Colors.white),
                    ),
                  ),
                  smallgap,
                  Container(
                    child: TextField(
                      onChanged: (v) {
                        confirmpassword = v;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          hintText: "Passwort wiederholen",
                          fillColor: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  smallgap,
                  primarybutton(
                    title: "Konto erstellen",
                    onpressed: () {
                      emailok = isEmail(email);
                      register();
                    },
                  ),
                  smallgap,
                  secondrybutton(
                      title: " Konto bereits vorhanden",
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

  Future<void> register() async {
    if (fullname != "" &&
        password != "" &&
        password == confirmpassword &&
        city != "" &&
        emailok &&
        email != "") {
      setState(() {
        showSpinner = true;
      });
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) =>
        {
          print("object"),
          signup.addsignup(
              fullname,
              city,
              email,
              password,
              context,
              lat.toString(),
              long.toString())
        })
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
          setState(() {
            showSpinner = false;
          });
        });
      } catch (exception) {
        print(exception);
      }
    }else {
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
}

savetodatabase() {}

