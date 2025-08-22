import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mychoice/res/components/customtextbutton.dart';
import 'package:mychoice/res/widgets/customButton.dart';
import 'package:mychoice/res/widgets/customtimewidgets.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/view/Timesedules/timesecdule.dart';
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

  Future<void> showConfirmationSheet({
    required BuildContext context,
    required ControlPestModel item,
  }) async {
    final parentNavigator = Navigator.of(context);
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

    final bool? goNext = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      useRootNavigator: true,

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
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Appcolor.blackcolor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  placeLine,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Appcolor.blackcolor,
                  ),
                ),
                Text(
                  workline,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Appcolor.blackcolor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'at $timeLabel, $formattedDate',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Appcolor.blackcolor.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    ResumeButton(
                      buttonText: "continue",
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(ctx).pop(false),
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

    if (goNext == true && mounted) {
      parentNavigator.pushNamed(
        RouteName.pestcontrolconfirmationscreen,
        arguments: widget.id,
      );
    }
  }

  void openLocationSheet(
    BuildContext context,
    TimeScheduleViewProvider provider,
    ControlPestModel item,
  ) {
    {
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20.h),

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

                        ResumeButton(
                          buttonText: "Continue",
                          onPressed: () {
                            Navigator.pop(ctx);
                            Future.delayed(
                              const Duration(milliseconds: 120),
                              () {
                                showConfirmationSheet(
                                  context: context,
                                  item: item,
                                );
                              },
                            );
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
                        : (locationprovider.address ??
                            "Location not available");

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Saved Address",
                        style: GoogleFonts.poppins(
                          color: Appcolor.blackcolor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15.h),

                      GestureDetector(
                        onTap: _showAddAddressSheet,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Appcolor.blackcolor,
                              size: 18,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              "Add another address",
                              style: GoogleFonts.poppins(
                                color: Appcolor.blackcolor,
                                fontWeight: FontWeight.bold,
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
            surfaceTintColor: Appcolor.whitecolor,
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
              style: GoogleFonts.poppins(
                color: Appcolor.blackcolor,
                fontWeight: FontWeight.w600,
                fontSize: 17,
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
                        style: GoogleFonts.poppins(
                          color: Appcolor.blackcolor,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "${pestcontroprovider.totalSelectedCount} item(s)  • inc. all taxes",
                        style: GoogleFonts.poppins(
                          color: Appcolor.blackcolor.withOpacity(0.6),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
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
                    child: Text(
                      "Proceed",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
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
                SizedBox(height: 5.0.h),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text(
                    "Appointment",
                    style: GoogleFonts.poppins(
                      color: Appcolor.blackcolor,
                      fontWeight: FontWeight.w600,
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
                                // disabled: is,
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
