import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychoice/data/models/bookingmodel.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/viewmodel/bookingscreenmodels/bookingscreen_provider.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookingScreens extends StatefulWidget {
  const BookingScreens({super.key});

  @override
  State<BookingScreens> createState() => _BookingScreensState();
}

class _BookingScreensState extends State<BookingScreens> {
  final ValueNotifier<String> _selectedSegment = ValueNotifier('Pending');
  int _lastBookingCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingProvider>(context, listen: false).fetchBookings();
    });
  }

  @override
  void dispose() {
    _selectedSegment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'My Bookings',
          style: GoogleFonts.poppins(
            color: Appcolor.blackcolor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<BookingProvider>(
          builder: (context, bookingProvider, child) {
            if (bookingProvider.bookings.length > _lastBookingCount) {
              _selectedSegment.value = 'Pending';
              _lastBookingCount = bookingProvider.bookings.length;
            }
            return Skeletonizer(
              enabled: bookingProvider.isLoading,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 12.h,
                    ),
                    child: AdvancedSegment(
                      animationDuration: Duration(milliseconds: 250),
                      controller: _selectedSegment,
                      itemPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 18,
                      ),
                      segments: const {
                        'Pending': 'Pending',
                        'Active': 'Active',
                        'Completed': 'Completed',
                        'Cancelled': 'Cancelled',
                      },
                      backgroundColor: Appcolor.primarycolor.withOpacity(0.1),
                      activeStyle: GoogleFonts.poppins(
                        color: Appcolor.whitecolor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      inactiveStyle: GoogleFonts.poppins(
                        color: Appcolor.blackcolor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                      sliderColor: Appcolor.primarycolor,
                      sliderOffset: 0,
                    ),
                  ),
                  ValueListenableBuilder<String>(
                    valueListenable: _selectedSegment,
                    builder: (context, value, _) {
                      final filteredBookings =
                          bookingProvider.bookings
                              .where((booking) => booking.status == value)
                              .toList();
                      return _buildBookingList(
                        filteredBookings,
                        value,
                        bookingProvider,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBookingList(
    List<Booking> bookings,
    String status,
    BookingProvider provider,
  ) {
    if (bookings.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 150.h),
          // Image.asset("assets/icons/pending (1).png", height: 100, width: 100),
          // SizedBox(height: 30.h),
          Text(
            "No $status bookings",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteName.viewordersetailsScreen,
              arguments: booking,
            );
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '#${booking.id}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: Appcolor.primarycolor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Appcolor.greycolor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          booking.status,
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color:
                                booking.status == 'Pending'
                                    ? Colors.orange
                                    : booking.status == 'Active'
                                    ? Colors.blue
                                    : booking.status == 'Completed'
                                    ? Colors.green
                                    : Colors.red,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  booking.title,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (booking.selectedOptions.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    'Options:',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Appcolor.blackcolor,
                    ),
                  ),
                  ...booking.selectedOptions.map(
                    (option) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Appcolor.primarycolor,
                            size: 16.sp,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              option['title'],
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                color: Appcolor.blackcolor,
                              ),
                            ),
                          ),
                          Text(
                            '₹${option['price']}',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: Appcolor.blackcolor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        booking.dateTime,
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                    Text(
                      '₹ ${booking.price}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  booking.location,
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8.h),
                Divider(thickness: 1, color: Appcolor.greycolor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (booking.providerName.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Text(
                                booking.providerName,
                                style: GoogleFonts.poppins(
                                  color: Appcolor.blackcolor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          SizedBox(height: 5.h),
                          Text(
                            "⭐${booking.rating.toStringAsFixed(1)} Ratings",
                            style: GoogleFonts.poppins(
                              color: Appcolor.blackcolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (booking.status == 'Active')
                      ElevatedButton(
                        onPressed: () {
                          provider.cancelBooking(booking.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.h,
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                            color: Appcolor.whitecolor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    SizedBox(width: 10.dg),
                    if (booking.providerImageUrl.isNotEmpty)
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(booking.providerImageUrl),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
