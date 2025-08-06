import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/constants/colors.dart';



  Widget buildTipsCards() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTipContainer('100'),
          const SizedBox(width: 9),
          _buildTipContainer('200'),
          const SizedBox(width: 9),
          _buildTipContainer('300'),
          const SizedBox(width: 9),
          _buildCustomTipContainer(),
        ],
      ),
    );
  }

  Widget _buildTipContainer(String amount) {
    return Container(
      height: 35.0,
      width: 70.0,
      decoration: BoxDecoration(border: Border.all(color: Appcolor.blackcolor)),
      child: Center(
        child: Text(
          amount,
          style: TextStyle(
            color: Appcolor.blackcolor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTipContainer() {
    return Container(
      height: 35.0,
      width: 70.0,
      decoration: BoxDecoration(border: Border.all(color: Appcolor.blackcolor)),
      child: Center(
        child: TextField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Custom',
            hintStyle: TextStyle(color: Appcolor.blackcolor, fontSize: 14),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 12.0),
          ),
          style: TextStyle(
            color: Appcolor.blackcolor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }