import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/customtimewidgets.dart';
import 'package:mychoice/view/home_screens/index_screens.dart';
import 'package:provider/provider.dart';
import 'package:mychoice/data/models/control_pest_model.dart';
import 'package:mychoice/viewmodel/control_pest_control_view/contro_pest_provider.dart';
import 'package:mychoice/viewmodel/timesehedules/timesehdule_view_provider.dart';
import 'package:mychoice/viewmodel/location_view/location_provider.dart';
import 'package:mychoice/viewmodel/bookingscreenmodels/bookingscreen_provider.dart';
import 'package:mychoice/viewmodel/addingmenspackages/Cartprovider.dart';

class PestcontrolConfirmationScreen extends StatefulWidget {
  final String id;
  const PestcontrolConfirmationScreen({super.key, required this.id});

  @override
  State<PestcontrolConfirmationScreen> createState() =>
      _PestcontrolConfirmationScreenState();
}

class _PestcontrolConfirmationScreenState
    extends State<PestcontrolConfirmationScreen> {
  bool _showSuccess = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() => _showSuccess = false);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _retry() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final Color dim = Colors.black.withOpacity(0.12);

    return Consumer5<
      ControPestProvider,
      TimeScheduleViewProvider,
      LocationProvider,
      BookingProvider,
      CartProvider
    >(
      builder: (
        context,
        pestControlProvider,
        scheduleProvider,
        locationProvider,
        bookingProvider,
        cartProvider,
        child,
      ) {
        ControlPestModel? item;
        try {
          item = pestControlProvider.items.firstWhere(
            (e) => e.id == widget.id,
            orElse: () => throw Exception('Item not found'),
          );
        } catch (e) {
          return Scaffold(body: Center(child: Text('Item not found')));
        }

        final selectedDate = scheduleProvider.selectedDate;
        final timeLabel = scheduleProvider.selectedTimeSlot ?? 'Not selected';
        final formattedDate = DateFormat('EEE d MMM yyyy').format(selectedDate);

        final selectedIdsForItem =
            pestControlProvider.selectedOptionIds
                .where((id) => item!.selectedOptions.any((o) => o.id == id))
                .toList();

        final selectedOptions =
            item!.selectedOptions
                .where((o) => selectedIdsForItem.contains(o.id))
                .toList();

        final int totalPrice =
            selectedOptions.isNotEmpty
                ? selectedOptions.fold(0, (sum, o) => sum + o.price)
                : item.price;
        print("the total prce is : $totalPrice");

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
            (item.description ?? '').trim().isNotEmpty
                ? item.description!
                : (item.title ?? '').trim().isNotEmpty
                ? item.title!
                : 'Pest Control';

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: CircleAvatar(
                backgroundColor: dim,
                radius: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 12),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  splashRadius: 20,
                ),
              ),
            ),
            title: const Text(""),
          ),
          body: SafeArea(
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 450),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                child:
                    _showSuccess
                        ? SuccessView(
                          key: const ValueKey('ok'),
                          placeLine: placeLine,
                          workline: workline,
                          timeLabel: timeLabel,
                          formattedDate: formattedDate,
                          totalPrice: totalPrice,
                          selectedOptions: selectedOptions,
                          onBackHome: () {
                            bookingProvider.addpestcontrolbooking(
                              timeProvider: scheduleProvider,
                              pestProvider: pestControlProvider,
                              itemId: widget.id,
                              locationProvider: locationProvider,
                            );
                            cartProvider.initializeCart();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => IndexScreens(
                                      pageController: PageController(
                                        initialPage: 1,
                                      ),
                                    ),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                        )
                        : ErrorView(
                          onRetry: _retry,
                          key: const ValueKey('err'),
                        ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SuccessView extends StatelessWidget {
  final String placeLine;
  final String workline;
  final String timeLabel;
  final String formattedDate;
  final int totalPrice;
  final List<PestOption> selectedOptions;
  final VoidCallback onBackHome;

  const SuccessView({
    required this.placeLine,
    required this.workline,
    required this.timeLabel,
    required this.formattedDate,
    required this.totalPrice,
    required this.selectedOptions,
    required this.onBackHome,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final rupee = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );
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
                  color: Appcolor.sucesscolor.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  border: Border.all(color: Appcolor.sucesscolor, width: 3),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, color: Appcolor.sucesscolor, size: 56),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            placeLine,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              // color: Appcolor.primarycolor.withOpacity(0.06),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Appcolor.blackcolor.withOpacity(0.25)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.receipt_long,
                  size: 20,
                  color: Appcolor.primarycolor,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Total Amount',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  rupee.format(totalPrice),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Service scheduled at $placeLine\non $timeLabel, $formattedDate",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 12),
          // Card(
          //   elevation: 8.0,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(16),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(16),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           'Booking Details',
          //           style: TextStyle(
          //             fontSize: 18,
          //             fontWeight: FontWeight.w600,
          //             color: Appcolor.blackcolor,
          //           ),
          //         ),
          //         const SizedBox(height: 12),
          //         Row(
          //           children: [
          //             Icon(
          //               Icons.apps_outlined,
          //               color: Appcolor.primarycolor,
          //               size: 20,
          //             ),
          //             const SizedBox(width: 8),
          //             Text(
          //               workline,
          //               style: TextStyle(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.bold,
          //                 color: Appcolor.blackcolor,
          //               ),
          //             ),
          //           ],
          //         ),
          //         if (selectedOptions.isNotEmpty) ...[
          //           const SizedBox(height: 10),
          //           Text(
          //             'Selected Options:',
          //             style: TextStyle(
          //               fontSize: 14,
          //               fontWeight: FontWeight.w500,
          //               color: Appcolor.greycolor,
          //             ),
          //           ),
          //           ...selectedOptions.map(
          //             (option) => Padding(
          //               padding: const EdgeInsets.symmetric(vertical: 4),
          //               child: Row(
          //                 children: [
          //                   Icon(
          //                     Icons.check_circle,
          //                     color: Appcolor.primarycolor,
          //                     size: 16,
          //                   ),
          //                   const SizedBox(width: 8),
          //                   Expanded(
          //                     child: Text(
          //                       option.placename,
          //                       style: TextStyle(
          //                         fontSize: 14,
          //                         color: Appcolor.blackcolor,
          //                       ),
          //                     ),
          //                   ),
          //                   Text(
          //                     '₹${option.price}',
          //                     style: TextStyle(
          //                       fontSize: 14,
          //                       color: Appcolor.blackcolor,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ],
          //         const SizedBox(height: 12),
          //         Row(
          //           children: [
          //             Icon(
          //               Icons.calendar_today,
          //               color: Appcolor.primarycolor,
          //               size: 20,
          //             ),
          //             const SizedBox(width: 8),
          //             Text(
          //               '$timeLabel, $formattedDate',
          //               style: TextStyle(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w500,
          //                 color: Appcolor.blackcolor,
          //               ),
          //             ),
          //           ],
          //         ),
          //         const SizedBox(height: 12),
          //         Row(
          //           children: [
          //             Icon(
          //               Icons.location_on,
          //               color: Appcolor.primarycolor,
          //               size: 20,
          //             ),
          //             const SizedBox(width: 8),
          //             Expanded(
          //               child: Text(
          //                 placeLine,
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w500,
          //                   color: Appcolor.blackcolor,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //         const SizedBox(height: 12),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Text(
          //               'Total',
          //               style: TextStyle(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w600,
          //                 color: Appcolor.blackcolor,
          //               ),
          //             ),
          //             Text(
          //               '₹$totalPrice',
          //               style: TextStyle(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w600,
          //                 color: Appcolor.blackcolor,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          const SizedBox(height: 24),
          SizedBox(
            width: 180,
            height: 48,
            child: ElevatedButton(
              onPressed: onBackHome,
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('Back to Bookings'),
            ),
          ),
        ],
      ),
    );
  }
}
