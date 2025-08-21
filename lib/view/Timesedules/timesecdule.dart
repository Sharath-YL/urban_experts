import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mychoice/data/models/recentworkmodel.dart';
import 'package:mychoice/res/components/customtextbutton.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/customButton.dart';
import 'package:mychoice/res/widgets/custombuttons.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/viewmodel/homescreenview_model/homescreenview_provider.dart';
import 'package:mychoice/viewmodel/location_view/location_provider.dart';
import 'package:mychoice/viewmodel/timesehedules/timesehdule_view_provider.dart';
import 'package:mychoice/viewmodel/addingmenspackages/Cartprovider.dart';
import 'package:provider/provider.dart';

class TimesecduleScreen extends StatefulWidget {
  final String id;
  const TimesecduleScreen({super.key, required this.id});

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

  int _unitPrice(dynamic p) =>
      p is num ? p.toInt() : int.tryParse(p?.toString() ?? '') ?? 0;

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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));

    return Consumer2<TimeScheduleViewProvider, HomescreenviewProvider>(
      builder: (context, provider, homeprovider, _) {
        Recentworkmodel? item;
        try {
          item = homeprovider.recentworkmodel.firstWhere(
            (e) => e.id == widget.id,
            orElse: () => throw Exception('Item not found'),
          );
        } catch (e) {
          return Scaffold(
            body: Center(
              child: Text(
                'Item not found',
                style: GoogleFonts.poppins(
                  color: Appcolor.blackcolor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }

        final rawOptions = (item as dynamic).selectedoptoins ?? [];

        final List<Map<String, dynamic>> lines =
            (rawOptions as List)
                .map((o) {
                  final id = (o as dynamic).id;
                  final q = ((homeprovider as dynamic).getQty(id) as int?) ?? 0;
                  if (q <= 0) return null;

                  final unit = _unitPrice((o as dynamic).price);
                  final name =
                      ((o as dynamic).placename?.toString() ?? 'Option').trim();

                  return {
                    'name': name,
                    'qty': q,
                    'unit': unit,
                    'total': unit * q,
                  };
                })
                .whereType<Map<String, dynamic>>()
                .toList();

        if (lines.isEmpty) {
          return Scaffold(
            body: Center(
              child: Text(
                'No selected options found',
                style: GoogleFonts.poppins(
                  color: Appcolor.blackcolor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }

        final int grandTotal = lines.fold<int>(
          0,
          (sum, e) => sum + ((e['total'] as num?)?.toInt() ?? 0),
        );

        final selectedIndex = _dates.indexWhere(
          (d) =>
              d.year == provider.selectedDate.year &&
              d.month == provider.selectedDate.month &&
              d.day == provider.selectedDate.day,
        );
        final effectiveSelectedIndex = selectedIndex == -1 ? 0 : selectedIndex;

        // final summary = _cartSummary(context);

        final morning = _deriveMorningSlots(provider);
        final afternoon = _deriveAfternoonSlots(provider);

        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Appcolor.whitecolor,

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
              style: GoogleFonts.poppins(
                color: Appcolor.blackcolor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
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
                        "₹$grandTotal",
                        style: GoogleFonts.poppins(
                          color: Appcolor.blackcolor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "inc. all taxes",
                        style: GoogleFonts.poppins(
                          color: Appcolor.blackcolor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
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
                              openLocationSheet(context, provider, item!);
                            },
                    child: Text(
                      "Confirm Booking",
                      style: GoogleFonts.poppins(
                        color: Appcolor.whitecolor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
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
                      final Map<String, dynamic> l = lines[index];
                      return _SelectedLineTile(
                        name: (l['name'] as String?)?.trim() ?? '',
                        qty: (l['qty'] as num?)?.toInt() ?? 0,
                        unit: (l['unit'] as num?)?.toInt() ?? 0,
                        total: (l['total'] as num?)?.toInt() ?? 0,
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
                    style: GoogleFonts.poppins(
                      color: Appcolor.blackcolor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 5.h),

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

                const _SectionHeader(title: "Afternoon Slots"),

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

  Future<void> showConfirmationSheet({
    required BuildContext context,
    required Recentworkmodel item,
  }) async {
    final parentNavigator = Navigator.of(context);

    final schedule = context.read<TimeScheduleViewProvider>();
    final selectedDate = schedule.selectedDate;
    final timeLabel = schedule.selectedTimeSlot ?? '';
    final formattedDate = DateFormat('EEE d MMM yyyy').format(selectedDate);

    final items = item.selectedoptoins.firstWhere((e) => e.id == widget.id);

    String placeLine;
    if ((items.placename ?? '').trim().isNotEmpty ||
        (items.area ?? '').trim().isNotEmpty) {
      final p = (items.placename ?? '').trim();
      final a = (items.area ?? '').trim();
      placeLine = [p, a].where((s) => s.isNotEmpty).join(', ');
    } else {
      placeLine = '1534 Single Street, USA';
    }
    final workline =
        (item.title ?? '').trim().isNotEmpty ? item.title! : 'Pest Control';

    final bool? goNext = await showModalBottomSheet<bool>(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.white,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Confirmation',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Appcolor.blackcolor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  placeLine,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Appcolor.blackcolor,
                  ),
                ),
                Text(
                  workline,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Appcolor.blackcolor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'at $timeLabel, $formattedDate',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Appcolor.blackcolor.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    ResumeButton(
                      buttonText: "continue",
                      onPressed: () {
                        Navigator.of(sheetContext).pop(true);
                      },
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed:
                              () => Navigator.of(sheetContext).pop(false),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: BorderSide(color: Appcolor.blackcolor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(
                              color: Appcolor.blackcolor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (goNext == true && mounted) {
      parentNavigator.pushNamed(
        RouteName.confirmbookingscreen,
        arguments: widget.id,
      );
    }
  }

  void openLocationSheet(
    BuildContext context,
    TimeScheduleViewProvider provider,
    Recentworkmodel item,
  ) {
    void _showAddAddressSheet() {
      final _addressController = TextEditingController();
      final _houseNoController = TextEditingController();
      final _landmarkController = TextEditingController();

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        builder: (ctx) {
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20.h,
                  top: 20.h,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onTap: () => Navigator.pop(ctx),
                            child: const Icon(Icons.close, size: 24),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Add your Address",
                        style: GoogleFonts.poppins(
                          color: Appcolor.blackcolor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      InputForm(
                        title: "Address",
                        controller: _addressController,
                      ),
                      SizedBox(height: 14.h),
                      InputForm(
                        title: "House/Flat No",
                        controller: _houseNoController,
                      ),
                      SizedBox(height: 14.h),
                      InputForm(
                        title: "Landmark",
                        controller: _landmarkController,
                      ),
                      SizedBox(height: 20.h),

                      Custombutton(
                        buttonText: "Continue",
                        onPressed: () {
                          Navigator.pop(ctx);
                          Future.delayed(const Duration(milliseconds: 120), () {
                            showConfirmationSheet(context: context, item: item);
                          });
                        },
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

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return SafeArea(
          top: false,
          child: Consumer<LocationProvider>(
            builder: (context, locationprovider, child) {
              final statusText =
                  locationprovider.isLoading
                      ? "Fetching your location…"
                      : (locationprovider.address ?? "Location not available");

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Saved Address",
                      style: GoogleFonts.poppins(
                        color: Appcolor.blackcolor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 15.h),

                    GestureDetector(
                      onTap: _showAddAddressSheet,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Appcolor.blackcolor, size: 18),
                          SizedBox(width: 6.w),
                          Text(
                            "Add another address",
                            style: GoogleFonts.poppins(
                              color: Appcolor.blackcolor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Appcolor.blackcolor,
                          size: 20,
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            statusText,
                            style: GoogleFonts.poppins(
                              color: Appcolor.blackcolor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    ResumeButton(
                      buttonText: "Proceed",
                      onPressed: () {
                        Navigator.pop(context);
                        Future.delayed(const Duration(milliseconds: 120), () {
                          showConfirmationSheet(context: context, item: item);
                        });
                      },
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// FlexibleBottomSheets.show(
//   context: context,
//   initialHeight: 0.5,
//   minHeight: 0.0,
//   maxHeight: 0.9,
//   headerHeight: 56,
//   headerBuilder:
//       (context, offset) => Container(
//         color: Appcolor.primarycolor,
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Flexible(
//               child: Text(
//                 'Set Location',
//                 style: TextStyle(
//                   color: Appcolor.whitecolor,
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () => Navigator.pop(context),
//               child: const Icon(Icons.close, color: Colors.white, size: 24),
//             ),
//           ],
//         ),
//       ),
//   bodyBuilder: (context, offset) {
//     return Padding(
//       // keeping your ScreenUtil usage as-is
//       padding: EdgeInsets.symmetric(vertical: 20.dg, horizontal: 20.sp),
//       child: Consumer<LocationProvider>(
//         builder: (context, locationprovider, child) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 20.sp),
//               InputForm(title: "Address", controller: _addressController),
//               SizedBox(height: 16.sp),
//               InputForm(
//                 title: "House/FlatNo",
//                 controller: _houseNoController,
//               ),
//               SizedBox(height: 16.sp),
//               InputForm(title: "Landmark", controller: _landmarkController),
//               SizedBox(height: 16.sp),
//               Custombutton(
//                 buttonText: "continue",
//                 onPressed: () {
//                   Navigator.pop(context);
//                   Future.delayed(const Duration(milliseconds: 120), () {
//                     showConfirmationSheet(
//                       context: this.context,
//                       item: item,
//                     );
//                   });
//                 },
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   },
// );

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
