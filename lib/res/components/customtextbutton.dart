import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/constants/colors.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final double textsize;
  final double border_radius;
  // final Color buttoncolor;
  const AppTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.border_radius = 6.0,
    this.textsize = 16,
    // this.buttoncolor=Appcolor.primarycolor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 50.h,
        width: 100.dg,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Appcolor.blackcolor, width: 1),
            top: BorderSide(color: Appcolor.blackcolor, width: 1),
            left: BorderSide(color: Appcolor.blackcolor, width: 1),
            right: BorderSide(color: Appcolor.blackcolor, width: 1),
          ),
          // color: buttoncolor,
          borderRadius: BorderRadius.circular(border_radius.r),
        ),
        child: Center(
          child:
              isLoading
                  ? const CircularProgressIndicator(color: Appcolor.whitecolor)
                  : Text(
                    text,
                    style: TextStyle(
                      fontSize: textsize.sp,
                      fontWeight: FontWeight.w600,
                      color: Appcolor.blackcolor,
                    ),
                  ),
        ),
      ),
    );
  }
}

class InputForm extends StatelessWidget {
  const InputForm({
    super.key,
    required this.title,
    this.icon,
    this.keyBoardType,
    this.focusNode,
    this.readonly,
    required this.controller,
  });
  final String title;
  final IconData? icon;
  final TextInputType? keyBoardType;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final bool? readonly;

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    return Focus(
      child: Builder(
        builder: (context) {
          final isFocused = Focus.of(context).hasFocus;
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              boxShadow:
                  isFocused
                      ? [
                        BoxShadow(
                          color: Appcolor.blackcolor.withValues(alpha: 0.5),
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                        ),
                      ]
                      : [
                        BoxShadow(
                          color: Appcolor.blackcolor.withValues(alpha: 0.05),
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                        ),
                      ],
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: TextFormField(
              focusNode: focusNode,
              keyboardType: keyBoardType ?? TextInputType.text,
              controller: controller,
              readOnly: readonly ?? false,
              decoration: InputDecoration(
                prefixIcon:
                    icon != null
                        ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          child: Icon(icon),
                        )
                        : null,
                prefixIconColor: Appcolor.blackcolor,
                hintText: title,
                hintStyle: TextStyle(
                  color: Appcolor.primarycolor,
                  fontWeight: FontWeight.w600,
                ),
                filled: true,
                fillColor: colorscheme.primaryContainer,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  borderSide: BorderSide(
                    color: Appcolor.primaryBrown,
                    width: 1.0,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: 20.w,
                ),
              ),
              style: TextStyle(color: colorscheme.onPrimaryContainer),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Fill-up the form';
                } else {
                  return null;
                }
              },
            ),
          );
        },
      ),
    );
  }
}
