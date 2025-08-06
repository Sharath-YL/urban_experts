import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/constants/colors.dart';

BoxDecoration customboxdecoration = BoxDecoration(
  color: Colors.black,
  borderRadius: BorderRadius.circular(10),
  boxShadow: const [
    BoxShadow(
      color: Colors.blue,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Colors.grey,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(0, -0.5),
    ),
    BoxShadow(
      color: Colors.grey,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(-0.5, 0),
    ),
    BoxShadow(
      color: Colors.grey,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(0.5, 0),
    ),
  ],
);

BoxDecoration customboxdecoration2 = BoxDecoration(
  color: Colors.black,
  borderRadius: BorderRadius.circular(10),
  boxShadow: const [
    BoxShadow(
      color: Colors.grey,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(0, 0.5),
    ),
    BoxShadow(
      color: Colors.grey,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(0, -0.5),
    ),
    BoxShadow(
      color: Colors.grey,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(-0.5, 0),
    ),
    BoxShadow(
      color: Colors.grey,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(0.5, 0),
    ),
  ],
);

BoxDecoration customboxdecoration1 = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10),
  boxShadow: const [
    BoxShadow(
      color: Colors.blue,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Colors.grey,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(0, -0.5),
    ),
    BoxShadow(
      color: Colors.grey,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(-0.5, 0),
    ),
    BoxShadow(
      color: Colors.grey,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(0.5, 0),
    ),
  ],
);

TextStyle normaltextstyle = TextStyle(
  color: Colors.white,
  fontSize: 12.sp,
);

TextStyle yellowtextstyle = TextStyle(
  color: Colors.yellow,
  fontSize: 12.sp,
);

TextStyle whiteThickTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 12.sp,
  fontWeight: FontWeight.w700,
);

TextStyle redtextstyle = TextStyle(
  color: const Color(0xFFcf0000),
  fontSize: 12.sp,
);

TextStyle bluetextstyle1 = TextStyle(
  color: const Color(0xFF2fa2f7),
  fontSize: 12.sp,
);

TextStyle mwhiteTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 13.0.sp,
  fontWeight: FontWeight.bold,
);

TextStyle myellowTextStyle = TextStyle(
  color: Colors.yellow,
  fontSize: 13.0.sp,
  fontWeight: FontWeight.bold,
);

TextStyle greyTextStyle = TextStyle(
  color: Colors.white.withOpacity(0.8),
  fontSize: 12.sp,
);

TextStyle normaltextstyle1 = TextStyle(
  color: Colors.black,
  fontSize: 14.sp,
);

TextStyle normalheadingtextstyle = TextStyle(
  color: Colors.black,
  fontSize: 14.sp,
  fontWeight: FontWeight.bold,
);

TextStyle bluetextstyle = TextStyle(
  color: Colors.blue,
  fontSize: 12.sp,
  fontWeight: FontWeight.w600,
);

TextStyle orangetextstyle = TextStyle(
  color: Colors.orange,
  fontSize: 12.sp,
  fontWeight: FontWeight.w600,
);

TextStyle greenTextStyle = TextStyle(
  color: Colors.green,
  fontSize: 12.sp,
  fontWeight: FontWeight.bold,
);

TextStyle normalblueTextSTyle = TextStyle(
  color: Colors.blue,
  fontSize: 12.sp,
  fontWeight: FontWeight.w500,
);

TextStyle bluetextstyleforwalletcoins = TextStyle(
  color: Colors.blue,
  fontSize: 22.sp,
  fontWeight: FontWeight.bold,
);

TextStyle redtextstyleforwalletcoins = TextStyle(
  color: Colors.red,
  fontSize: 22.sp,
  fontWeight: FontWeight.w700,
);

TextStyle bigbluetextstyle = TextStyle(
  color: Colors.blue,
  fontSize: 14.sp,
  fontWeight: FontWeight.bold,
);

TextStyle labettextstyle = const TextStyle();

BoxDecoration selectedboxdecoration = BoxDecoration(
  gradient: const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Colors.blue,
      Colors.black,
    ],
  ),
  borderRadius: BorderRadius.circular(6.0),
);

