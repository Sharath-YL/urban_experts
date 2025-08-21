import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/utils/routes/routes.dart';

class Onboardingscreen extends StatefulWidget {
  const Onboardingscreen({super.key});

  @override
  State<Onboardingscreen> createState() => _OnboardingscreenState();
}

class _OnboardingscreenState extends State<Onboardingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/rename.jpg', fit: BoxFit.cover),
          ),

          Positioned.fill(
            child: Container(color: Appcolor.blackcolor.withOpacity(0.7)),
          ),

          Positioned(
            bottom: 80,
            left: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/onboarding.png",
                        height: 50,
                        width: 50,
                        color: Appcolor.whitecolor,
                      ),
                      // const SizedBox(width: 2),
                      Text(
                        "Urban Experts",
                        style: GoogleFonts.poppins(
                          color: Appcolor.whitecolor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  "All services on\nyour fingertips.",
                  style: GoogleFonts.poppins(
                    color: Appcolor.whitecolor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 32),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteName.login);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Log In",
                          style: GoogleFonts.poppins(
                            color: Appcolor.whitecolor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteName.signupscreen);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.poppins(
                            color: Appcolor.whitecolor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
