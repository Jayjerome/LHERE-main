import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lhere/Constants/constants.dart';
import 'package:lhere/Utils/styles.dart';

class boxbutton extends StatelessWidget {
  boxbutton({Key? key, @required this.title, @required this.onpressed})
      : super(key: key);
  String? title;
  var onpressed;

  @override
  Widget build(BuildContext context) {
    final styles = TextStyles();
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onpressed,
      child: Container(
        height: 37,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: primarycolor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title.toString(),
          style: styles.bodyLightBold,
        ),
      ),
    );
  }
}
