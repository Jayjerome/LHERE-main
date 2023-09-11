import 'package:flutter/material.dart';
class circlularbar extends StatelessWidget {
  const circlularbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        height:100,


        child: ClipRRect(
            borderRadius:BorderRadius.circular(75),

            child: Image.asset("assets/load.gif",fit:BoxFit.cover,)));
  }
}
