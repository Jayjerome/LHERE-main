
import 'package:flutter/material.dart';
import 'package:lhere/Constants/constants.dart';

class secondrybutton extends StatelessWidget {
  secondrybutton({Key? key, @required this.title,  @required this.onpressed}) : super(key: key);
  String? title;
  var onpressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration:BoxDecoration(
          border:Border.all(color:primarycolor,width:3),
              borderRadius: BorderRadius.circular(16),
        ),
        child: ElevatedButton(
            onPressed:onpressed,


          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: Colors.white, //change text color of button
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
            child: Text(title.toString()),
        ));
  }

}
