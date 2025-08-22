import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/customsearchbar.dart';
import 'package:mychoice/viewmodel/location_view/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
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
                            style: GoogleFonts.poppins(
                              color: Appcolor.whitecolor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            line2,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: Appcolor.whitecolor,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
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

              SizedBox(height: 20.h),

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
