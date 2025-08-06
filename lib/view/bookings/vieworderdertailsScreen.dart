// lib/screens/vieworderdertailsscreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/data/models/bookingmodel.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/custombuttons.dart';
import 'package:shimmer/shimmer.dart';

class Vieworderdertailsscreen extends StatefulWidget {
  final Booking booking;

  const Vieworderdertailsscreen({super.key, required this.booking});

  @override
  State<Vieworderdertailsscreen> createState() => _VieworderdertailsscreenState();
}

class _VieworderdertailsscreenState extends State<Vieworderdertailsscreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading (replace with actual data processing if needed)
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.r)),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 60.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 20.h,
                                      width: 100.w,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 4.h),
                                    Container(
                                      height: 15.h,
                                      width: 120.w,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 30.h,
                                  width: 50.w,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  height: 15.h,
                                  width: 200.w,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 20.h,
                                  width: 100.w,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  height: 15.h,
                                  width: 200.w,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  height: 15.h,
                                  width: 200.w,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  height: 15.h,
                                  width: 200.w,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 20.h,
                                  width: 100.w,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  height: 15.h,
                                  width: 200.w,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  height: 15.h,
                                  width: 200.w,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  height: 15.h,
                                  width: 200.w,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  height: 15.h,
                                  width: 200.w,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 20.h,
                                  width: 100.w,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  height: 15.h,
                                  width: 200.w,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 4.h),
                                Container(
                                  height: 15.h,
                                  width: 200.w,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Container(
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25.r)),
                          image: DecorationImage(
                            image: NetworkImage(widget.booking.imageUrl),
                            fit: BoxFit.fill,
                            colorFilter: ColorFilter.mode(
                              Colors.black26,
                              BlendMode.color,
                            ),
                          ),
                        ),
                      ),
                      AppBar(
                        leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back, size: 24.sp, color: Appcolor.blackcolor),
                        ),
                        centerTitle: true,
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        title: Text(
                          "Order Details",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Appcolor.blackcolor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: buildOrderDetails(),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildOrderDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Appcolor.whitecolor,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage: NetworkImage(widget.booking.providerImageUrl),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.booking.providerName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14.sp),
                      SizedBox(width: 4.w),
                      Text(
                        '${widget.booking.rating.toStringAsFixed(1)} (150+ jobs)',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                widget.booking.otp,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Share this OTP with the provider to start the job.',
                style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order Summary",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
              SizedBox(height: 8.h),
              Text("Service: ${widget.booking.service}", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold)),
              Text(
                "Date & Time: ${widget.booking.dateTime}",
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "Address: ${widget.booking.address}",
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order Timeline",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
              SizedBox(height: 8.h),
              ...widget.booking.timeline.map((item) => buildTimelineItem(item.event, item.time)).toList(),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Amount", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold)),
                  Text(
                    widget.booking.totalAmount,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Payment Mode", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold)),
                  Text(
                    widget.booking.paymentMode,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Appcolor.sucesscolor),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: Text(
                  "Reschedule",
                  style: TextStyle(
                    color: Appcolor.sucesscolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ResumeButton(onPressed: () {}, buttonText: "Cancel"),
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget buildTimelineItem(String event, String time) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              '$event - $time',
              style: TextStyle(fontSize: 13.sp, color: Appcolor.blackcolor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}