import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mychoice/res/components/customtextbutton.dart';
import 'package:mychoice/res/widgets/customButton.dart';
import 'package:mychoice/res/widgets/custombottomsheet.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/viewmodel/location_view/location_provider.dart';
import 'package:mychoice/viewmodel/timesehedules/timesehdule_view_provider.dart';
import 'package:provider/provider.dart';
import 'package:mychoice/data/models/control_pest_model.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/custombuttons.dart';
import 'package:mychoice/viewmodel/control_pest_control_view/contro_pest_provider.dart';

class PestcontrolTimeselection extends StatefulWidget {
  final String id;
  const PestcontrolTimeselection({super.key, required this.id});

  @override
  State<PestcontrolTimeselection> createState() =>
      _PestcontrolTimeselectionState();
}

class _PestcontrolTimeselectionState extends State<PestcontrolTimeselection> {
  late final List<DateTime> _dates;
  final SearchController _searchController = SearchController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _houseNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dates = List.generate(7, (i) {
      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day).add(Duration(days: i));
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ControPestProvider>().getControPest();
      context.read<TimeScheduleViewProvider>().fetchScheduleData();
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

  int _unitPrice(dynamic p) =>
      p is num ? p.toInt() : int.tryParse(p?.toString() ?? '') ?? 0;

  void showConfirmationSheet({
    required BuildContext context,
    required ControlPestModel item,
  }) {
    final schedule = context.read<TimeScheduleViewProvider>();

    final DateTime selectedDate = schedule.selectedDate;
    final String timeLabel = schedule.selectedTimeSlot ?? '';
    final String formattedDate = DateFormat(
      'EEE d MMM yyyy',
    ).format(selectedDate);

    String placeLine;
    if ((item.placename ?? '').trim().isNotEmpty ||
        (item.area ?? '').trim().isNotEmpty) {
      final p = (item.placename ?? '').trim();
      final a = (item.area ?? '').trim();
      placeLine = [p, a].where((s) => s.isNotEmpty).join(', ');
    } else {
      placeLine = '1534 Single Street, USA';
    }
    String workline =
        (item.title ?? '').trim().isNotEmpty ? item.title! : 'Pest Control';

    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (ctx) {
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
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Appcolor.blackcolor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  placeLine,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Appcolor.blackcolor,
                  ),
                ),
                Text(
                  workline,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Appcolor.blackcolor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'at $timeLabel, $formattedDate',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
                        Navigator.pushNamed(
                          context,
                          RouteName.pestcontrolconfirmationscreen,
                          arguments: widget.id,
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: BorderSide(color: Appcolor.blackcolor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Appcolor.blackcolor,
                              fontWeight: FontWeight.w700,
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
  }

  void openLocationSheet(
    BuildContext context,
    TimeScheduleViewProvider provider,
    ControlPestModel item,
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
                  //         await locationprovider.getposition(context);
                  //         if (locationprovider.address != null) {
                  //           _addressController.text = locationprovider.address!;
                  //         }
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
                  // SizedBox(height: 20.sp),
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
                      Navigator.pop(context);
                      Future.delayed(const Duration(milliseconds: 120), () {
                        showConfirmationSheet(
                          context: this.context,
                          item: item,
                        );
                      });
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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    final schedule = context.watch<TimeScheduleViewProvider>();

    return Consumer<ControPestProvider>(
      builder: (context, pestcontroprovider, child) {
        ControlPestModel? item;
        try {
          item = pestcontroprovider.items.firstWhere(
            (e) => e.id == widget.id,
            orElse: () => throw Exception('Item not found'),
          );
        } catch (e) {
          return const Scaffold(body: Center(child: Text('Item not found')));
        }

        final lines =
            item.selectedOptions
                .map((o) {
                  final q = pestcontroprovider.getQty(o.id);
                  if (q <= 0) return null;
                  final unit = _unitPrice(o.price);
                  return {
                    'name': o.placename,
                    'qty': q,
                    'unit': unit,
                    'total': unit * q,
                  };
                })
                .whereType<Map<String, dynamic>>()
                .toList();

        if (lines.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('No selected options found')),
          );
        }

        final int grandTotal = lines.fold<int>(
          0,
          (sum, e) => sum + (e['total'] as int),
        );

        final selectedIndex = _dates.indexWhere(
          (d) =>
              d.year == schedule.selectedDate.year &&
              d.month == schedule.selectedDate.month &&
              d.day == schedule.selectedDate.day,
        );
        final effectiveSelectedIndex = selectedIndex == -1 ? 0 : selectedIndex;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Appcolor.whitecolor,
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Appcolor.greycolor,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Appcolor.blackcolor,
                    size: 15,
                  ),
                ),
              ),
            ),
            title: Text(
              item.title,
              style: TextStyle(
                color: Appcolor.blackcolor,
                fontWeight: FontWeight.bold,
                fontSize: 15,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
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
                        "${pestcontroprovider.totalSelectedCount} item(s)  • inc. all taxes",
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
                          schedule.selectedTimeSlot == null
                              ? Appcolor.greycolor
                              : Appcolor.blackcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                    onPressed:
                        schedule.selectedTimeSlot == null
                            ? null
                            : () {
                              // showConfirmationSheet(
                              //   context: context,
                              //   item: item!,
                              // );
                              openLocationSheet(context, schedule, item!);
                            },
                    child: const Text(
                      "Proceed",
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
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: lines.length,
                  separatorBuilder:
                      (_, __) => Divider(
                        thickness: 1,
                        color: Appcolor.blackcolor.withOpacity(0.2),
                      ),
                  itemBuilder: (context, index) {
                    final l = lines[index];
                    return SelectedLineTile(
                      name: l['name']?.toString() ?? '-',
                      qty: l['qty'] as int,
                      unit: l['unit'] as int,
                      total: l['total'] as int,
                    );
                  },
                ),

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
                      return DatePill(
                        labelTop: week,
                        labelBottom: day,
                        selected: selected,
                        onTap: () => schedule.setSelectedDate(d),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                const SectionHeader(title: "Morning Slots"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children:
                        schedule.morningSlots
                            .map(
                              (t) => TimeChip(
                                label: t,
                                selected: schedule.selectedTimeSlot == t,
                                onTap: () => schedule.setSelectedTimeSlot(t),
                              ),
                            )
                            .toList(),
                  ),
                ),

                const SectionHeader(title: "Afternoon"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children:
                        schedule.afternoonSlots
                            .map(
                              (t) => TimeChip(
                                label: t,
                                selected: schedule.selectedTimeSlot == t,
                                onTap: () => schedule.setSelectedTimeSlot(t),
                              ),
                            )
                            .toList(),
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
}

class SelectedLineTile extends StatelessWidget {
  final String name;
  final int qty;
  final int unit;
  final int total;

  const SelectedLineTile({
    super.key,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Leading icon
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

            // Title + equation
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + qty chip
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
                              color: Appcolor.blackcolor,
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
                          'x$qty',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11.sp,
                            color: Appcolor.blackcolor,
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
                        color: Appcolor.blackcolor.withOpacity(0.75),
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(text: '₹$unit'),
                        const TextSpan(text: ' × '),
                        TextSpan(text: '$qty'),
                        const TextSpan(text: ' = '),
                        TextSpan(
                          text: '₹$total',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Appcolor.blackcolor,
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
                color: Appcolor.blackcolor,
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
              offset: const Offset(0, 4),
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

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});
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

class TimeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const TimeChip({
    super.key,
    required this.label,
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

    return InkWell(
      onTap: onTap,
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
