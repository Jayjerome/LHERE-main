import 'package:flutter/material.dart';
import 'package:lhere/Utils/styles.dart';

class primarybutton extends StatelessWidget {
  primarybutton({Key? key, @required this.title, @required this.onpressed})
      : super(key: key);
  String? title;
  var onpressed;

  @override
  Widget build(BuildContext context) {
    final styles = TextStyles();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
          onPressed: onpressed,
          child: Text(
            title.toString(),
            style: styles.bodyBold,
          )

          // style: ElevatedButton.styleFrom(
          //   primary: Colors.white,
          //   onPrimary: Colors.black, //change text color of button
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(16),
          //   ),
          // ),
          ),
    );
  }
}
