import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
                hintStyle: GoogleFonts.poppins(
                  color: Appcolor.blackcolor,
                  fontWeight: FontWeight.w500,
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

class ResumeTextfield extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final bool enabled;
  final bool obscureText;
  final int maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? helperText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? margin;

  const ResumeTextfield({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters,
    this.readOnly = false,
    this.enabled = true,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.helperText,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

    return Focus(
      child: Builder(
        builder: (ctx) {
          final isFocused = Focus.of(ctx).hasFocus;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            margin: margin ?? EdgeInsets.only(bottom: 14.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color:
                      isFocused
                          ? Appcolor.blackcolor.withOpacity(0.10)
                          : Appcolor.blackcolor.withOpacity(0.03),
                  blurRadius: isFocused ? 16 : 10,
                  spreadRadius: isFocused ? 1 : 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextFormField(
              controller: controller,
              initialValue: controller == null ? initialValue : null,
              focusNode: focusNode,
              onTap: onTap,
              onChanged: onChanged,
              validator: validator,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              obscureText: obscureText,
              readOnly: readOnly,
              enabled: enabled,
              maxLines: maxLines,
              maxLength: maxLength,
              textInputAction: textInputAction,
              style: textTheme.bodyMedium?.copyWith(
                color: Appcolor.blackcolor,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
              decoration: InputDecoration(
                counterText: '',
                labelText: label,
                hintText: hint,
                filled: true,
                fillColor: Appcolor.whitecolor,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
                labelStyle: textTheme.labelLarge?.copyWith(
                  fontSize: 15,
                  color:
                      isFocused
                          ? Appcolor.blackcolor.withOpacity(0.80)
                          : Appcolor.blackcolor.withOpacity(0.60),
                  fontWeight: FontWeight.w600,
                ),
                hintStyle: textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                  color: Appcolor.blackcolor.withOpacity(0.40),
                ),
                helperText: helperText,
                helperStyle: textTheme.bodySmall?.copyWith(
                  color: Appcolor.blackcolor.withOpacity(0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(
                    color: Appcolor.blackcolor.withOpacity(0.08),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(
                    color: Appcolor.blackcolor.withOpacity(0.20),
                    width: 1.2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(
                    color: Colors.red.withOpacity(0.7),
                    width: 1.2,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(
                    color: Colors.red.withOpacity(0.9),
                    width: 1.2,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
