import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocode/geocode.dart';
import 'package:lhere/Controller/ediitprofileController.dart';
import 'package:lhere/Controller/signupController.dart';
import 'package:lhere/Model/map_prediction_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constants/constants.dart';
import '../../../Widgets/primarybutton.dart';
import '../../../Widgets/secondrybutton.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class filterscreen extends StatefulWidget {
  const filterscreen({Key? key}) : super(key: key);

  @override
  _filterscreenState createState() => _filterscreenState();
}

class _filterscreenState extends State<filterscreen> {
  TextEditingController professionEditingController = TextEditingController();
  String interest = "";
  bool emailok = false;
  String email = "";
  bool showSpinner = false;
  double selectedKm = 25;
  double latitude = 0.0;
  double longitude = 0.0;
  TextEditingController _searchController = TextEditingController();
  List<Prediction> _predictions = [];
  GeoCode geoCode = GeoCode();
  var mapApiKey = 'AIzaSyC8DHtH6KQlFbii460Aegpt25GER2Bhshk';

  Future<void> _onSearchChanged(String input) async {
    final autoCompleteUrl =
        Uri.https('maps.googleapis.com', '/maps/api/place/autocomplete/json', {
      'input': input,
      'types': 'establishment|geocode',
      'key': mapApiKey,
      // 'components': 'country:ng'
    });
    final response = await http.get(
      autoCompleteUrl,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      var prediction = PredictionsList.fromJson(json.decode(response.body));
      setState(() {
        _predictions = prediction.predictions!;
      });
    }
  }

  Future<void> _onPlaceSelected(Prediction prediction) async {
    _searchController.text = prediction.description!;
    try {
      Coordinates coordinates = await geoCode.forwardGeocoding(
          address: "${prediction.structuredFormatting!.mainText!} ${prediction.structuredFormatting!.secondaryText}");
      setState(() {
        latitude = coordinates.latitude!;
        longitude = coordinates.longitude!;
        _predictions.clear();
      });
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Alert"),
              content: Text('City not found'),
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
                        "Suchfilter",
                        style: primarytext,
                      ),
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ],
                  )),
                  mediumgap,
                  Text("Entfernung auswählen"),
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
                  smallgap,
                  smallgap,
                  TextField(
                    controller: professionEditingController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        hintText: "Beruf",
                        fillColor: Colors.white),
                  ),
                  mediumgap,
                  TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_city),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        hintText: "Stadt",
                        fillColor: Colors.white),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _predictions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_predictions[index].description!),
                        onTap: () => _onPlaceSelected(_predictions[index]),
                      );
                    },
                  ),
                  // smallgap,
                  // Text("Beruf auswählen"),
                  // smallgap,
                  // SizedBox(
                  //   height: 65,
                  //   child: DropdownSearch<String>(
                  //
                  //       //mode of dropdown
                  //       mode: Mode.MENU,
                  //
                  //       //to show search box
                  //       showSearchBox: true,
                  //       dropdownSearchDecoration: InputDecoration(
                  //           prefixIcon: Icon(Icons.scatter_plot_sharp),
                  //           border: const OutlineInputBorder(
                  //             borderRadius: BorderRadius.all(
                  //               Radius.circular(16.0),
                  //             ),
                  //           )),
                  //       //list of dropdown items
                  //       items: [
                  //         "Technik",
                  //         "Büro",
                  //         "Küche",
                  //       ],
                  //       onChanged: (v) {
                  //         setState(() {
                  //           interest = v.toString();
                  //         });
                  //       },
                  //       //show selected item
                  //       selectedItem: interest == "" ? "Beruf" : interest),
                  // ),
                  smallgap,
                  smallgap,
                  secondrybutton(
                      title: "Lehrstellensuche",
                      onpressed: () {
                        var data = {
                          "city": _searchController.text,
                          "radius": selectedKm.toString(),
                          "interest": professionEditingController.text,
                          "latitude": latitude,
                          "longitude": longitude
                        };
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
