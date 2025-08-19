import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:flutter/services.dart';
import 'package:mychoice/res/widgets/custombuttons.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/utils/toastmessages.dart';
import 'package:mychoice/view/auth_screens/signupscreen.dart';

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
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(color: Appcolor.blackcolor.withOpacity(0.9)),
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
                          color: Appcolor.whitecolor.withOpacity(0.12),
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
                      SizedBox(width: 10.w),
                      Text(
                        'Urban Experts',
                        style: TextStyle(
                          color: Appcolor.whitecolor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.0.h),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Appcolor.whitecolor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 24.h),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                color: Appcolor.blackcolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'Mobile Number',
                              style: TextStyle(color: Appcolor.blackcolor),
                            ),
                            SizedBox(height: 20.h),
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              decoration: InputDecoration(
                                prefixIcon: CountryPrefix(),
                                hintText: "Enter your phone number",
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Appcolor.blackcolor.withOpacity(0.5),
                                ),
                                suffixIcon: const Icon(
                                  Icons.phone,
                                  color: Appcolor.blackcolor,
                                  size: 18,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Appcolor.blackcolor,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Appcolor.blackcolor,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                labelText: "Mobile Number",
                                labelStyle: TextStyle(
                                  color: Appcolor.blackcolor,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                } else if (value.length != 10) {
                                  return 'Phone number must be 10 digits';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                Checkbox(
                                  focusColor: Appcolor.blackcolor,
                                  side: BorderSide(color: Appcolor.blackcolor),
                                  value: _agreeToTerms,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _agreeToTerms = value ?? false;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    'I agree to the terms and conditions',
                                    style: TextStyle(
                                      color: Appcolor.blackcolor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 35.h),
                            ResumeButton(
                              buttonText: "Continue",
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    _agreeToTerms) {
                                  Navigator.pushNamed(
                                    context,
                                    RouteName.OtpScreen,
                                  );
                                } else if (!_agreeToTerms) {
                                  Utils.flushbarErrorMessage(
                                    "Please Accept the terms & conditions",
                                    context,
                                  );
                                }
                              },
                            ),
                            40.verticalSpace,

                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteName.signupscreen,
                                  );
                                },
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: Appcolor.primarycolor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
}





   // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         SizedBox(height: 35.0.h),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.end,
      //           children: [AppTextButton(text: 'Skip', onTap: () {})],
      //         ),
      //         SizedBox(height: 30.h),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             FadeInLeft(
      //               duration: const Duration(milliseconds: 1200),
      //               animate: true,
      //               child: TweenAnimationBuilder<Color?>(
      //                 duration: const Duration(milliseconds: 1200),
      //                 tween: ColorTween(
      //                   begin: Colors.blueAccent,
      //                   end: Appcolor.blackcolor,
      //                 ),
      //                 builder: (context, color, child) {
      //                   return Text(
      //                     "Urban",
      //                     style: TextStyle(
      //                       fontSize: 36.sp,
      //                       fontWeight: FontWeight.w900,
      //                       color: color,
      //                       letterSpacing: 1.2,
      //                     ),
      //                   );
      //                 },
      //               ),
      //             ),
      //             SizedBox(width: 10.w),
      //             FadeInRight(
      //               duration: const Duration(milliseconds: 1200),
      //               animate: true,
      //               child: TweenAnimationBuilder<Color?>(
      //                 duration: const Duration(milliseconds: 1200),
      //                 tween: ColorTween(
      //                   begin: Colors.redAccent,
      //                   end: Appcolor.blackcolor,
      //                 ),
      //                 builder: (context, color, child) {
      //                   return Text(
      //                     "Experts",
      //                     style: TextStyle(
      //                       fontSize: 36.sp,
      //                       fontWeight: FontWeight.w900,
      //                       color: color,
      //                       letterSpacing: 1.2,
      //                     ),
      //                   );
      //                 },
      //               ),
      //             ),
      //           ],
      //         ),
      //         SizedBox(height: 20.h),
      //         Padding(
      //           padding: EdgeInsets.symmetric(horizontal: 105.w),
      //           child: Text(
      //             "Welcome Back!",
      //             style: TextStyle(
      //               fontSize: 20.sp,
      //               fontWeight: FontWeight.bold,
      //               color: Appcolor.blackcolor,
      //             ),
      //             textAlign: TextAlign.center,
      //           ),
      //         ),
      //         SizedBox(height: 30.h),
      //         Divider(
      //           thickness: 0.6,
      //           color: Appcolor.greycolor.withOpacity(0.4),
      //         ),
      //         Container(
      //           height: 800.h,
      //           width: double.infinity,
      //           decoration: BoxDecoration(
      //             gradient: LinearGradient(
      //               begin: Alignment.topLeft,
      //               end: Alignment.bottomRight,
      //               colors: [
      //                 Appcolor.primarycolor.withOpacity(0.15),
      //                 Appcolor.whitecolor,
      //               ],
      //             ),
      //             borderRadius: const BorderRadius.vertical(
      //               top: Radius.circular(30),
      //             ),
      //             boxShadow: [
      //               BoxShadow(
      //                 color: Appcolor.greycolor.withOpacity(0.2),
      //                 blurRadius: 10,
      //                 offset: const Offset(0, 5),
      //               ),
      //             ],
      //           ),
      //           child: Padding(
      //             padding: EdgeInsets.symmetric(
      //               horizontal: 20.w,
      //               vertical: 30.h,
      //             ),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 SizedBox(height: 20.h),
      //                 FadeInUp(
      //                   duration: const Duration(milliseconds: 800),
      //                   child: Text(
      //                     'Sign In',
      //                     style: TextStyle(
      //                       fontSize: 24.sp,
      //                       fontWeight: FontWeight.bold,
      //                       color: Appcolor.blackcolor,
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(height: 10.h),
      //                 FadeInUp(
      //                   duration: const Duration(milliseconds: 900),
      //                   child: Text(
      //                     'Enter your phone number to receive a verification code',
      //                     style: TextStyle(
      //                       fontSize: 16.sp,
      //                       color: Appcolor.blackcolor,
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(height: 30.h),
      //                 Form(
      //                   key: _formKey,
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       FadeInUp(
      //                         duration: const Duration(milliseconds: 1000),
      //                         child: Text(
      //                           'Phone Number',
      //                           style: TextStyle(
      //                             fontSize: 16.sp,
      //                             fontWeight: FontWeight.w600,
      //                             color: Appcolor.blackcolor,
      //                           ),
      //                         ),
      //                       ),
      //                       SizedBox(height: 10.h),
      //                       FadeInUp(
      //                         duration: const Duration(milliseconds: 1100),
      //                         child: TextFormField(
      //                           controller: _phoneController,
      //                           keyboardType: TextInputType.phone,
      //                           inputFormatters: [
      //                             FilteringTextInputFormatter.digitsOnly,
      //                             LengthLimitingTextInputFormatter(10),
      //                           ],
      //                           decoration: InputDecoration(
      //                             hintText: 'Enter your phone number',
      //                             hintStyle: TextStyle(
      //                               color: Appcolor.blackcolor,
      //                               fontSize: 14.sp,
      //                             ),
      //                             filled: true,
      //                             fillColor: Colors.white,
      //                             border: OutlineInputBorder(
      //                               borderRadius: BorderRadius.circular(15.r),
      //                               borderSide: BorderSide.none,
      //                             ),
      //                             contentPadding: EdgeInsets.symmetric(
      //                               horizontal: 20.w,
      //                               vertical: 18.h,
      //                             ),
      //                             enabledBorder: OutlineInputBorder(
      //                               borderRadius: BorderRadius.circular(15.r),
      //                               borderSide: BorderSide(
      //                                 color: Appcolor.greycolor.withOpacity(
      //                                   0.3,
      //                                 ),
      //                                 width: 1,
      //                               ),
      //                             ),
      //                             focusedBorder: OutlineInputBorder(
      //                               borderRadius: BorderRadius.circular(15.r),
      //                               borderSide: BorderSide(
      //                                 color: Appcolor.primarycolor,
      //                                 width: 2,
      //                               ),
      //                             ),
      //                           ),
      //                           validator: (value) {
      //                             if (value == null || value.isEmpty) {
      //                               return 'Please enter your phone number';
      //                             }
      //                             if (value.length != 10) {
      //                               return 'Phone number must be exactly 10 digits';
      //                             }
      //                             if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      //                               return 'Please enter only digits';
      //                             }
      //                             return null;
      //                           },
      //                         ),
      //                       ),
      //                       SizedBox(height: 20.h),
      //                       FadeInUp(
      //                         duration: const Duration(milliseconds: 1200),
      //                         child: Row(
      //                           children: [
      //                             Checkbox(
      //                               focusColor: Appcolor.primarycolor,
      //                               value: _agreeToTerms,
      //                               onChanged: (value) {
      //                                 setState(() {
      //                                   _agreeToTerms = value ?? false;
      //                                 });
      //                               },
      //                               activeColor: Appcolor.primarycolor,
      //                               side: BorderSide(
      //                                 color: Appcolor.blackcolor,
      //                               ),
      //                               shape: RoundedRectangleBorder(
      //                                 borderRadius: BorderRadius.circular(5.r),
      //                               ),
      //                             ),
      //                             Expanded(
      //                               child: GestureDetector(
      //                                 onTap: () {},
      //                                 child: Text(
      //                                   'I agree to the Terms of Service and Privacy Policy',
      //                                   style: TextStyle(
      //                                     fontSize: 14.sp,
      //                                     color: Appcolor.blackcolor,
      //                                     decoration: TextDecoration.underline,
      //                                   ),
      //                                 ),
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                       SizedBox(height: 30.h),
      //                       FadeInUp(
      //                         duration: const Duration(milliseconds: 1300),
      //                         child: SizedBox(
      //                           width: double.infinity,
      //                           child: ElevatedButton(
      //                             onPressed:
      //                                 _agreeToTerms
      //                                     ? () {
      //                                       if (_formKey.currentState!
      //                                           .validate()) {
      //                                         Navigator.pushNamed(
      //                                           context,
      //                                           RouteName.OtpScreen,
      //                                         );
      //                                       }
      //                                     }
      //                                     : null,
      //                             style: ElevatedButton.styleFrom(
      //                               backgroundColor: Appcolor.primarycolor,
      //                               padding: EdgeInsets.symmetric(
      //                                 vertical: 18.h,
      //                               ),
      //                               shape: RoundedRectangleBorder(
      //                                 borderRadius: BorderRadius.circular(15.r),
      //                               ),
      //                               elevation: 5,
      //                               shadowColor: Appcolor.primarycolor
      //                                   .withOpacity(0.4),
      //                             ),
      //                             child: Text(
      //                               'Login',
      //                               style: TextStyle(
      //                                 fontSize: 18.sp,
      //                                 color: Colors.white,
      //                                 fontWeight: FontWeight.bold,
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                       SizedBox(height: 20.h),
      //                       FadeInUp(
      //                         duration: const Duration(milliseconds: 1400),
      //                         child: Row(
      //                           mainAxisAlignment: MainAxisAlignment.center,
      //                           children: [
      //                             Text(
      //                               'Don\'t have an account? ',
      //                               style: TextStyle(
      //                                 fontSize: 14.sp,
      //                                 color: Appcolor.blackcolor,
      //                               ),
      //                             ),
      //                             GestureDetector(
      //                               onTap: () {},
      //                               child: Text(
      //                                 'Sign Up',
      //                                 style: TextStyle(
      //                                   fontSize: 14.sp,
      //                                   color: Appcolor.primarycolor,
      //                                   fontWeight: FontWeight.bold,
      //                                   decoration: TextDecoration.underline,
      //                                 ),
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
   