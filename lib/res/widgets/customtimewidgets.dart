import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/view/cleaning_pestcontrol_screens/pestcontrol_confirmation_screen.dart';

class DatePill extends StatelessWidget {
  final String labelTop;
  final String labelBottom;
  final bool selected;
  final VoidCallback onTap;
  const DatePill({
    required this.labelTop,
    required this.labelBottom,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color border =
        selected ? Appcolor.primarycolor : Theme.of(context).disabledColor;
    final Color fill = selected ? Appcolor.whitecolor : Appcolor.whitecolor;
    final Color text = selected ? Appcolor.blackcolor : Colors.black87;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: border, width: selected ? 1.5 : 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              labelTop,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: text,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              labelBottom,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Appcolor.blackcolor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class TimeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final bool disabled;
  final VoidCallback? onTap;
  const TimeChip({
    required this.label,
    required this.selected,
    this.disabled = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color border =
        disabled
            ? Colors.grey
            : (selected
                ? Appcolor.primarycolor
                : Theme.of(context).disabledColor.withOpacity(0.35));
    final Color fill =
        disabled
            ? Colors.grey.shade300
            : (selected ? Appcolor.whitecolor : Colors.white);
    final Color text =
        disabled
            ? Colors.white70
            : (selected ? Appcolor.blackcolor : Colors.black87);

    return InkWell(
      onTap: disabled ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: border, width: selected ? 1.4 : 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: text,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  final VoidCallback onRetry;
  const ErrorView({required this.onRetry, super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      accentColor: Appcolor.errorcolor,
      icon: Icons.close,
      title: "Oops! Something went\n wrong.",
      subtitle: "Please try again or contact support.",
      buttonText: "Retry!",
      onPressed: onRetry,
    );
  }
} 

class BaseCard extends StatelessWidget {
  final Color accentColor;
  final IconData icon;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;

  const BaseCard({
    required this.accentColor,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  border: Border.all(color: accentColor, width: 3),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accentColor, size: 56),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 180,
            height: 48,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}



class SelectedLineTile extends StatelessWidget {
  final String name;
  final int qty;
  final int unit;
  final int total;

  const SelectedLineTile({
    required this.name,
    required this.qty,
    required this.unit,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey.shade50, Colors.grey.shade100],
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.04),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: const Icon(Icons.cleaning_services_outlined, size: 20),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Tooltip(
                          message: name,
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: Appcolor.blackcolor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // Container(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: 8.w,
                      //     vertical: 4.h,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     color: Colors.black.withOpacity(0.06),
                      //     borderRadius: BorderRadius.circular(999.r),
                      //     border: Border.all(
                      //       color: Colors.black.withOpacity(0.08),
                      //     ),
                      //   ),
                      //   child: Text(
                      //     'x$qty',
                      //     style: GoogleFonts.poppins(
                      //       color: Appcolor.blackcolor,
                      //       fontSize: 12.sp,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                        color: Appcolor.blackcolor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(text: '₹$unit'),
                        const TextSpan(text: ' × '),
                        TextSpan(text: '$qty'),
                        const TextSpan(text: ' = '),
                        TextSpan(
                          text: '₹$total',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                '₹$total',
                style: GoogleFonts.poppins(
                  color: Appcolor.whitecolor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}