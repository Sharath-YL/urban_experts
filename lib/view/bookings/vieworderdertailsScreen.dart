import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/view/bookings/userfeedback_screen.dart';
import 'package:provider/provider.dart';
import 'package:mychoice/data/models/bookingmodel.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/custombuttons.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/view/home_screens/index_screens.dart';
import 'package:mychoice/viewmodel/bookingscreenmodels/bookingscreen_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Vieworderdertailsscreen extends StatefulWidget {
  final Booking booking;

  const Vieworderdertailsscreen({super.key, required this.booking});

  @override
  State<Vieworderdertailsscreen> createState() =>
      _VieworderdertailsscreenState();
}

class _VieworderdertailsscreenState extends State<Vieworderdertailsscreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  List<Map<String, dynamic>> _safeMapList(Object? value) {
    if (value is List) {
      try {
        return value.map((e) {
          if (e is Map) return Map<String, dynamic>.from(e as Map);
          return <String, dynamic>{};
        }).toList();
      } catch (_) {
        return <Map<String, dynamic>>[];
      }
    }
    return <Map<String, dynamic>>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BookingProvider>(
        builder: (context, provider, _) {
          final current = provider.bookings.firstWhere(
            (b) => b.id == widget.booking.id,
            orElse: () => widget.booking,
          );

          return Skeletonizer(
            enabled: _isLoading,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _header(current),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: _buildOrderDetails(context, current),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _header(Booking booking) {
    return Stack(
      children: [
        Container(
          height: 200.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.r)),
            image: DecorationImage(
              image: NetworkImage(  booking.imageurl.isNotEmpty
                  ? booking.imageurl
                  : "https://images.pexels.com/photos/1054777/pexels-photo-1054777.jpeg",),
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(
                Colors.black26,
                BlendMode.color,
              ),
            ),
          ),
        ),
        AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              size: 24.sp,
              color: Appcolor.blackcolor,
            ),
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
    );
  }

  Widget _buildOrderDetails(BuildContext context, Booking booking) {
    final provider = context.read<BookingProvider>();

    final extraItems = _safeMapList((booking as dynamic).extraWork);
    final selectedOptions = _safeMapList((booking as dynamic).selectedOptions);

    final approvedExtraItems =
        (booking.extraWorkApproved == true)
            ? extraItems
            : const <Map<String, dynamic>>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _providerCard(booking),
        SizedBox(height: 16.h),

        if (booking.status == 'Pending') _otpBox(booking.otp),

        SizedBox(height: 16.h),
        _orderSummaryCard(booking, selectedOptions, approvedExtraItems),

        SizedBox(height: 16.h),
        _timelineCard(booking),

        SizedBox(height: 16.h),
        _paymentCard(booking),

        if (extraItems.isNotEmpty && !(booking.extraWorkApproved == true)) ...[
          SizedBox(height: 16.h),
          _additionalWorkCard(
            extraItems,
            onApprove: () => provider.approveExtraWork(booking.id),
            onReject: () => provider.rejectExtraWork(booking.id),
          ),
        ],

        if (booking.extraWorkApproved == true) ...[
          SizedBox(height: 12.h),
          _approvedBadge(),
        ],

        SizedBox(height: 24.h),
        _bottomButtons(context, booking),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _providerCard(Booking booking) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Appcolor.whitecolor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundImage: NetworkImage(
              booking.providerImageUrl.isNotEmpty
                  ? booking.providerImageUrl
                  : "https://randomuser.me/api/portraits/men/32.jpg",
            ),
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.providerName.isNotEmpty
                      ? booking.providerName
                      : "Sharath",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
                SizedBox(height: 4.h),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 14.sp),
                    SizedBox(width: 4.w),
                    Flexible(
                      child: Text(
                        '${booking.rating.toStringAsFixed(1)} (150+ jobs)',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          Flexible(fit: FlexFit.loose, child: _statusChip(booking.status)),
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    Color bg;
    Color fg;

    switch (status) {
      case 'Completed':
        bg = Colors.green.shade50;
        fg = Colors.green.shade800;
        break;
      case 'Active':
        bg = Colors.blue.shade50;
        fg = Colors.blue.shade800;
        break;
      case 'Cancelled':
        bg = Colors.red.shade50;
        fg = Colors.red.shade800;
        break;
      default: // Pending
        bg = Colors.orange.shade50;
        fg = Colors.orange.shade800;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: fg.withOpacity(.25)),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: fg,
          fontWeight: FontWeight.w700,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Widget _otpBox(String otp) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Text(
            otp,
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
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _orderSummaryCard(
    Booking booking,
    List<Map<String, dynamic>> selectedOptions,
    List<Map<String, dynamic>> approvedExtraItems,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Summary :",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          SizedBox(height: 8.h),

          _kv("Service", booking.service),
          _kv("Date & Time", booking.dateTime),
          _kv("Address", booking.address),

          if (selectedOptions.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              "Selected Options",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            ),
            SizedBox(height: 6.h),
            ...selectedOptions.map(
              (o) => Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        (o['title'] ?? '-').toString(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      o['price'] != null ? '₹${o['price']}.00' : '',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          if (approvedExtraItems.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Text(
              "Approved Additional Work : ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
            SizedBox(height: 6.h),
            ...approvedExtraItems.map(
              (e) => Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        (e['title'] ?? '-').toString(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Text(
                    //   e['price'] != null ? '₹${e['price']}.00' : '',
                    //   style: TextStyle(
                    //     fontSize: 13.sp,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _timelineCard(Booking booking) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
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
          ...booking.timeline
              .map((item) => _timelineItem(item.event, item.time))
              .toList(),
        ],
      ),
    );
  }

  Widget _paymentCard(Booking booking) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
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
              Text(
                "Total Amount",
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                booking.totalAmount,
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment Mode",
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                booking.paymentMode,
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _additionalWorkCard(
    List<Map<String, dynamic>> items, {
    required VoidCallback onApprove,
    required VoidCallback onReject,
  }) {
    final total = items.fold<int>(0, (s, e) => s + ((e['price'] as int?) ?? 0));
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Additional Work Proposed",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          SizedBox(height: 8.h),
          ...items.map(
            (e) => Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      (e['title'] ?? '-').toString(),
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '₹${(e['price'] as int?) ?? 0}.00',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Extra Total",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                '₹$total.00',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onReject,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ResumeButton(
                  onPressed: onApprove,
                  buttonText: "Approve",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _approvedBadge() {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 18.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              "Additional work approved & added to total",
              style: TextStyle(
                color: Colors.green.shade900,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomButtons(BuildContext context, Booking booking) {
    // ✅ If order is completed, show "Leave Feedback" instead of Reschedule/Cancel
    if (booking.status == 'Completed') {
      return SizedBox(
        width: double.infinity,
        child: ResumeButton(
          buttonText: "Leave Feedback",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (_) => FeedbackScreen(
                      bookingId: booking.id,
                      service: booking.service,
                      providerName:
                          (booking.providerName.isNotEmpty)
                              ? booking.providerName
                              : "Provider",
                    ),
              ),
            );
          },
        ),
      );
    }

    // 🔁 Default (your existing) buttons for other statuses
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteName.timesechudlescreen);
            },
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
          child: ResumeButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => IndexScreens(
                        pageController: PageController(initialPage: 0),
                      ),
                ),
                (Route<dynamic> route) => false,
              );
            },
            buttonText: "Cancel",
          ),
        ),
      ],
    );
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Text(
        "$k: $v",
        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _timelineItem(String event, String time) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              '$event - $time',
              style: TextStyle(
                fontSize: 13.sp,
                color: Appcolor.blackcolor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
