import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/custombuttons.dart';
import 'package:mychoice/utils/routes/routes.dart';

class Otpscreen extends StatefulWidget {
  const Otpscreen({super.key});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 34.r,
                          width: 34.r,
                          decoration: BoxDecoration(
                            color: Appcolor.whitecolor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Appcolor.blackcolor,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Text(
                        'Verify',
                        style: TextStyle(
                          color: Appcolor.whitecolor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.h),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Phone Number",
                            style: TextStyle(
                              color: Appcolor.blackcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            "Enter your Phone Number and get otp code from Urban Experts ",
                            style: TextStyle(
                              color: Appcolor.blackcolor.withOpacity(0.7),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.h),
                          OtpTextField(
                            numberOfFields: 4,
                            borderColor: Appcolor.blackcolor,
                            showFieldAsBox: true,
                            focusedBorderColor: Appcolor.blackcolor,
                            onSubmit: (value) {},
                            fieldWidth: 50.w,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                          SizedBox(height: 50.h),
                          ResumeButton(
                            buttonText: "Submit",
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                RouteName.locationscreen, 
                              );
                            },
                          ),
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
