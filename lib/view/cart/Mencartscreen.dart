import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/custombottomsheet.dart';
import 'package:mychoice/res/widgets/custombuttons.dart';
import 'package:mychoice/res/widgets/customcancellationcard.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/viewmodel/addingmenspackages/adding_menspackagesprovider.dart';
import 'package:provider/provider.dart';

class MenCartScreen extends StatefulWidget {
  const MenCartScreen({super.key});

  @override
  State<MenCartScreen> createState() => _MenCartScreenState();
}

class _MenCartScreenState extends State<MenCartScreen> {
  GoogleMapController? _mapController;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mapController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddingMenspackagesprovider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverAppBar(
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Appcolor.whitecolor),
                ),
                automaticallyImplyLeading: false,
                backgroundColor: Appcolor.primarycolor,
                title: Text(
                  "Your Cart",
                  style: TextStyle(
                    color: Appcolor.whitecolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                pinned: true,
                expandedHeight: 50.0,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = provider.cartItems[index];
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Appcolor.primarycolor,
                    ),
                    title: Text(
                      item['title'],
                      style: TextStyle(
                        color: Appcolor.blackcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Quantity: ${item['quantity']}',
                      style: TextStyle(
                        color: Appcolor.blackcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      '₹${item['price']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Appcolor.blackcolor,
                      ),
                    ),
                    onTap: () {},
                  );
                }, childCount: provider.cartItems.length),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment Summary',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Appcolor.blackcolor,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      _buildSummaryRow('itemtotal', '₹ ${provider.subtotal}'),
                      SizedBox(height: 8.0),

                      _buildSummaryRow(
                        'Discount',
                        '-₹ ${provider.savings}',
                        isSavings: true,
                      ),
                      SizedBox(height: 8.0),

                      _buildSummaryRow(
                        'Total Amount',
                        '₹ ${provider.total}',
                        isBold: true,
                      ),
                      Divider(thickness: 1, color: Appcolor.blackcolor),

                      _buildSummaryRow(
                        'Total amount to be paid',
                        '₹ ${provider.total}',
                        isBold: true,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        "Cancellation Policy : ",
                        style: TextStyle(
                          color: Appcolor.blackcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "Free cancellation if done more than 12 hrs befor the service given or if the vendors isnt assinged ,A fees will be charged ... ",
                        style: TextStyle(),
                      ),
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () {
                          FlexibleBottomSheet.show(
                            context: context,
                            headerHeight: 56,
                            headerBuilder:
                                (context, offset) => Container(
                                  color: Appcolor.primarycolor,
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Flexible(
                                        child: Text(
                                          'Cancelation Policy',
                                          style: TextStyle(
                                            color: Appcolor.whitecolor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            bodyBuilder:
                                (context, offset) => _buildCancellationCard(),
                          );
                        },
                        child: Text(
                          "Read More",
                          style: TextStyle(color: Appcolor.sucesscolor),
                        ),
                      ),

                      SizedBox(height: 10.0.h),
                      Text(
                        'Add Tip to Book Fast',
                        style: TextStyle(
                          color: Appcolor.blackcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 20.0.h),
                      buildTipsCards(),

                      SizedBox(height: 16.0),
                      ResumeButton(
                        buttonText: "Confirm Booking",
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            RouteName.confirmbookingscreen,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isSavings = false,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isSavings ? Appcolor.sucesscolor : Appcolor.blackcolor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isSavings ? Appcolor.sucesscolor : Appcolor.blackcolor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancellationCard() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Time',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Fee',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('More than 12 hrs before the service'),
                    Text('Free', style: TextStyle(color: Colors.green)),
                  ],
                ),
                const Divider(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Within 12 hrs of the service'),
                    Text('Up to ₹50', style: TextStyle(color: Colors.black)),
                  ],
                ),
                const Divider(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Within 3 hrs of the service'),
                    Text('Up to ₹100', style: TextStyle(color: Colors.black)),
                  ],
                ),
                const Divider(),
                const Row(
                  children: [
                    Icon(Icons.info, color: Colors.green, size: 16),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'No fee if a professional is not assigned',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'This fee goes to the professional. Their time is reserved for the service & they cannot get another job for the reserved time',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.handshake, color: Colors.green, size: 24),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 50.0.h,
                width: 350.sp,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Appcolor.blackcolor.withOpacity(0.3),
                    ),
                    top: BorderSide(
                      color: Appcolor.blackcolor.withOpacity(0.3),
                    ),
                    left: BorderSide(
                      color: Appcolor.blackcolor.withOpacity(0.3),
                    ),
                    right: BorderSide(
                      color: Appcolor.blackcolor.withOpacity(0.3),
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    'okay',
                    style: TextStyle(
                      color: Appcolor.blackcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
