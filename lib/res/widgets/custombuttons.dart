import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:mychoice/res/constants/colors.dart';

class ResumeButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  final Color? buttonColor; // Optional parameter

  ResumeButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.buttonColor, // Make it optional
  });

  @override
  Widget build(BuildContext context) {
    // Use the provided buttonColor, or default to primary color
    return Bounceable(
      duration: const Duration(microseconds: 1000),
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 320,
        decoration: BoxDecoration(
          color:
              buttonColor ??
              Appcolor.primarycolor.withOpacity(
                1,
              ), // Use buttonColor if provided
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Appcolor.whitecolor,
              fontSize: 16,
              fontFamily: "Montserrat",
            ),
          ),
        ),
      ),
    );
  }
}
