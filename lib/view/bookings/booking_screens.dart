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
      if (!mounted) return;
      context.read<BookingProvider>().fetchBookings();
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
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'My Bookings',
          style: GoogleFonts.poppins(
            color: Appcolor.blackcolor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<BookingProvider>(
        builder: (context, bookingProvider, child) {
          if (bookingProvider.bookings.length > _lastBookingCount) {
            _selectedSegment.value = 'Pending';
            _lastBookingCount = bookingProvider.bookings.length;
          }

          return Skeletonizer(
            enabled: bookingProvider.isLoading,
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: AdvancedSegment(
                        animationDuration: const Duration(milliseconds: 220),
                        controller: _selectedSegment,
                        itemPadding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 16.w,
                        ),
                        segments: const {
                          'Pending': 'Pending',
                          'Active': 'Active',
                          'Completed': 'Completed',
                          'Cancelled': 'Cancelled',
                        },
                        backgroundColor: Appcolor.primarycolor.withOpacity(
                          0.08,
                        ),
                        sliderColor: Appcolor.primarycolor,
                        borderRadius: BorderRadius.circular(10.r),
                        activeStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        inactiveStyle: GoogleFonts.poppins(
                          color: Appcolor.blackcolor,
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),

                Expanded(
                  child: ValueListenableBuilder<String>(
                    valueListenable: _selectedSegment,
                    builder: (context, value, _) {
                      final filtered =
                          bookingProvider.bookings
                              .where((b) => b.status == value)
                              .toList();

                      if (filtered.isEmpty) {
                        return _EmptyState(status: value);
                      }

                      return ListView.separated(
                        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) => SizedBox(height: 10.h),
                        itemBuilder: (context, index) {
                          final booking = filtered[index];
                          return _AnimatedStagger(
                            index: index,
                            child: _BookingCard(
                              booking: booking,
                              onTap:
                                  () => Navigator.pushNamed(
                                    context,
                                    RouteName.viewordersetailsScreen,
                                    arguments: booking,
                                  ),
                              onCancel:
                                  booking.status == 'Active'
                                      ? () => bookingProvider.cancelBooking(
                                        booking.id,
                                      )
                                      : null,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  const _BookingCard({
    required this.booking,
    required this.onTap,
    this.onCancel,
  });

  final Booking booking;
  final VoidCallback onTap;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final statusMeta = _statusMeta(booking.status);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFECEEF3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '#${booking.id}',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: Appcolor.blackcolor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _StatusChip(
                  text: booking.status,
                  bg: statusMeta.bg,
                  fg: statusMeta.fg,
                  border: statusMeta.border,
                ),
              ],
            ),
            SizedBox(height: 8.h),

            Text(
              booking.title,
              style: GoogleFonts.poppins(
                fontSize: 16.5.sp,
                fontWeight: FontWeight.w700,
                height: 1.2,
                color: Appcolor.blackcolor,
              ),
            ),

            if (booking.selectedOptions.isNotEmpty) ...[
              SizedBox(height: 6.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children:
                    booking.selectedOptions.map((opt) {
                      final title = opt['title']?.toString() ?? '';
                      final price = opt['price']?.toString() ?? '';
                      return _OptionPill(title: title, price: price);
                    }).toList(),
              ),
            ],

            SizedBox(height: 10.h),
            const Divider(height: 1),

            SizedBox(height: 10.h),
            Row(
              children: [
                _IconText(icon: Icons.event, text: booking.dateTime, flex: 1),
                SizedBox(width: 8.w),
                _IconText(
                  icon: Icons.payments_rounded,
                  text: '₹ ${booking.price}',
                  isEmphasis: true,
                ),
              ],
            ),
            SizedBox(height: 6.h),
            _IconText(
              icon: Icons.location_on_rounded,
              text: booking.location,
              maxLines: 1,
            ),
            SizedBox(height: 12.h),

            Row(
              children: [
                if (booking.providerImageUrl.isNotEmpty)
                  CircleAvatar(
                    radius: 18.r,
                    backgroundImage: NetworkImage(booking.providerImageUrl),
                  ),
                if (booking.providerImageUrl.isNotEmpty) SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (booking.providerName.isNotEmpty)
                        Text(
                          booking.providerName,
                          style: GoogleFonts.poppins(
                            color: Appcolor.blackcolor,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.5.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: Color(0xFFFFC107),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            booking.rating.toStringAsFixed(1),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.5.sp,
                              color: Appcolor.blackcolor,
                            ),
                          ),
                          Text(
                            ' Ratings',
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (onCancel != null)
                  _FilledActionButton(label: 'Cancel', onPressed: onCancel!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.text,
    required this.bg,
    required this.fg,
    required this.border,
  });

  final String text;
  final Color bg;
  final Color fg;
  final Color border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: border),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }
}

class _OptionPill extends StatelessWidget {
  const _OptionPill({required this.title, required this.price});

  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F5F9),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFE3E8EF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12.5.sp,
              color: Appcolor.blackcolor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            '₹$price',
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  const _IconText({
    required this.icon,
    required this.text,
    this.isEmphasis = false,
    this.maxLines,
    this.flex,
  });

  final IconData icon;
  final String text;
  final bool isEmphasis;
  final int? maxLines;
  final int? flex;

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18.sp, color: Colors.grey[700]),
        SizedBox(width: 6.w),
        Flexible(
          child: Text(
            text,
            maxLines: maxLines,
            overflow:
                maxLines != null ? TextOverflow.ellipsis : TextOverflow.visible,
            style: GoogleFonts.poppins(
              fontSize: isEmphasis ? 14.sp : 12.5.sp,
              fontWeight: isEmphasis ? FontWeight.w700 : FontWeight.w500,
              color: isEmphasis ? Appcolor.blackcolor : Colors.grey[800],
              height: 1.2,
            ),
          ),
        ),
      ],
    );

    if (flex != null) {
      return Expanded(flex: flex!, child: content);
    }
    return content;
  }
}

class _FilledActionButton extends StatelessWidget {
  const _FilledActionButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12.5.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _AnimatedStagger extends StatelessWidget {
  const _AnimatedStagger({required this.index, required this.child});
  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final delayMs = 40 * index;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 380 + delayMs),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 12),
            child: child,
          ),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.status});
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

class _StatusColors {
  const _StatusColors(this.bg, this.fg, this.border);
  final Color bg;
  final Color fg;
  final Color border;
}

_StatusColors _statusMeta(String status) {
  switch (status) {
    case 'Pending':
      return _StatusColors(
        const Color(0xFFFFF4E5),
        const Color(0xFFBF6A01),
        const Color(0xFFFFE0B2),
      );
    case 'Active':
      return _StatusColors(
        const Color(0xFFE7F1FF),
        const Color(0xFF0B57D0),
        const Color(0xFFB3D1FF),
      );
    case 'Completed':
      return _StatusColors(
        const Color(0xFFEAF7ED),
        const Color(0xFF1B5E20),
        const Color(0xFFCDEAD3),
      );
    case 'Cancelled':
    default:
      return _StatusColors(
        const Color(0xFFFDEAEA),
        const Color(0xFF8A1C1C),
        const Color(0xFFF5CACA),
      );
  }
}
