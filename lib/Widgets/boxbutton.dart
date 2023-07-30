
import 'package:flutter/material.dart';
import 'package:lhere/Constants/constants.dart';

class boxbutton extends StatelessWidget {
  boxbutton({@required this.title,  @required this.onpressed});
  String? title;
  var onpressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            child: Text(title.toString()),
            onPressed:onpressed,
          style: ElevatedButton.styleFrom(
            primary: primarycolor,
            padding: EdgeInsets.symmetric(vertical: 13),
            onPrimary: Colors.white, //change text color of button
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          // ),
        )));
  }

}
