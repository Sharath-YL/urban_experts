import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/viewmodel/theme_view/theme_view_model.dart';
import 'package:provider/provider.dart';


class SearchTextField extends StatelessWidget {
  final TextEditingController
      controller; 
  final Function(String)? onChanged; 

  const SearchTextField({
    Key? key,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeViewModel>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      height: 50.h,
      width: 380.sp,
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: Appcolor.blackcolor,
        ),
      ),
      child: Center(
        child: TextFormField(
          controller: controller,
          cursorWidth: 1.5,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0.8.h),
            border: InputBorder.none,
            icon: Padding(
              padding:  EdgeInsets.only(left: 20.0.sp),
              child: Icon(
                Icons.search,
                color: Appcolor.blackcolor,
                size: 25.sp,
              ),
            ),
            hintText: "Search here",
            hintStyle: TextStyle(
              color: Appcolor.blackcolor,
              fontSize: 17.sp,
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}