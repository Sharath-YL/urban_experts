import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // <-- for inputFormatters
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychoice/res/components/customtextbutton.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/custombuttons.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/utils/toastmessages.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();

  bool _obscurePass = true;

  final _emailReg = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$');

  bool _isValidEmail(String v) => _emailReg.hasMatch(v.trim());
  bool _isValidPhone(String v) => v.trim().length == 10;

  // @override
  // void initState() {
  //   super.initState();
  //   // _emailFocus.addListener(() => setState(() {}));
  //   // _phoneFocus.addListener(() => setState(() {}));
  //   // _passFocus.addListener(() => setState(() {}));
  // }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final black = (Appcolor.blackcolor) ?? Colors.black;
    final white = (Appcolor.whitecolor) ?? Colors.white;

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
                        style: GoogleFonts.poppins(
                          color: Appcolor.whitecolor,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500,
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
                            style: GoogleFonts.poppins(
                              color: Appcolor.blackcolor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          22.verticalSpace,

                          ResumeTextfield(
                            label: "Email",
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            prefixIcon: Icon(
                              Icons.email,
                              size: 15,
                              color: Appcolor.blackcolor,
                            ),
                            focusNode: _emailFocus,
                          ),
                          16.verticalSpace,

                          ResumeTextfield(
                            textInputAction: TextInputAction.next,
                            label: "Phone Number",
                            controller: _phoneCtrl,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            keyboardType: TextInputType.phone,
                            prefixIcon: CountryPrefix(),
                            focusNode: _phoneFocus,
                          ),
                          16.verticalSpace,

                          ResumeTextfield(
                            textInputAction: TextInputAction.next,
                            obscureText: _obscurePass,
                            label: "Password",
                            controller: _passCtrl,
                            keyboardType: TextInputType.visiblePassword,
                            prefixIcon: IconButton(
                              onPressed:
                                  () => setState(
                                    () => _obscurePass = !_obscurePass,
                                  ),
                              icon: Icon(
                                _obscurePass
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 18,
                                color: Appcolor.blackcolor,
                              ),
                              tooltip:
                                  _obscurePass
                                      ? 'Show password'
                                      : 'Hide password',
                            ),
                            focusNode: _passFocus,
                          ),

                          24.verticalSpace,

                          ResumeButton(
                            buttonText: "SignUp",
                            onPressed: () {
                              final email = _emailCtrl.text.trim();
                              final phone = _phoneCtrl.text.trim();
                              if (!_isValidPhone(phone)) {
                                Utils.flushbarErrorMessage(
                                  "Please Enter 10 digits of phone Number",
                                  context,
                                );

                                return;
                              }
                              if (!_isValidEmail(email)) {
                                Utils.flushbarErrorMessage(
                                  "Please enter a valid email address",
                                  context,
                                );
                                return;
                              }
                              Navigator.pushNamed(context, RouteName.OtpScreen);
                            },
                          ),
                          20.verticalSpace,

                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, RouteName.login);
                              },
                              child: Container(
                                height: 55.h,
                                width: 368.sp,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Appcolor.blackcolor.withOpacity(0.5),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.poppins(
                                      color: Appcolor.blackcolor,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
            style: GoogleFonts.poppins(
              color: Appcolor.blackcolor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          6.horizontalSpace,
          const VerticalDivider(width: 1),
        ],
      ),
    );
  }
}
