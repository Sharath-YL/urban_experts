import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/constants/colors.dart';
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
      appBar: _HomeAppBar(
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
                    // Row(
                    //   children: [
                    //     Text(
                    //       "Services",
                    //       style: TextStyle(
                    //         color: Appcolor.blackcolor,
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 18.sp,
                    //       ),
                    //       overflow: TextOverflow.ellipsis,
                    //     ),
                    //     const Spacer(),
                    //   ],
                    // ),

                    // SizedBox(height: 10.h),
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
                                  RouteName.description,
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
                                    style: TextStyle(
                                      fontSize: 12.sp,
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
                    SizedBox(height: 10.0.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Cleaning & Pest Control",
                            style: TextStyle(
                              color: Appcolor.blackcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
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
                            style: TextStyle(
                              color: Appcolor.primarycolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
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
                            style: TextStyle(
                              color: Appcolor.blackcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
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
                            style: TextStyle(
                              color: Appcolor.primarycolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.0.sp,
                        vertical: 10.0.h,
                      ),
                      child: Custombestservices(),
                    ),
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

class TransformCarousel extends StatelessWidget {
  const TransformCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "assets/images/image1.jpg",
      "assets/images/acimage.jpg",
      "assets/images/plumber.webp",
    ];

    return ScrollConfiguration(
      behavior: AppScrollBehavior(),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 210,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,

                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(images[index]),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices {
    return {...super.dragDevices, PointerDeviceKind.mouse};
  }
}

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar({
    required this.line1,
    required this.line2,
    required this.controller,
    this.onBellTap,
  });

  final String line1;
  final String line2;
  final TextEditingController controller;
  final VoidCallback? onBellTap;

  @override
  Size get preferredSize => const Size.fromHeight(160);

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return AppBar(
      backgroundColor: Appcolor.blackcolor,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      toolbarHeight: 170,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      flexibleSpace: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: title/address + bell
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Skeletonizer(
                      enabled: locationProvider.isLoading,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            line1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Appcolor.whitecolor,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            line2,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Appcolor.whitecolor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onBellTap,
                    icon: const Icon(
                      Icons.notifications_none,
                      color: Appcolor.whitecolor,
                      size: 25,
                    ),
                    tooltip: 'Notifications',
                  ),
                ],
              ),

              // Extra spacing between texts and search field
              SizedBox(height: 20.h),

              // Search field
              Skeletonizer(
                enabled: locationProvider.isLoading,
                child: SearchTextField(controller: controller),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
