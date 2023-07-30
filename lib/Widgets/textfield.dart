
import 'package:flutter/material.dart';

class primarybutton extends StatelessWidget {
  primarybutton({@required this.title,  @required this.onpressed});
  String? title;
  var onpressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: ElevatedButton(
            child: Text(title.toString()),
            onPressed:onpressed


          // style: ElevatedButton.styleFrom(
          //   primary: Colors.white,
          //   onPrimary: Colors.black, //change text color of button
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(16),
          //   ),
          // ),
        ));
  }

}
