import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/customapp_bar.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double progressValue = 0.5;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    const String username = "sharath";
    const String phone = "9686648194";
    const String profileImage =
        "https://tse3.mm.bing.net/th/id/OIP.RDN06zToKAL3Lbx9B7OxJgHaDa?pid=Api&P=0&h=180";
    // const String greenPoints = "150";
    // const String adoptedInitiatives = "5";
    // const String createdInitiatives = "2";

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Skeletonizer(
        enabled: isLoading,
        child: CustomSilverAppBar(
          backgroundwidget: ClipPath(
            clipper: CustomHeaderClipper(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 60.h),
              color: Appcolor.primarycolor,
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 120.w,
                          height: 120.w,
                          child: CircularProgressIndicator(
                            value: progressValue,
                            strokeWidth: 6.0,
                            color: Appcolor.primaryBrown,
                            backgroundColor: Colors.grey[300],
                          ),
                        ),
                        Container(
                          height: 100.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(
                              color: colorscheme.primary,
                              width: 0.8,
                            ),
                          ),
                          child:
                              profileImage.isEmpty
                                  ? Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 20.sp,
                                      color: Colors.white,
                                    ),
                                  )
                                  : ClipOval(
                                    child: Image.network(
                                      profileImage,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (
                                        context,
                                        child,
                                        loadingProgress,
                                      ) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value:
                                                loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        (loadingProgress
                                                                .expectedTotalBytes ??
                                                            1)
                                                    : null,
                                          ),
                                        );
                                      },
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return const Center(
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    username,
                    style: GoogleFonts.poppins(
                      letterSpacing: 1,
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    phone,
                    style: GoogleFonts.poppins(
                      letterSpacing: 1,
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InfoTile(
                          label: "my history",
                          icon: Icons.book,
                          ontap: () {
                            Navigator.pushNamed(
                              context,
                              RouteName.bookingscreen,
                            );
                          },
                        ),
                        // InfoTile(
                        //   label: "Adopted\nInitiative",
                        //   value: adoptedInitiatives,
                        // ),
                        InfoTile(
                          label: "Help & support",
                          icon: Icons.help,
                          ontap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bodypart: SingleChildScrollView(
            child: Container(
              color: colorscheme.surface,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.pushNamed(context, RoutesName.addInitiative);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: colorscheme.primaryContainer,
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(
                          width: 0.7,
                          color: Appcolor.primaryBrown,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Appcolor.primarycolor.withValues(alpha: 0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: FaIcon(
                              FontAwesomeIcons.pen,
                              color: Appcolor.primaryBrown,
                              size: 20.sp,
                            ),
                          ),
                          Container(
                            width: 240.w,
                            child: Text(
                              " My Accout",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: colorscheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 18.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 10.w,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorscheme.primaryContainer,
                      border: Border.all(
                        color: colorscheme.primaryContainer,
                        width: 0.1,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 20.h,
                              width: 6.w,
                              decoration: BoxDecoration(
                                color: Appcolor.primaryBrown,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(4.0),
                                  bottomRight: Radius.circular(4.0),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              "settings",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Appcolor.blackcolor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        InkWell(
                          onTap: () {
                            // Navigator.pushNamed(context, RoutesName.personaldetails);
                          },
                          child: FolderTile(
                            icon: FaIcon(
                              FontAwesomeIcons.addressBook,
                              color: Appcolor.primaryBrown,
                              size: 18.sp,
                            ),
                            title: "Edit Location",
                          ),
                        ),
                        SizedBox(height: 16.h),
                        InkWell(
                          onTap: () {
                            // Navigator.pushNamed(context, RoutesName.professionaldetails);
                          },
                          child: FolderTile(
                            icon: FaIcon(
                              FontAwesomeIcons.suitcase,
                              color: Appcolor.primaryBrown,
                              size: 18.sp,
                            ),
                            title: "My wallet",
                          ),
                        ),

                        SizedBox(height: 16.h),
                        InkWell(
                          onTap: () {
                            showThemeDialog(context);
                          },
                          child: FolderTile(
                            icon: FaIcon(
                              FontAwesomeIcons.circleHalfStroke,
                              color: Appcolor.primaryBrown,
                              size: 18.sp,
                            ),
                            title: "Select Theme",
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 25.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 10.w,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorscheme.primaryContainer,
                      border: Border.all(
                        color: colorscheme.primaryContainer,
                        width: 0.1,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 20.h,
                              width: 6.w,
                              decoration: BoxDecoration(
                                color: Appcolor.primaryBrown,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(4.0),
                                  bottomRight: Radius.circular(4.0),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              "Legal",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: colorscheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            // Navigator.pushNamed(context, RoutesName.privacypolicy);
                          },
                          child: FolderTile(
                            icon: FaIcon(
                              FontAwesomeIcons.shieldHalved,
                              color: Appcolor.primaryBrown,
                              size: 18.sp,
                            ),
                            title: "Privacy Policy",
                          ),
                        ),
                        SizedBox(height: 16.h),
                        InkWell(
                          onTap: () {
                            // Navigator.pushNamed(context, RoutesName.termsofservice);
                          },
                          child: FolderTile(
                            icon: FaIcon(
                              FontAwesomeIcons.handshake,
                              color: Appcolor.primaryBrown,
                              size: 18.sp,
                            ),
                            title: "Terms of Service",
                          ),
                        ),
                        SizedBox(height: 16.h),
                        InkWell(
                          onTap: () {
                            // Navigator.pushNamed(context, RoutesName.helpsupport);
                          },
                          child: FolderTile(
                            icon: FaIcon(
                              FontAwesomeIcons.question,
                              color: Appcolor.primaryBrown,
                              size: 18.sp,
                            ),
                            title: "Help & Support",
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 25.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 10.w,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorscheme.primaryContainer,
                      border: Border.all(
                        color: colorscheme.primaryContainer,
                        width: 0.1,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   children: [
                        //     Container(
                        //       height: 20.h,
                        //       width: 6.w,
                        //       decoration: BoxDecoration(
                        //         color: Appcolor.primaryBrown,
                        //         borderRadius: const BorderRadius.only(
                        //           topRight: Radius.circular(4.0),
                        //           bottomRight: Radius.circular(4.0),
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(width: 8.w),
                        //     // Text(
                        //     //   "Settings",
                        //     //   style: TextStyle(
                        //     //     fontSize: 18.sp,
                        //     //     fontWeight: FontWeight.bold,
                        //     //     color: colorscheme.onSurface,
                        //     //   ),
                        //     // ),
                        //   ],
                        // ),
                        // SizedBox(height: 16.h),

                        // SizedBox(height: 16.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        colorscheme.primaryContainer,
                                    title: Text(
                                      'Are you sure you want to logout?',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: colorscheme.onPrimaryContainer,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Appcolor.sucesscolor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        onPressed:
                                            () => Navigator.of(context).pop(),
                                      ),
                                      TextButton(
                                        child: Text(
                                          'Logout',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Appcolor.errorcolor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: 55.h,
                              width: 360.sp,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Appcolor.blackcolor,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: Appcolor.errorcolor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          title: ClipPath(
            clipper: CustomHeaderClipper(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 50.h),
              color: Appcolor.primarycolor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 90.w,
                            height: 90.w,
                            child: CircularProgressIndicator(
                              value: progressValue,
                              strokeWidth: 4.0,
                              color: Appcolor.primaryBrown,
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                          Container(
                            height: 80.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              border: Border.all(
                                color: colorscheme.primary,
                                width: 0.8,
                              ),
                            ),
                            child:
                                profileImage.isEmpty
                                    ? Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.user,
                                        size: 20.sp,
                                        color: Colors.white,
                                      ),
                                    )
                                    : ClipOval(
                                      child: Image.network(
                                        profileImage,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (
                                          context,
                                          child,
                                          loadingProgress,
                                        ) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value:
                                                  loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          (loadingProgress
                                                                  .expectedTotalBytes ??
                                                              1)
                                                      : null,
                                            ),
                                          );
                                        },
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return const Center(
                                            child: Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      username,
                      style: GoogleFonts.poppins(
                        letterSpacing: 1,
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      phone,
                      style: GoogleFonts.poppins(
                        letterSpacing: 1,
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          height: 400.h,
          leading: false,
          toolbarheight: 210.h,
        ),
      ),
    );
  }
}

class CustomHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback ontap;

  const InfoTile({
    required this.icon,
    required this.label,
    super.key,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white70),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: Colors.white),
            SizedBox(height: 4.0),
            Text(
              textAlign: TextAlign.center,
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FolderTile extends StatelessWidget {
  final FaIcon icon;
  final String title;

  const FolderTile({required this.title, super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.h),
      decoration: BoxDecoration(
        color: colorscheme.primaryContainer,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(width: 0.7, color: Appcolor.blackcolor),
        boxShadow: [
          BoxShadow(
            color: Appcolor.blackcolor.withValues(alpha: 0.2),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 10.w), child: icon),
          Container(
            width: 240.w,
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: colorscheme.onPrimaryContainer,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Icon(Icons.arrow_forward_ios_rounded, size: 18.sp),
          ),
        ],
      ),
    );
  }
}

void showThemeDialog(BuildContext context) {
  final colorscheme = Theme.of(context).colorScheme;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: colorscheme.secondaryContainer,
        title: Text(
          'Select Theme',
          style: TextStyle(color: colorscheme.onSurface),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 20.0),
        content: SingleChildScrollView(
          child: SizedBox(
            height: 200.h,
            width: 200.w,
            child: Column(
              children: [
                RadioListTile<ThemeMode>(
                  title: const Text('Light Theme'),
                  value: ThemeMode.light,
                  groupValue: ThemeMode.light,
                  onChanged: (ThemeMode? value) {},
                  activeColor: colorscheme.primary,
                  fillColor: MaterialStateProperty.all(colorscheme.secondary),
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Dark Theme'),
                  value: ThemeMode.dark,
                  groupValue: ThemeMode.light,
                  onChanged: (ThemeMode? value) {},
                  activeColor: colorscheme.primary,
                  fillColor: MaterialStateProperty.all(colorscheme.secondary),
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('System Preference'),
                  value: ThemeMode.system,
                  groupValue: ThemeMode.light,
                  onChanged: (ThemeMode? value) {},
                  activeColor: colorscheme.primary,
                  fillColor: MaterialStateProperty.all(colorscheme.secondary),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
