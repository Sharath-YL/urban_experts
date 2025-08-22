 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychoice/res/constants/colors.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40.h),
            Container(
              height: 88.r,
              width: 88.r,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                Icons.event_busy_rounded,
                size: 40.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "No $status bookings",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
                color: Appcolor.blackcolor,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              "Bookings in this category will appear here.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 12.5.sp,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}