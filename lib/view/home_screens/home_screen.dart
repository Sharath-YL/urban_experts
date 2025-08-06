import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/customMostbookedservices.dart';
import 'package:mychoice/res/widgets/customcoroselwidget.dart';
import 'package:mychoice/res/widgets/customsearchbar.dart';
import 'package:mychoice/utils/routes/route_name.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/viewmodel/homescreenview_model/homescreenview_provider.dart';
import 'package:mychoice/viewmodel/location_view/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  bool isLoading = true;

  // final List<Map<String, dynamic>> _services = [
  //   {
  //     "title": "Women's Salon & Spa",
  //     "image":
  //         "https://tse4.mm.bing.net/th/id/OIP.mZgBe1esdO_u81ju5DI-YwHaE7?pid=Api&P=0&h=180",
  //   },
  //   {
  //     "title": "Men's Salon & Massage",
  //     "image":
  //         "https://tse3.mm.bing.net/th/id/OIP.RDN06zToKAL3Lbx9B7OxJgHaDa?pid=Api&P=0&h=180",
  //   },
  //   {
  //     "title": "AC & Appliance Repair",
  //     "image":
  //         "https://tse3.mm.bing.net/th/id/OIP.KIZyFbNVIlvn41MHrMC1bgHaE8?pid=Api&P=0&h=180",
  //   },
  //   {
  //     "title": "Cleaning & Pest Control",
  //     "image":
  //         "https://tse3.mm.bing.net/th/id/OIP.bLpJha5mn3nGDNYZ9MqgpAHaDt?pid=Api&P=0&h=180",
  //   },
  //   {
  //     "title": "Electrician, Plumber & Carpenter",
  //     "image":
  //         "https://tse3.mm.bing.net/th/id/OIP.UFuZhXs77tYckET8M-h9YwHaE8?pid=Api&P=0&h=180",
  //   },
  //   {
  //     "title": "Native Water Purifier",
  //     "image":
  //         "https://tse3.mm.bing.net/th/id/OIP.dHPj3qeLUU_EYQoQYDW0JwHaEJ?pid=Api&P=0&h=180",
  //   },
  // ];

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final recentworkdetails =
          Provider.of<HomescreenviewProvider>(
            context,
            listen: false,
          ).getworkdetails();
      final locationProvider = Provider.of<LocationProvider>(
        context,
        listen: false,
      );
      locationProvider
          .getposition(context)
          .then((_) {
            locationProvider.isLoading = false;
          })
          .catchError((e) {
            print("Error in initial location fetch: $e");
            locationProvider.isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to fetch location: $e")),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final homescreenProvider = Provider.of<HomescreenviewProvider>(context);
    return Scaffold(
      backgroundColor: Appcolor.whitecolor,
      body: Skeletonizer(
        enabled: locationProvider.isLoading || homescreenProvider.isloading,

        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0.sp,
              vertical: 20.0.h,
            ),
            child: Column(
              children: [
                SizedBox(height: 30.0.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getFirstLineAddress(
                              locationProvider.address ?? "",
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Appcolor.blackcolor,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _getRemainingAddress(
                              locationProvider.address ?? "",
                            ),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Appcolor.blackcolor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18.0.h),
                SearchTextField(controller: _searchController),
                SizedBox(height: 10.h),
                Consumer<HomescreenviewProvider>(
                  builder: (context, snapshot, child) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.recentworkmodel.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.85,
                          ),
                      itemBuilder: (context, index) {
                        final service = snapshot.recentworkmodel[index];
                        return GestureDetector(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Navigator.pushNamed(
                                  context,
                                  RouteName.description,
                                  arguments: service.id,
                                );
                                break;
                            }
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 70.h,
                                width: 70.h,
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: Appcolor.whitecolor,
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Image.network(
                                    service.imageurl,
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                        size: 30.sp,
                                      );
                                    },
                                    loadingBuilder: (
                                      context,
                                      child,
                                      loadingProgress,
                                    ) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                service.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Appcolor.blackcolor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                Container(
                  height: 80.h,
                  width: 350.sp,
                  decoration: BoxDecoration(color: Appcolor.greycolor),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "painting & water purifieing",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Appcolor.blackcolor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.network(
                          'https://tse1.mm.bing.net/th/id/OIP.hp-zppE8DGS1KX2i4wRkmQHaEQ?pid=Api&P=0&h=180',
                          width: 60.w,
                          height: 70.h,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0.h),
                Container(width: double.infinity, child: CustomCarousel()),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0.sp,
                    vertical: 10.0.h,
                  ),
                  child: Custommostbookedservices(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getFirstLineAddress(String address) {
    final parts = address.split(',');
    return parts.isNotEmpty ? parts[0].trim() : "Address not available";
  }

  String _getRemainingAddress(String address) {
    final parts = address.split(',');
    if (parts.length > 1) {
      final remainingParts = parts.sublist(1);
      if (remainingParts.isNotEmpty) {
        final lastPart = remainingParts.last.split(' ');
        if (lastPart.length > 2) {
          remainingParts[remainingParts.length - 1] = lastPart
              .sublist(0, lastPart.length - 2)
              .join(' ');
        }
        return remainingParts.join(',').trim();
      }
    }
    return "";
  }
}
