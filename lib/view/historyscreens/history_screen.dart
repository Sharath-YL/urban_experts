import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
      if (!mounted) return;
      Provider.of<BookingProvider>(context, listen: false).fetchBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text(
          "History",
          style: GoogleFonts.poppins(
            color: Appcolor.blackcolor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Consumer<BookingProvider>(
        builder: (context, bookingProvider, child) {
          final completed =
              bookingProvider.bookings
                  .where((b) => b.status == 'Completed')
                  .toList();

          return Skeletonizer(
            enabled: bookingProvider.isLoading,
            child:
                completed.isEmpty
                    ? Center(
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
                                Icons.history_rounded,
                                size: 40.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "No History Found",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                color: Appcolor.blackcolor,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "Completed bookings will appear here.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.5.sp,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    : ListView.separated(
                      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
                      itemCount: completed.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (context, index) {
                        final booking = completed[index];
                        return _AnimatedStagger(
                          index: index,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteName.viewordersetailsScreen,
                                arguments: booking,
                              );
                            },
                            borderRadius: BorderRadius.circular(14.r),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14.r),
                                border: Border.all(
                                  color: const Color(0xFFECEEF3),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
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
                                        bg: const Color(0xFFEAF7ED),
                                        fg: const Color(0xFF1B5E20),
                                        border: const Color(0xFFCDEAD3),
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
                                            final title =
                                                opt['title']?.toString() ?? '';
                                            final price =
                                                opt['price']?.toString() ?? '';
                                            return _OptionPill(
                                              title: title,
                                              price: price,
                                            );
                                          }).toList(),
                                    ),
                                  ],
                                  SizedBox(height: 10.h),
                                  const Divider(height: 1),
                                  SizedBox(height: 10.h),
                                  Row(
                                    children: [
                                      _IconText(
                                        icon: Icons.event,
                                        text: booking.dateTime,
                                        flex: 1,
                                      ),
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
                                          backgroundImage: NetworkImage(
                                            booking.providerImageUrl,
                                          ),
                                        ),
                                      if (booking.providerImageUrl.isNotEmpty)
                                        SizedBox(width: 10.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                  booking.rating
                                                      .toStringAsFixed(1),
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
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          );
        },
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
