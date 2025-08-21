import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Bounceable(
      duration: const Duration(microseconds: 1000),
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 320,
        decoration: BoxDecoration(
          color:
              buttonColor ??
              Appcolor.blackcolor.withOpacity(1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.poppins(
              color: Appcolor.whitecolor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
