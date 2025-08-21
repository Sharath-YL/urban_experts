import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychoice/res/components/custombottomsheet.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/custombottomsheet.dart';
import 'package:mychoice/res/widgets/custombuttons.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/view/cleaning_pestcontrol_screens/cleaning_description_screen.dart';
import 'package:mychoice/viewmodel/homescreenview_model/homescreenview_provider.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CommonservicesDecriptionscreen extends StatefulWidget {
  final String id;
  const CommonservicesDecriptionscreen({super.key, required this.id});

  @override
  State<CommonservicesDecriptionscreen> createState() =>
      _CommonservicesDecriptionscreenState();
}

class _CommonservicesDecriptionscreenState
    extends State<CommonservicesDecriptionscreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomescreenviewProvider>(
        context,
        listen: false,
      ).getworkdetails();
      Provider.of<HomescreenviewProvider>(
        context,
        listen: false,
      ).clearSelectedOptions();
    });
  }

  void showSelectedOptionsBottomSheet(
    BuildContext context,
    HomescreenviewProvider provider,
  ) {
    final item = provider.recentworkmodel.firstWhere((e) => e.id == widget.id);

    final lines =
        item.selectedoptoins
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
                    color: Appcolor.whitecolor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
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
                  Text(
                    'No options selected.',
                    style: GoogleFonts.poppins(
                      color: Appcolor.blackcolor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                else
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: lines.length,
                      separatorBuilder:
                          (_, __) => Divider(
                            thickness: 1,
                            color: Appcolor.blackcolor.withOpacity(0.2),
                          ),
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
                  SizedBox(height: 12.h),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: GoogleFonts.poppins(
                          color: Appcolor.blackcolor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '₹$grandTotal',
                        style: GoogleFonts.poppins(
                          color: Appcolor.blackcolor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
                          RouteName.timesechudlescreen,
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
    ScreenUtil.init(context, designSize: const Size(375, 812));
    final homeProvider = Provider.of<HomescreenviewProvider>(context);

    final idx = homeProvider.recentworkmodel.firstWhere(
      (e) => e.id == widget.id,
      orElse: () => throw Exception('ID not found'),
    );

    final options = idx.selectedoptoins;

    if (idx == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Item not found')),
      );
    }

    return Consumer<HomescreenviewProvider>(
      builder: (context, homeprovider, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
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
              idx.title,
              style: GoogleFonts.poppins(
                color: Appcolor.blackcolor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          floatingActionButton:
              homeprovider.totalSelectedCount > 0
                  ? FloatingActionButton.extended(
                    onPressed:
                        () => showSelectedOptionsBottomSheet(
                          context,
                          homeprovider,
                        ),
                    backgroundColor: Appcolor.blackcolor,
                    label: Text(
                      'View Selected (${homeprovider.totalSelectedCount})',
                      style: GoogleFonts.poppins(
                        color: Appcolor.whitecolor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    icon: const Icon(Icons.check_circle, color: Colors.white),
                  )
                  : null,
          body:
              options.isNotEmpty
                  ? ListView.separated(
                    itemCount: options.length,
                    separatorBuilder:
                        (_, __) => Divider(
                          thickness: 1,
                          color: Appcolor.blackcolor.withOpacity(0.2),
                        ),
                    itemBuilder: (BuildContext context, int index) {
                      final option = options[index];
                      final qty = homeProvider.getQty(option.id);
                      return PestControlDetailWidget(
                        ontap: () {
                          if (qty == 0)
                            homeprovider.incrementOption(option.id);
                          else
                            homeprovider.decrementOption(option.id);
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
                            () => homeprovider.incrementOption(option.id),
                        onDecrement:
                            () => homeprovider.decrementOption(option.id),
                      );
                    },
                  )
                  : EmptyOptions(),
        );
      },
    );
  }
}
