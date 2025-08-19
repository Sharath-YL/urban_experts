import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/components/customtextbutton.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/custombuttons.dart';
import 'package:mychoice/utils/routes/routes.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  bool _obscurePass = true;

  @override
  Widget build(BuildContext context) {
    final black = (Appcolor.blackcolor) ?? Colors.black;
    final white = (Appcolor.whitecolor) ?? Colors.white;
    final blue = (Appcolor.primarycolor) ?? const Color(0xFF1677FF);

    return Scaffold(
      backgroundColor: black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(color: Appcolor.blackcolor.withOpacity(0.6)),
          ),

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 30.h, 16.w, 16.h),
                  child: Row(
                    children: [
                      Container(
                        height: 34.r,
                        width: 34.r,
                        decoration: BoxDecoration(
                          color: white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/images/Urban Experts.png",
                            height: 35.h,
                            width: 35.sp,
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      Text(
                        'Urban Experts',
                        style: TextStyle(
                          color: white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          22.verticalSpace,

                          Label('E-mail', black),
                          10.verticalSpace,
                          TextFormField(
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            decoration: inputDecoration(
                              hint: "abc@gmail.com",

                              suffix: const Icon(
                                Icons.email,
                                size: 18,
                                color: Appcolor.blackcolor,
                              ),
                            ),
                          ),
                          16.verticalSpace,

                          Label('Mobile Number', black),
                          10.verticalSpace,
                          TextField(
                            controller: _phoneCtrl,

                            keyboardType: TextInputType.phone,
                            decoration: inputDecoration(
                              hint: '98762452221',
                              prefix: CountryPrefix(),
                              suffix: const Icon(
                                Icons.phone,
                                color: Appcolor.blackcolor,
                                size: 18,
                              ),
                            ),
                          ),
                          16.verticalSpace,

                          Label('Password', black),
                          10.verticalSpace,
                          TextField(
                            controller: _passCtrl,
                            obscureText: _obscurePass,
                            decoration: inputDecoration(
                              hint: '********',
                              suffix: IconButton(
                                icon: Icon(
                                  _obscurePass
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Appcolor.blackcolor,
                                  size: 18,
                                ),
                                onPressed:
                                    () => setState(
                                      () => _obscurePass = !_obscurePass,
                                    ),
                              ),
                            ),
                          ),
                          24.verticalSpace,

                          ResumeButton(
                            buttonText: "SignUp",
                            onPressed: () {
                              Navigator.pushNamed(context, RouteName.OtpScreen);
                            },
                          ),
                          10.verticalSpace,

                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RouteName.login);
                              },
                              child: Text(
                                'Log in',
                                style: TextStyle(
                                  color: Appcolor.primarycolor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 8.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration inputDecoration({
    String? hint,
    Widget? prefix,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Appcolor.blackcolor),
      prefixIcon: prefix,
      suffixIcon: suffix,
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      filled: true,
      fillColor: const Color(0xFFF5F6F8),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: const Color(0xFFE6E8EB)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: const Color(0xFFCBD2D9)),
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }
}

class Label extends StatelessWidget {
  const Label(this.text, this.color, {super.key});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.sp,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class CountryPrefix extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, right: 6.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '+91',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Appcolor.blackcolor,
            ),
          ),
          6.horizontalSpace,
          const VerticalDivider(width: 1),
        ],
      ),
    );
  }
}
