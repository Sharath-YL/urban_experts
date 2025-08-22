import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mychoice/data/models/bookingmodel.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/custombuttons.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/view/bookings/userfeedback_screen.dart';
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
        return value.map<Map<String, dynamic>>((e) {
          if (e is Map) return Map<String, dynamic>.from(e);
          return <String, dynamic>{};
        }).toList();
      } catch (_) {}
    }
    return <Map<String, dynamic>>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: Consumer<BookingProvider>(
        builder: (context, provider, _) {
          final current = provider.bookings.firstWhere(
            (b) => b.id == widget.booking.id,
            orElse: () => widget.booking,
          );

          return Skeletonizer(
            enabled: _isLoading,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  titleSpacing: 0,
                  title: Text(
                    "Order Details",
                    style: GoogleFonts.poppins(
                      color: Appcolor.blackcolor,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                    ),
                  ),
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back, color: Appcolor.blackcolor),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _TopHeader(booking: current),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
                        child: _buildBody(context, current),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, Booking booking) {
    final provider = context.read<BookingProvider>();
    final selectedOptions = _safeMapList((booking as dynamic).selectedOptions);
    final extraItems = _safeMapList((booking as dynamic).extraWork);
    final approvedExtraItems =
        (booking.extraWorkApproved == true)
            ? extraItems
            : const <Map<String, dynamic>>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),
        if (booking.status == 'Pending') _OtpCard(otp: booking.otp),
        _OrderSummaryCard(
          booking: booking,
          selectedOptions: selectedOptions,
          approvedExtra: approvedExtraItems,
        ),
        SizedBox(height: 12.h),
        _TimelineCard(booking: booking),
        SizedBox(height: 12.h),
        _PaymentCard(booking: booking),
        if (extraItems.isNotEmpty && booking.extraWorkApproved != true) ...[
          SizedBox(height: 12.h),
          _AdditionalWorkCard(
            items: extraItems,
            onApprove: () => provider.approveExtraWork(booking.id),
            onReject: () => provider.rejectExtraWork(booking.id),
          ),
        ],
        if (booking.extraWorkApproved == true) ...[
          SizedBox(height: 10.h),
          _ApprovedBadge(),
        ],
        SizedBox(height: 20.h),
        _BottomButtons(booking: booking),
      ],
    );
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader({required this.booking});
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final themeBg = const LinearGradient(
      colors: [Appcolor.whitecolor, Color(0xFFFFFFFF)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    return Container(
      decoration: BoxDecoration(gradient: themeBg),
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundImage: NetworkImage(
              booking.imageurl.isNotEmpty
                  ? booking.imageurl
                  : "https://randomuser.me/api/portraits/men/32.jpg",
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Appcolor.blackcolor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.receipt_long_rounded,
                      size: 16.sp,
                      color: Colors.grey[700],
                    ),
                    SizedBox(width: 6.w),
                    Flexible(
                      child: Text(
                        '#${booking.id}',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _StatusChip(status: booking.status),
        ],
      ),
    );
  }
}

class _OtpCard extends StatelessWidget {
  const _OtpCard({required this.otp});
  final String otp;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        children: [
          Text(
            otp,
            style: GoogleFonts.poppins(
              fontSize: 26.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
              color: const Color(0xFF0B57D0),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Share this OTP with the provider to start the job.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 12.5.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderSummaryCard extends StatelessWidget {
  const _OrderSummaryCard({
    required this.booking,
    required this.selectedOptions,
    required this.approvedExtra,
  });

  final Booking booking;
  final List<Map<String, dynamic>> selectedOptions;
  final List<Map<String, dynamic>> approvedExtra;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Order Summary'),
          _KV('Service', booking.service),
          _KV('Date & Time', booking.dateTime),
          _KV('Address', booking.address),
          if (selectedOptions.isNotEmpty) ...[
            SizedBox(height: 10.h),
            _SubTitle('Selected Options'),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children:
                  selectedOptions.map((o) {
                    final title = (o['title'] ?? '-').toString();
                    final price = o['price'] != null ? '₹${o['price']}' : '';
                    return _Pill(title: title, trailing: price);
                  }).toList(),
            ),
          ],
          if (approvedExtra.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _SubTitle('Approved Additional Work'),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children:
                  approvedExtra.map((e) {
                    final title = (e['title'] ?? '-').toString();
                    return _Pill(title: title, kind: PillKind.success);
                  }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({required this.booking});
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Order Timeline'),
          SizedBox(height: 6.h),
          ...booking.timeline.map(
            (item) => _StepTile(title: item.event, time: item.time),
          ),
        ],
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard({required this.booking});
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Payment Details'),
          _RowSpace(
            left: Text('Total Amount', style: _bold13),
            right: Text(booking.totalAmount, style: _semibold13),
          ),
          SizedBox(height: 6.h),
          _RowSpace(
            left: Text('Payment Mode', style: _bold13),
            right: Text(booking.paymentMode, style: _semibold13),
          ),
        ],
      ),
    );
  }
}

class _AdditionalWorkCard extends StatelessWidget {
  const _AdditionalWorkCard({
    required this.items,
    required this.onApprove,
    required this.onReject,
  });

