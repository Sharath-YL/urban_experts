import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:mychoice/res/constants/colors.dart';

class Custombutton extends StatelessWidget {
  final String buttonText;
  void Function()? onPressed;

  Custombutton({super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      duration: const Duration(microseconds: 1000),
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 320,
        decoration: BoxDecoration(
          color: Appcolor.blackcolor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Appcolor.whitecolor,
              fontSize: 15,
              // fontFamily: "OpenSans",
            ),
          ),
        ),
      ),
    );
  }
}
