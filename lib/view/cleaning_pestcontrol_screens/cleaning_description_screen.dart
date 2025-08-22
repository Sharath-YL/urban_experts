import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychoice/res/components/custombottomsheet.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/custombottomsheet.dart';
import 'package:mychoice/res/widgets/custombuttons.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/viewmodel/control_pest_control_view/contro_pest_provider.dart';
import 'package:provider/provider.dart';

class CleaningDescriptionScreen extends StatefulWidget {
  final String id;
  const CleaningDescriptionScreen({super.key, required this.id});

  @override
  State<CleaningDescriptionScreen> createState() =>
      _CleaningDescriptionScreenState();
}

class _CleaningDescriptionScreenState extends State<CleaningDescriptionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ControPestProvider>().getControPest();
      context.read<ControPestProvider>().clearSelectedOptions();
    });
  }

  void showSelectedOptionsBottomSheet(
    BuildContext context,
    ControPestProvider provider,
  ) {
    final item = provider.items.firstWhere((e) => e.id == widget.id);

    final lines =
        item.selectedOptions
            .map((o) {
              final q = provider.getQty(o.id);
              if (q <= 0) return null;
              final unit = o.price ?? 0;
              return {
                'name': o.placename,
                'qty': q,
                'unit': unit,
                'total': unit * q,
              };
            })
            .whereType<Map<String, dynamic>>()
            .toList();

    final int grandTotal = lines.fold<int>(
      0,
      (sum, e) => sum + (e['total'] as int),
    );

    FlexibleBottomSheets.show(
      context: context,
      initialHeight: 0.5,
      minHeight: 0.0,
      maxHeight: 0.9,
      headerHeight: 56,
      headerBuilder:
          (context, offset) => Container(
            color: Appcolor.blackcolor,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selected Options (${provider.totalSelectedCount})',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.white, size: 24),
                ),
              ],
            ),
          ),
      bodyBuilder:
          (context, offset) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (lines.isEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    decoration: BoxDecoration(
                      color: Appcolor.blackcolor.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Appcolor.blackcolor.withOpacity(0.08),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.receipt_long,
                          size: 36,
                          color: Appcolor.blackcolor.withOpacity(0.5),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'No options selected.',
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                      ],
                    ),
                  )
                else
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                    ),
                    child: ListView.separated(
                      itemCount: lines.length,
                      shrinkWrap: true,
                      separatorBuilder: (_, __) => Divider(),
                      itemBuilder: (context, i) {
                        final l = lines[i];
                        return LineCard(
                          name: '${l['name']}',
                          qty: l['qty'] as int,
                          unit: l['unit'] as int,
                          total: l['total'] as int,
                        );
                      },
                    ),
                  ),

                if (lines.isNotEmpty) ...[
                  SizedBox(height: 8.h),

                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Appcolor.blackcolor.withOpacity(0.7),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Appcolor.blackcolor,
                            ),
                          ),
                          Text(
                            '₹$grandTotal',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Appcolor.blackcolor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: ResumeButton(
                      buttonText: "Continue",
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          RouteName.pestcontroltimeselectionselection,
                          arguments: widget.id,
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ControPestProvider>(
      builder: (context, provider, _) {
        if (provider.islaoding) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        try {
          final item = provider.items.firstWhere(
            (e) => e.id == widget.id,
            orElse: () => throw Exception('ID not found'),
          );

          final options = item.selectedOptions;

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              surfaceTintColor: Appcolor.whitecolor,
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
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            floatingActionButton:
                provider.totalSelectedCount > 0
                    ? FloatingActionButton.extended(
                      onPressed:
                          () =>
                              showSelectedOptionsBottomSheet(context, provider),
                      backgroundColor: Appcolor.blackcolor,
                      label: Text(
                        'View Selected (${provider.totalSelectedCount})',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      icon: const Icon(Icons.check_circle, color: Colors.white),
                    )
                    : null,
            body:
                options.isNotEmpty
                    ? ListView.separated(
                      itemCount: options.length,
                      padding: EdgeInsets.only(
                        top: 8.h,
                        left: 4.w,
                        right: 4.w,
                        bottom: 16.h,
                      ),
                      separatorBuilder:
                          (_, __) => Divider(
                            thickness: 1,
                            color: Appcolor.blackcolor.withOpacity(0.2),
                          ),
                      itemBuilder: (context, index) {
                        final option = options[index];
                        final qty = provider.getQty(option.id);

                        return PestControlDetailWidget(
                          ontap: () {
                            if (qty == 0)
                              provider.incrementOption(option.id);
                            else
                              provider.decrementOption(option.id);
                          },
                          place: option.placename,
                          time: option.time,
                          price: option.price,
                          onMoreInfo:
                              () => showDescriptionBottomSheet(
                                context,
                                option.description,
                              ),
                          isSelected: qty > 0,
                          quantity: qty,
                          onIncrement:
                              () => provider.incrementOption(option.id),
                          onDecrement:
                              () => provider.decrementOption(option.id),
                        );
                      },
                    )
                    : const EmptyOptions(),
          );
        } catch (e) {
          return Scaffold(body: Center(child: Text('Error: $e')));
        }
      },
    );
  }
}

