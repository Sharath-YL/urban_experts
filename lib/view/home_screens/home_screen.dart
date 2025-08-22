import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/customHomeappbarwidget.dart';
import 'package:mychoice/res/widgets/customMostbookedservices.dart';
import 'package:mychoice/res/widgets/custombestservices.dart';
import 'package:mychoice/res/widgets/customcoroselwidget.dart';
import 'package:mychoice/res/widgets/customsearchbar.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/viewmodel/homescreenview_model/homescreenview_provider.dart';
import 'package:mychoice/viewmodel/location_view/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  bool isLoading = true;

  @override
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
    ScreenUtil.init(context, designSize: const Size(390, 850));
    final locationProvider = Provider.of<LocationProvider>(context);
    final homescreenProvider = Provider.of<HomescreenviewProvider>(context);

    return Scaffold(
      backgroundColor: Appcolor.whitecolor,
      appBar: HomeAppBar(
        line1: _getFirstLineAddress(locationProvider.address ?? ""),
        line2: _getRemainingAddress(locationProvider.address ?? ""),
        controller: _searchController,
        onBellTap: () {
          Navigator.pushNamed(context, RouteName.notificationscreen);
        },
      ),
      body: Skeletonizer(
        enabled: locationProvider.isLoading || homescreenProvider.isloading,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.0.h),
              SizedBox(
                height: 250.h,
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteName.cleaningpestcontrolscreen,
                    );
                  },
                  child: const CustomCarousel(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0.sp,
                  // vertical: 10.0.h,
                ),
                child: Column(
                  children: [
                    Consumer<HomescreenviewProvider>(
                      builder: (context, snapshot, child) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.recentworkmodel.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 4,
                                childAspectRatio: 0.9,
                              ),
                          itemBuilder: (context, index) {
                            final service = snapshot.recentworkmodel[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteName.commonservicescreen,
                                  arguments: service.id,
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 80.h,
                                    width: 80.h,
                                    padding: EdgeInsets.all(8.w),
                                    decoration: BoxDecoration(
                                      color: Appcolor.whitecolor.withOpacity(
                                        0.3,
                                      ),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child:
                                          service.imageurl.startsWith('http')
                                              ? Image.network(
                                                service.imageurl,
                                                fit: BoxFit.fill,
                                                errorBuilder: (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) {
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
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                          strokeWidth: 1.5,
                                                        ),
                                                  );
                                                },
                                              )
                                              : Image.asset(
                                                service.imageurl,
                                                fit: BoxFit.fill,
                                                errorBuilder: (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) {
                                                  return Icon(
                                                    Icons.broken_image,
                                                    color: Colors.grey,
                                                    size: 30.sp,
                                                  );
                                                },
                                              ),
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    service.title,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      color: Appcolor.blackcolor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
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
                    SizedBox(height: 10.0.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Cleaning & Pest Control",
                            style: GoogleFonts.poppins(
                              color: Appcolor.blackcolor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteName.cleaningpestcontrolscreen,
                            );
                          },
                          child: Text(
                            "View All",
                            style: GoogleFonts.poppins(
                              color: Appcolor.primarycolor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Custommostbookedservices(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Our Best Services",
                            style: GoogleFonts.poppins(
                              color: Appcolor.blackcolor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteName.cleaningpestcontrolscreen,
                            );
                          },
                          child: Text(
                            "View All",
                            style: GoogleFonts.poppins(
                              color: Appcolor.primarycolor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Custombestservices(),
                  ],
                ),
              ),
            ],
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
