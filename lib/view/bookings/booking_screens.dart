import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/bookingwidget.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/viewmodel/bookingscreenmodels/bookingscreen_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookingScreens extends StatefulWidget {
  const BookingScreens({super.key});

  @override
  State<BookingScreens> createState() => _BookingScreensState();
}

class _BookingScreensState extends State<BookingScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingProvider>(context, listen: false).fetchBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BookingProvider>(
        builder: (context, bookingProvider, child) {
          return Skeletonizer(
            enabled: bookingProvider.isLoading,

            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppBar(
                    centerTitle: true,
                    title: Text(
                      "My Bookings",
                      style: TextStyle(
                        color: Appcolor.blackcolor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ...bookingProvider.bookings.map((booking) {
                    return Bookingwidget(
                      title: booking.title,
                      rating: booking.rating,
                      price: booking.price,
                      duration: booking.duration,
                      ontap: () {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushNamed(
                            context,
                            RouteName.viewordersetailsScreen,
                            arguments: booking,
                          );
                        });
                      },
                      imageurl: booking.imageUrl,
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: kToolbarHeight + MediaQuery.of(context).padding.top,
            width: double.infinity,
            color: Colors.white,
            child: Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.white,
              child: Center(
                child: Container(
                  width: 150.w,
                  height: 20.h,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              children: List.generate(3, (index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 120.h,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 18.h,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 6.h),
                                    Container(
                                      width: 150.w,
                                      height: 12.h,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                width: 60.w,
                                height: 24.h,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Center(
                            child: Container(
                              width: 150.w,
                              height: 36.h,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