class PestControlDetailWidget extends StatelessWidget {
  final String? place;
  final int? time;
  final int? price;
  final VoidCallback? onMoreInfo;
  final VoidCallback? ontap;

  // NEW:
  final int quantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  final bool? isSelected;

  const PestControlDetailWidget({
    super.key,
    this.place,
    this.time,
    this.price,
    this.onMoreInfo,
    this.ontap,
    this.isSelected,
    this.quantity = 0,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: ontap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.all(8.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      place ?? 'Unknown Place',
                      style: GoogleFonts.poppins(
                        color: Appcolor.blackcolor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isSelected == true)
                    Icon(
                      Icons.check_circle,
                      color: Appcolor.blackcolor,
                      size: 20.sp,
                    ),
                ],
              ),
              SizedBox(height: 10.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/icons/clock.png",
                        height: 15,
                        width: 15,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        time != null ? '$time min' : 'N/A',
                        style: GoogleFonts.poppins(
                          color: Appcolor.blackcolor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        price != null ? '₹$price' : 'N/A',
                        style: GoogleFonts.poppins(
                          color: Appcolor.blackcolor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8.w),

                      if (quantity == 0)
                        _miniButton(label: '+', onTap: onIncrement)
                      else
                        Row(
                          children: [
                            _miniButton(label: '-', onTap: onDecrement),
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Appcolor.blackcolor),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '$quantity',
                                style: GoogleFonts.poppins(
                                  color: Appcolor.blackcolor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            _miniButton(label: '+', onTap: onIncrement),
                          ],
                        ),
                    ],
                  ),
                ],
              ),

              if (onMoreInfo != null) ...[
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: onMoreInfo,
                  child: Text(
                    'More Info',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: Appcolor.primarycolor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _miniButton({required String label, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28.w,
        height: 28.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Appcolor.blackcolor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            color: Appcolor.blackcolor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class EmptyOptions extends StatelessWidget {
  const EmptyOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.info_outline, size: 40, color: Colors.grey),
            SizedBox(height: 12),
            Text(
              'No options available for this service yet.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class LineCard extends StatelessWidget {
  final String name;
  final int qty;
  final int unit;
  final int total;

  const LineCard({
    required this.name,
    required this.qty,
    required this.unit,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Appcolor.blackcolor.withOpacity(0.08)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: GoogleFonts.poppins(
                            color: Appcolor.blackcolor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // Container(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: 8.w,
                      //     vertical: 4.h,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     color: Appcolor.blackcolor.withOpacity(0.06),
                      //     borderRadius: BorderRadius.circular(999),
                      //   ),
                      //   child: Text(
                      //     'x$qty',
                      //     style: GoogleFonts.poppins(
                      //       color: Appcolor.blackcolor,
                      //       fontSize: 15.sp,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  Text(
                    '₹$unit each = ₹$unit × $qty = ₹$total',
                    style: GoogleFonts.poppins(
                      color: Appcolor.blackcolor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 10.w),
            Text(
              '₹$total',
              style: GoogleFonts.poppins(
                color: Appcolor.blackcolor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
