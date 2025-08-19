import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mychoice/view/home_screens/index_screens.dart';
import 'package:mychoice/viewmodel/addingmenspackages/Cartprovider.dart';
import 'package:mychoice/viewmodel/location_view/location_provider.dart';
import 'package:mychoice/viewmodel/timesehedules/timesehdule_view_provider.dart';
import 'package:mychoice/viewmodel/bookingscreenmodels/bookingscreen_provider.dart';
import 'package:provider/provider.dart';
import 'package:mychoice/res/constants/colors.dart';

class Confirmbookingscreen extends StatefulWidget {
  const Confirmbookingscreen({super.key});

  @override
  State<Confirmbookingscreen> createState() => _ConfirmbookingscreenState();
}

class _ConfirmbookingscreenState extends State<Confirmbookingscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<TimeScheduleViewProvider, LocationProvider, CartProvider>(
      builder: (context, timeProvider, locationProvider, cartProvider, child) {
        final String? bookedTime = timeProvider.selectedTimeSlot;
        final DateTime? bookedDate = timeProvider.selectedDate;
        final address = locationProvider.address;
        final cartItems = cartProvider.cartItems;

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Appcolor.whitecolor,
                  Appcolor.greycolor.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Image.asset(
                        'assets/icons/success.png',
                        height: 130.h,
                        width: 130.w,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Booking Confirmed!',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Appcolor.blackcolor,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Card(
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Appcolor.whitecolor,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Appcolor.greycolor.withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Appointment Details',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Appcolor.blackcolor,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              if (cartItems.isNotEmpty) ...[
                                Row(
                                  children: [
                                    Icon(
                                      Icons.apps_outlined,
                                      color: Appcolor.primarycolor,
                                      size: 20.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Selected Package',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Appcolor.blackcolor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                ...cartItems
                                    .map(
                                      (item) => Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 4.h,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: Appcolor.primarycolor,
                                              size: 20.sp,
                                            ),
                                            SizedBox(width: 8.w),
                                            Expanded(
                                              child: Text(
                                                item['title'],
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Appcolor.blackcolor,
                                                ),
                                              ),
                                            ),
                                            // Text(
                                            //   '₹${item['price']}',
                                            //   style: TextStyle(
                                            //     fontSize: 16.sp,
                                            //     fontWeight: FontWeight.w500,
                                            //     color: Appcolor.blackcolor,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ] else ...[
                                Text(
                                  'No package selected',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Appcolor.blackcolor,
                                  ),
                                ),
                              ],
                              SizedBox(height: 12.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Appcolor.primarycolor,
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    bookedDate != null && bookedTime != null
                                        ? '${DateFormat('MMM d, yyyy').format(bookedDate)} at $bookedTime'
                                        : 'No booking details available',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Appcolor.blackcolor,
                                    ),
                                  ),
                                ],
                              ),
                              if (address != null) ...[
                                SizedBox(height: 12.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Appcolor.primarycolor,
                                      size: 20.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Text(
                                        address,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Appcolor.blackcolor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              SizedBox(height: 12.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Appcolor.blackcolor,
                                    ),
                                  ),
                                  Text(
                                    '₹${cartProvider.total}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Appcolor.blackcolor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'We’ve sent a confirmation to your email. Our team will reach out soon with further details.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Appcolor.blackcolor,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<BookingProvider>(
                            context,
                            listen: false,
                          ).addBooking(
                            cartProvider: cartProvider,
                            timeProvider: timeProvider,
                            locationProvider: locationProvider,
                          );
                          cartProvider.initializeCart();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => IndexScreens(
                                    pageController: PageController(
                                      initialPage: 1,
                                    ),
                                  ),
                            ),
                            (Route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolor.primarycolor,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 8.0,
                        ),
                        child: Text(
                          'Back to Home',
                          style: TextStyle(
                            color: Appcolor.whitecolor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