BoxDecoration orangeboxdecoration = BoxDecoration(
  gradient: const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Colors.orange,
      Colors.black,
    ],
  ),
  borderRadius: BorderRadius.circular(6.0),
);

BoxDecoration normalboxdecoration = BoxDecoration(
  border: Border.all(color: Colors.white, width: 0.5),
  borderRadius: BorderRadius.circular(6.0),
  gradient: const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Colors.black,
      Colors.black,
    ],
  ),
);

BoxDecoration normalboxdecoration1 = BoxDecoration(
  border: Border.all(color: Colors.grey, width: 0.6),
  borderRadius: BorderRadius.circular(6.0),
  gradient: const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Colors.black,
      Colors.black,
    ],
  ),
);

BoxDecoration blueboxdecoration1 = BoxDecoration(
  border: Border.all(color: Appcolor.primarycolor.withOpacity(0.8), width: 0.6),
  borderRadius: BorderRadius.circular(6.0),
  gradient: const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Colors.black,
      Colors.black,
    ],
  ),
);

BoxDecoration whiteboxdecoration = BoxDecoration(
  border: Border.all(color: Colors.black, width: 1),
  gradient: const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Colors.white],
  ),
);

BoxDecoration greenboxdecoration = BoxDecoration(
  gradient: const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Colors.green,
      Colors.black,
    ],
  ),
  border: const Border(),
  borderRadius: BorderRadius.circular(10),
);

BoxDecoration greyBoxDecoration = BoxDecoration(
  gradient: const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 82, 88, 88),
      Color.fromARGB(255, 19, 16, 16),
    ],
  ),
  borderRadius: BorderRadius.circular(12.0),
);

// CustomDropdownDecoration customDropDownDecoration = CustomDropdownDecoration(
//   closedFillColor: Colors.black,
//   closedBorder: Border.all(color: Colors.grey.withOpacity(0.4), width: 0.4),
//   closedSuffixIcon: const Icon(
//     Icons.keyboard_arrow_down,
//     color: Colors.white,
//   ),
//   expandedFillColor: Colors.black,
//   expandedBorder: Border.all(color: Colors.grey.withOpacity(0.4), width: 0.4),
//   expandedSuffixIcon: const Icon(
//     Icons.keyboard_arrow_up,
//     color: Colors.white,
//   ),
//   hintStyle: TextStyle(
//     color: Colors.white,
//     fontSize: 12.sp,
//   ),
//   headerStyle: TextStyle(
//     color: Colors.white,
//     fontSize: 12.sp,
//   ),
//   listItemStyle: TextStyle(
//     color: Colors.white,
//     fontSize: 12.sp,
//   ),
//   listItemDecoration: const ListItemDecoration(
//     selectedColor: Colors.grey,
//     highlightColor: Colors.black,
//     splashColor: Colors.grey,
//   ),
// );

// CustomDropdownDecoration customDropDownDecoration1 = CustomDropdownDecoration(
//   closedFillColor: Colors.black,
//   closedBorder: Border.all(color: Colors.grey.withOpacity(0.8), width: 0.6),
//   closedSuffixIcon: const Icon(
//     Icons.keyboard_arrow_down,
//     color: Colors.white,
//   ),
//   expandedFillColor: Colors.black,
//   expandedBorder: Border.all(color: Colors.grey.withOpacity(0.8), width: 0.6),
//   expandedSuffixIcon: const Icon(
//     Icons.keyboard_arrow_up,
//     color: Colors.white,
//   ),
//   hintStyle: TextStyle(
//     color: Colors.white,
//     fontSize: 12.sp,
//   ),
//   headerStyle: TextStyle(
//     color: Colors.white,
//     fontSize: 12.sp,
//   ),
//   listItemStyle: TextStyle(
//     color: Colors.white,
//     fontSize: 12.sp,
//   ),
//   listItemDecoration: const ListItemDecoration(
//     selectedColor: Colors.grey,
//     highlightColor: Colors.black,
//     splashColor: Colors.grey,
//   ),
// );
