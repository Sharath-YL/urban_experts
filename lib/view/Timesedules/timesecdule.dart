import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mychoice/res/components/customtextbutton.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/custombottomsheet.dart';
import 'package:mychoice/res/widgets/customsearchbar.dart';
import 'package:mychoice/res/widgets/customButton.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/viewmodel/location_view/location_provider.dart';
import 'package:mychoice/viewmodel/timesehedules/timesehdule_view_provider.dart';
import 'package:mychoice/viewmodel/addingmenspackages/Cartprovider.dart';
import 'package:provider/provider.dart';

class TimesecduleScreen extends StatefulWidget {
  const TimesecduleScreen({super.key});

  @override
  State<TimesecduleScreen> createState() => _TimesecduleScreenState();
}

class _TimesecduleScreenState extends State<TimesecduleScreen> {
  final SearchController _searchController = SearchController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _houseNoController = TextEditingController();

  late final List<DateTime> _dates;

  @override
  void initState() {
    super.initState();

    _dates = List.generate(10, (i) {
      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day).add(Duration(days: i));
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TimeScheduleViewProvider>(
        context,
        listen: false,
      ).fetchScheduleData();
    });
  }

  @override
  void dispose() {
    _houseNoController.dispose();
    _landmarkController.dispose();
    _addressController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<String> _deriveMorningSlots(TimeScheduleViewProvider p) {
    final hasProviderLists =
        (p.morningSlots.isNotEmpty || p.afternoonSlots.isNotEmpty);
    if (hasProviderLists) return p.morningSlots;

    return p.timeSlots
        .map((e) => e.time)
        .where((t) => t.toLowerCase().contains('am'))
        .toList();
  }

  List<String> _deriveAfternoonSlots(TimeScheduleViewProvider p) {
    final hasProviderLists =
        (p.morningSlots.isNotEmpty || p.afternoonSlots.isNotEmpty);
    if (hasProviderLists) return p.afternoonSlots;

    return p.timeSlots
        .map((e) => e.time)
        .where((t) => t.toLowerCase().contains('pm'))
        .toList();
  }

  Map<String, dynamic> _cartSummary(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    List<dynamic> items;
    try {
      items = (cart as dynamic).cartItems as List<dynamic>;
    } catch (_) {
      try {
        items = (cart as dynamic).items as List<dynamic>;
      } catch (_) {
        items = const [];
      }
    }

    int total = 0;
    final lines = <_Line>[];

    for (final it in items) {
      dynamic title;
      dynamic totalPrice;

      if (it is Map) {
        title = it['package']?['title'] ?? it['title'];
        totalPrice = it['totalPrice'] ?? it['price'] ?? 0;
      } else {
        try {
          title = (it as dynamic).package?.title ?? (it as dynamic).title;
        } catch (_) {}
        try {
          totalPrice = (it as dynamic).totalPrice ?? (it as dynamic).price ?? 0;
        } catch (_) {}
      }

      final name = (title?.toString() ?? 'Selected service').trim();
      final amt = int.tryParse('${totalPrice ?? 0}') ?? 0;
      if (amt > 0) {
        total += amt;
      }
      lines.add(_Line(name: name, qty: 1, unit: amt, total: amt));
    }

    return {'total': total, 'lines': lines};
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Consumer<TimeScheduleViewProvider>(
      builder: (context, provider, _) {
        final selectedIndex = _dates.indexWhere(
          (d) =>
              d.year == provider.selectedDate.year &&
              d.month == provider.selectedDate.month &&
              d.day == provider.selectedDate.day,
        );
        final effectiveSelectedIndex = selectedIndex == -1 ? 0 : selectedIndex;

        final summary = _cartSummary(context);
        final int grandTotal = summary['total'] as int? ?? 0;
        final List<_Line> lines = (summary['lines'] as List<_Line>);

        final morning = _deriveMorningSlots(provider);
        final afternoon = _deriveAfternoonSlots(provider);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Appcolor.whitecolor,
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CircleAvatar(
                backgroundColor: Appcolor.greycolor,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Appcolor.blackcolor,
                    size: 16,
                  ),
                ),
              ),
            ),
            title: Text(
              "Book Your Slot",
              style: TextStyle(
                color: Appcolor.blackcolor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "₹${grandTotal.toStringAsFixed(0)}",
                        style: TextStyle(
                          color: Appcolor.blackcolor,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "inc. all taxes",
                        style: TextStyle(
                          color: Appcolor.blackcolor.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 46,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          provider.selectedTimeSlot == null
                              ? Appcolor.greycolor
                              : Appcolor.blackcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                    onPressed:
                        provider.selectedTimeSlot == null
                            ? null
                            : () {
                              openLocationSheet(context, provider);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Booked: ${DateFormat('MMM d, yyyy').format(provider.selectedDate)} at ${provider.selectedTimeSlot}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  backgroundColor: Appcolor.primarycolor,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              );
                            },
                    child: const Text(
                      "Confirm Booking",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (lines.isNotEmpty) ...[
                  // Selected Work (like pest control)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: lines.length,
                    separatorBuilder:
                        (_, __) => Divider(
                          thickness: 1,
                          color: Appcolor.blackcolor.withOpacity(0.15),
                        ),
                    itemBuilder: (context, index) {
                      final l = lines[index];
                      return _SelectedLineTile(
                        name: l.name,
                        qty: l.qty,
                        unit: l.unit,
                        total: l.total,
                      );
                    },
                  ),
                ],

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text(
                    "Appointment",
                    style: TextStyle(
                      color: Appcolor.blackcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

                // Date pills (7 days) like pest control
                SizedBox(
                  height: 92,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: _dates.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, i) {
                      final d = _dates[i];
                      final selected = i == effectiveSelectedIndex;
                      final week = DateFormat('E').format(d);
                      final day = DateFormat('d').format(d);
                      return _DatePill(
                        labelTop: week,
                        labelBottom: day,
                        selected: selected,
                        onTap: () => provider.setSelectedDate(d),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Morning slots
                const _SectionHeader(title: "Morning Slots"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children:
                        morning.map((t) {
                          final isBooked = _isBooked(provider, t);
                          final isSel = provider.selectedTimeSlot == t;
                          return _TimeChip(
                            label: t,
                            disabled: isBooked,
                            selected: isSel,
                            onTap:
                                () =>
                                    isBooked
                                        ? null
                                        : provider.setSelectedTimeSlot(t),
                          );
                        }).toList(),
                  ),
                ),

                // Afternoon slots
                const _SectionHeader(title: "Afternoon"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children:
                        afternoon.map((t) {
                          final isBooked = _isBooked(provider, t);
                          final isSel = provider.selectedTimeSlot == t;
                          return _TimeChip(
                            label: t,
                            disabled: isBooked,
                            selected: isSel,
                            onTap:
                                () =>
                                    isBooked
                                        ? null
                                        : provider.setSelectedTimeSlot(t),
                          );
                        }).toList(),
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _isBooked(TimeScheduleViewProvider provider, String timeLabel) {
    final formattedDate = DateFormat(
      'yyyy-MM-dd',
    ).format(provider.selectedDate);
    return provider.bookedSlots[formattedDate]?.any(
          (slot) => slot.time == timeLabel && slot.isBooked,
        ) ??
        false;
  }

  void openLocationSheet(
    BuildContext context,
    TimeScheduleViewProvider provider,
  ) {
    FlexibleBottomSheets.show(
      context: context,
      initialHeight: 0.5,
      minHeight: 0.0,
      maxHeight: 0.9,
      headerHeight: 56,
      headerBuilder:
          (context, offset) => Container(
            color: Appcolor.primarycolor,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Text(
                    'Set Location',
                    style: TextStyle(
                      color: Appcolor.whitecolor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.white, size: 24),
                ),
              ],
            ),
          ),
      bodyBuilder: (context, offset) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 20.dg, horizontal: 20.sp),
          child: Consumer<LocationProvider>(
            builder: (context, locationprovider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SearchTextField(controller: _searchController),
                  SizedBox(height: 20.sp),
                  // Row(
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {},
                  //       icon: Image.asset(
                  //         "assets/icons/pin.png",
                  //         height: 30,
                  //         width: 30,
                  //       ),
                  //     ),
                  //     SizedBox(width: 5.sp),
                  //     GestureDetector(
                  //       onTap: () async {
                  //         // await locationprovider.getposition(context);
                  //         // if (locationprovider.address != null) {
                  //         //   _addressController.text = locationprovider.address!;
                  //         // }
                  //       },
                  //       child: Text(
                  //         "Use your current location",
                  //         style: TextStyle(
                  //           fontSize: 16.sp,
                  //           fontWeight: FontWeight.bold,
                  //           color: Appcolor.blackcolor,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 20.sp),
                  InputForm(
                    // readonly: true,
                    title: "Address",
                    controller: _addressController,
                  ),
                  SizedBox(height: 16.sp),
                  InputForm(
                    title: "House/FlatNo",
                    controller: _houseNoController,
                  ),
                  SizedBox(height: 16.sp),
                  InputForm(title: "Landmark", controller: _landmarkController),
                  SizedBox(height: 16.sp),
                  Custombutton(
                    buttonText: "continue",
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.mencartscreen);
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _Line {
  final String name;
  final int qty;
  final int unit;
  final int total;
  _Line({
    required this.name,
    required this.qty,
    required this.unit,
    required this.total,
  });
}

// ===== Reusable UI widgets (mirroring Pestcontrol look) =====
class _SelectedLineTile extends StatelessWidget {
  final String name;
  final int qty;
  final int unit;
  final int total;

  const _SelectedLineTile({
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
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(999.r),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.08),
                          ),
                        ),
                        child: Text(
                          'x1', // quantity is 1 for package
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black.withOpacity(0.75),
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(text: '₹$unit'),
                        const TextSpan(text: ' × '),
                        const TextSpan(text: '1'),
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
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                '₹$total',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DatePill extends StatelessWidget {
  final String labelTop;
  final String labelBottom;
  final bool selected;
  final VoidCallback onTap;
  const _DatePill({
    required this.labelTop,
    required this.labelBottom,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color border =
        selected
            ? Appcolor.primarycolor
            : Theme.of(context).primaryColor.withOpacity(0.35);
    final Color fill = selected ? Appcolor.whitecolor : Colors.white;
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
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              labelTop,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: text,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              labelBottom,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Appcolor.blackcolor,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final bool disabled;
  final VoidCallback? onTap;
  const _TimeChip({
    required this.label,
    required this.selected,
    required this.disabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color border =
        disabled
            ? Colors.grey
            : (selected
                ? Appcolor.primarycolor
                : Theme.of(context).primaryColor.withOpacity(0.35));
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
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: text,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
