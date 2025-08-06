import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/components/customtextbutton.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mychoice/view/auth_screens/otpscreen.dart';
import 'package:mychoice/view/locationscreens/location_screen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Appcolor.primarycolor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 35.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppTextButton(
                    text: 'Skip',
                    onTap: () {},
                    // st: TextStyle(
                    //   fontSize: 16.sp,
                    //   color: Appcolor.primarycolor,
                    //   fontWeight: FontWeight.w600,
                    // ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInLeft(
                    duration: const Duration(milliseconds: 1200),
                    animate: true,
                    child: TweenAnimationBuilder<Color?>(
                      duration: const Duration(milliseconds: 1200),
                      tween: ColorTween(
                        begin: Colors.blueAccent,
                        end: Appcolor.blackcolor,
                      ),
                      builder: (context, color, child) {
                        return Text(
                          "Urban",
                          style: TextStyle(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w900,
                            color: color,
                            letterSpacing: 1.2,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  FadeInRight(
                    duration: const Duration(milliseconds: 1200),
                    animate: true,
                    child: TweenAnimationBuilder<Color?>(
                      duration: const Duration(milliseconds: 1200),
                      tween: ColorTween(
                        begin: Colors.redAccent,
                        end: Appcolor.blackcolor,
                      ),
                      builder: (context, color, child) {
                        return Text(
                          "Experts",
                          style: TextStyle(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w900,
                            color: color,
                            letterSpacing: 1.2,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Appcolor.blackcolor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.h),
              Divider(
                thickness: 0.6,
                color: Appcolor.greycolor.withOpacity(0.4),
              ),
              Container(
                height: 800.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Appcolor.primarycolor.withOpacity(0.15),
                      Appcolor.whitecolor,
                    ],
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Appcolor.greycolor.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 30.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      FadeInUp(
                        duration: const Duration(milliseconds: 800),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Appcolor.blackcolor,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      FadeInUp(
                        duration: const Duration(milliseconds: 900),
                        child: Text(
                          'Enter your phone number to receive a verification code',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Appcolor.blackcolor,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeInUp(
                              duration: const Duration(milliseconds: 1000),
                              child: Text(
                                'Phone Number',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Appcolor.blackcolor,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            FadeInUp(
                              duration: const Duration(milliseconds: 1100),
                              child: TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: 'Enter your phone number',
                                  hintStyle: TextStyle(
                                    color: Appcolor.blackcolor,
                                    fontSize: 14.sp,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 18.h,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.r),
                                    borderSide: BorderSide(
                                      color: Appcolor.greycolor.withOpacity(
                                        0.3,
                                      ),
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.r),
                                    borderSide: BorderSide(
                                      color: Appcolor.primarycolor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20.h),
                            FadeInUp(
                              duration: const Duration(milliseconds: 1200),
                              child: Row(
                                children: [
                                  Checkbox(
                                    focusColor: Appcolor.primarycolor,
                                    value: _agreeToTerms,
                                    onChanged: (value) {
                                      setState(() {
                                        _agreeToTerms = value ?? false;
                                      });
                                    },
                                    activeColor: Appcolor.primarycolor,
                                    side: BorderSide(
                                      color: Appcolor.blackcolor,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        'I agree to the Terms of Service and Privacy Policy',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Appcolor.blackcolor,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30.h),
                            FadeInUp(
                              duration: const Duration(milliseconds: 1300),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed:
                                      _agreeToTerms
                                          ? () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                          Otpscreen(),
                                                ),
                                              );
                                            }
                                          }
                                          : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Appcolor.primarycolor,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 18.h,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    elevation: 5,
                                    shadowColor: Appcolor.primarycolor
                                        .withOpacity(0.4),
                                  ),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            FadeInUp(
                              duration: const Duration(milliseconds: 1400),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don\'t have an account? ',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Appcolor.blackcolor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Appcolor.primarycolor,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
