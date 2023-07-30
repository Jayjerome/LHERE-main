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

class filterscreen extends StatefulWidget {
  const filterscreen({Key? key}) : super(key: key);

  @override
  _filterscreenState createState() => _filterscreenState();
}

class _filterscreenState extends State<filterscreen> {
  String city = "";
  String interest = "";
  bool emailok = false;
  String email = "";
  bool showSpinner = false;
  double selectedKm = 0;

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
                          child: Icon(Icons.arrow_back)),
                      Text(
                        "FilterScreen",
                        style: primarytext,
                      ),
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ],
                  )),
                  mediumgap,
                  Text("Select Radius"),
                  mediumgap,
                  Column(
                    children: [
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 10.0,
                          trackShape: const RoundedRectSliderTrackShape(),
                          activeTrackColor: primarycolor,
                          inactiveTrackColor: Colors.black12,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 14.0,
                            pressedElevation: 8.0,
                          ),
                          thumbColor: Colors.black,
                          overlayColor: Colors.black.withOpacity(0.2),
                          overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 32.0),
                          tickMarkShape: const RoundSliderTickMarkShape(),
                          activeTickMarkColor: Colors.black,
                          inactiveTickMarkColor: Colors.white,
                          valueIndicatorShape:
                              const PaddleSliderValueIndicatorShape(),
                          valueIndicatorColor: Colors.black,
                          valueIndicatorTextStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        child: Slider(
                          min: 0.0,
                          max: 250.0,
                          value: selectedKm,
                          divisions: 250,
                          onChanged: (value) {
                            setState(() {
                              selectedKm = value;
                              // _status = 'active (${_value.round()})';
                              // _statusColor = Colors.green;
                            });
                          },
                          onChangeStart: (value) {
                            setState(() {
                              // _status = 'start';
                              // _statusColor = Colors.lightGreen;
                            });
                          },
                          onChangeEnd: (value) {
                            setState(() {
                              // _status = 'end';
                              // _statusColor = Colors.red;
                            });
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$selectedKm ",
                            style: TextStyle(fontSize: 23),
                          ),
                          Text(
                            "Km",
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      )
                    ],
                  ),
                  mediumgap,
                  Text("Select Profession"),
                  smallgap,
                  SizedBox(
                    height: 65,
                    child: DropdownSearch<String>(

                        //mode of dropdown
                        mode: Mode.MENU,

                        //to show search box
                        showSearchBox: true,
                        dropdownSearchDecoration: InputDecoration(
                            prefixIcon: Icon(Icons.scatter_plot_sharp),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                            )),
                        //list of dropdown items
                        items: [
                          "Technology",
                          "Office",
                          "Kitchen",
                        ],
                        onChanged: (v) {
                          setState(() {
                            interest = v.toString();
                          });
                        },
                        //show selected item
                        selectedItem: interest == "" ? "Profession" : interest),
                  ),
                  smallgap,
                  smallgap,
                  secondrybutton(
                      title: "Search",
                      onpressed: () {
                        var data = {"radius": selectedKm, "interest": interest};
                        Navigator.pop(context, data);
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
