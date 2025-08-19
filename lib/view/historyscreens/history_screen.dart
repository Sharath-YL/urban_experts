import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/viewmodel/bookingscreenmodels/bookingscreen_provider.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingProvider>(context, listen: false).fetchBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const Text(
                "History",
                style: TextStyle(
                  color: Appcolor.blackcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Consumer<BookingProvider>(
              builder: (context, bookingProvider, child) {
                return Skeletonizer(
                  enabled: bookingProvider.isLoading,
                  child: _buildCompletedBookings(bookingProvider),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedBookings(BookingProvider bookingProvider) {
    final completedBookings =
        bookingProvider.bookings
            .where((booking) => booking.status == 'Completed')
            .toList();

    debugPrint(
      'Filtered bookings in History: ${completedBookings.map((b) => b.status).join(', ')}',
    );

    if (completedBookings.isEmpty) {
      return const Center(child: Text('No completed bookings.'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: completedBookings.length,
      itemBuilder: (context, index) {
        final booking = completedBookings[index];
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: Colors.blue,
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
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  booking.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (booking.selectedOptions.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    'Options:',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Appcolor.greycolor,
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
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Appcolor.blackcolor,
                              ),
                            ),
                          ),
                          Text(
                            '₹${option['price']}',
                            style: TextStyle(
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
                        style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                    Text(
                      '₹${booking.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  booking.location,
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                ),
                SizedBox(height: 8.h),
                Divider(thickness: 1, color: Appcolor.greycolor),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (booking.providerName.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Text(
                              booking.providerName,
                              style: TextStyle(
                                color: Appcolor.blackcolor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        SizedBox(height: 5.h),
                        Text(
                          "⭐${booking.rating.toStringAsFixed(1)} Ratings",
                          style: TextStyle(
                            color: Appcolor.blackcolor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
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