  final List<Map<String, dynamic>> items;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    final total = items.fold<int>(0, (s, e) => s + ((e['price'] as int?) ?? 0));

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Additional Work Proposed'),
          SizedBox(height: 6.h),
          ...items.map((e) {
            final title = (e['title'] ?? '-').toString();
            final price = (e['price'] as int?) ?? 0;
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: _RowSpace(
                left: Text(
                  title,
                  style: _semibold13.copyWith(color: Appcolor.blackcolor),
                ),
                right: Text('₹$price.00', style: _bold13),
              ),
            );
          }),
          const Divider(),
          _RowSpace(
            left: Text('Extra Total', style: _bold14),
            right: Text('₹$total.00', style: _bold14),
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
                    'Cancel',
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ResumeButton(
                  buttonText: 'Approve',
                  onPressed: onApprove,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ApprovedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Appcolor.blackcolor),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              "Additional work approved & added to total",
              style: GoogleFonts.poppins(
                color: Appcolor.blackcolor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomButtons extends StatelessWidget {
  const _BottomButtons({required this.booking});
  final Booking booking;

  @override
  Widget build(BuildContext context) {
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
                          booking.providerName.isNotEmpty
                              ? booking.providerName
                              : "Provider",
                    ),
              ),
            );
          },
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed:
                () =>
                    Navigator.pushNamed(context, RouteName.timesechudlescreen),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              side: BorderSide(color: Appcolor.sucesscolor),
            ),
            child: Text(
              'Reschedule',
              style: GoogleFonts.poppins(
                color: Appcolor.sucesscolor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ResumeButton(
            buttonText: 'Cancel',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => IndexScreens(
                        pageController: PageController(initialPage: 0),
                      ),
                ),
                (route) => false,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFECEEF3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: _bold16);
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: _bold14.copyWith(color: Appcolor.blackcolor));
  }
}

class _KV extends StatelessWidget {
  const _KV(this.k, this.v);
  final String k;
  final String v;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110.w,
            child: Text(k, style: _bold13.copyWith(color: Colors.grey[800])),
          ),
          Expanded(
            child: Text(
              v,
              style: _semibold13.copyWith(color: Appcolor.blackcolor),
            ),
          ),
        ],
      ),
    );
  }
}

enum PillKind { normal, success }

class _Pill extends StatelessWidget {
  const _Pill({
    required this.title,
    this.trailing,
    this.kind = PillKind.normal,
  });
  final String title;
  final String? trailing;
  final PillKind kind;

  @override
  Widget build(BuildContext context) {
    final bg =
        kind == PillKind.success
            ? const Color(0xFFEAF7ED)
            : const Color(0xFFF2F5F9);
    final border =
        kind == PillKind.success
            ? const Color(0xFFCDEAD3)
            : const Color(0xFFE3E8EF);
    final fg =
        kind == PillKind.success
            ? const Color(0xFF1B5E20)
            : Appcolor.blackcolor;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: fg,
              fontSize: 12.5.sp,
            ),
          ),
          if (trailing != null) ...[
            SizedBox(width: 8.w),
            Text(
              trailing!,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
                fontSize: 12.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({required this.title, required this.time});
  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 10.r,
              height: 10.r,
              decoration: BoxDecoration(
                color: Appcolor.blackcolor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Appcolor.primarycolor.withOpacity(.35),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
            Container(width: 2, height: 22.h, color: const Color(0xFFE3E8EF)),
          ],
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: _semibold13.copyWith(color: Appcolor.blackcolor),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    Color bg, fg, border;
    switch (status) {
      case 'Completed':
        bg = const Color(0xFFEAF7ED);
        fg = const Color(0xFF1B5E20);
        border = const Color(0xFFCDEAD3);
        break;
      case 'Active':
        bg = const Color(0xFFE7F1FF);
        fg = const Color(0xFF0B57D0);
        border = const Color(0xFFB3D1FF);
        break;
      case 'Cancelled':
        bg = const Color(0xFFFDEAEA);
        fg = const Color(0xFF8A1C1C);
        border = const Color(0xFFF5CACA);
        break;
      default:
        bg = const Color(0xFFFFF4E5);
        fg = const Color(0xFFBF6A01);
        border = const Color(0xFFFFE0B2);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: border),
      ),
      child: Text(
        status,
        style: GoogleFonts.poppins(
          color: fg,
          fontWeight: FontWeight.w800,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}

final _bold16 = GoogleFonts.poppins(
  fontWeight: FontWeight.w800,
  fontSize: 16.sp,
  color: Appcolor.blackcolor,
);
final _bold14 = GoogleFonts.poppins(
  fontWeight: FontWeight.w800,
  fontSize: 14.sp,
  color: Appcolor.blackcolor,
);
final _bold13 = GoogleFonts.poppins(
  fontWeight: FontWeight.w800,
  fontSize: 13.sp,
  color: Appcolor.blackcolor,
);
final _semibold13 = GoogleFonts.poppins(
  fontWeight: FontWeight.w600,
  fontSize: 13.sp,
  color: Appcolor.blackcolor,
);

class _RowSpace extends StatelessWidget {
  const _RowSpace({required this.left, required this.right});
  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Expanded(child: left), right],
      ),
    );
  }
}
