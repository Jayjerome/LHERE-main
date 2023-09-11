
import 'package:flutter/material.dart';

class primarybutton extends StatelessWidget {
  primarybutton({Key? key, @required this.title,  @required this.onpressed}) : super(key: key);
  String? title;
  var onpressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: ElevatedButton(
            onPressed:onpressed,
            child: Text(title.toString())


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
