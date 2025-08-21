import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/view/auth_screens/loginscreen.dart';
import 'package:mychoice/viewmodel/theme_view/theme_view_model.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? _avatarBytes;

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final XFile? picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 75,
      );
      if (picked != null) {
        final bytes = await picked.readAsBytes();
        setState(() => _avatarBytes = bytes);
      }
    } catch (e) {}
  }

  Future<void> _showDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Appcolor.whitecolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titlePadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          title: Text(
            "Logout?",
            style: TextStyle(
              color: Appcolor.blackcolor,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: TextStyle(
              color: Appcolor.blackcolor.withOpacity(0.6),
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
            ),
          ),

          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Appcolor.greycolor.withOpacity(0.15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Appcolor.blackcolor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Appcolor.blackcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const Loginscreen()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        color: Appcolor.whitecolor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _showdeletedialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Appcolor.whitecolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titlePadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          title: Text(
            "Delete Account ?",
            style: TextStyle(
              color: Appcolor.blackcolor,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          content: Text(
            "Are you sure you want to Delete?",
            style: TextStyle(
              color: Appcolor.blackcolor.withOpacity(0.6),
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
            ),
          ),

          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Appcolor.greycolor.withOpacity(0.15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Appcolor.blackcolor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Appcolor.blackcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const Loginscreen()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        color: Appcolor.whitecolor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void showthemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return Consumer<ThemeViewModel>(
          builder: (context, themeVM, __) {
            final colorscheme = Theme.of(context).colorScheme;

            final groupValue =
                themeVM.issystemprefs
                    ? ThemeMode.system
                    : (themeVM.isDarkMode ? ThemeMode.dark : ThemeMode.light);

            return AlertDialog(
              backgroundColor: colorscheme.secondaryContainer,
              title: Text(
                'Select Theme',
                style: TextStyle(color: colorscheme.onSurface, fontSize: 15),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 20.0,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<ThemeMode>(
                    title: const Text(
                      'Light Theme',
                      style: TextStyle(fontSize: 13),
                    ),
                    value: ThemeMode.light,
                    groupValue: groupValue,
                    onChanged: (_) {
                      themeVM.issystemprefs = false;
                      themeVM.isDarkMode = false;
                      Navigator.pop(context);
                    },
                    activeColor: colorscheme.primary,
                    fillColor: MaterialStatePropertyAll(colorscheme.secondary),
                  ),
                  // RadioListTile<ThemeMode>(
                  //   title: const Text('Dark Theme', style: TextStyle(fontSize: 13)),
                  //   value: ThemeMode.dark,
                  //   groupValue: groupValue,
                  //   onChanged: (_) {
                  //     themeVM.issystemprefs = false;
                  //     themeVM.isDarkMode = true;
                  //     Navigator.pop(context);
                  //   },
                  //   activeColor: colorscheme.primary,
                  //   fillColor: MaterialStatePropertyAll(colorscheme.secondary),
                  // ),
                  RadioListTile<ThemeMode>(
                    title: const Text(
                      'System Preference',
                      style: TextStyle(fontSize: 13),
                    ),
                    value: ThemeMode.system,
                    groupValue: groupValue,
                    onChanged: (_) {
                      themeVM.isDarkMode = false;
                      themeVM.issystemprefs = true;
                      Navigator.pop(context);
                    },
                    activeColor: colorscheme.primary,
                    fillColor: MaterialStatePropertyAll(colorscheme.secondary),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBar(
                centerTitle: true,
                surfaceTintColor: Appcolor.whitecolor,

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
                  "Profile",
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              Card(
                color: Colors.white,
                elevation: 2,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            InkWell(
                              onTap: _pickImage,
                              borderRadius: BorderRadius.circular(100),
                              child: CircleAvatar(
                                radius: 50.r,
                                backgroundColor: Appcolor.greycolor.withOpacity(
                                  0.25,
                                ),
                                backgroundImage:
                                    _avatarBytes != null
                                        ? MemoryImage(_avatarBytes!)
                                        : null,
                                child:
                                    _avatarBytes == null
                                        ? Icon(
                                          Icons.person,
                                          size: 48.r,
                                          color: Appcolor.greycolor,
                                        )
                                        : null,
                              ),
                            ),

                            Positioned(
                              bottom: -2,
                              right: -2,
                              child: InkWell(
                                onTap: _pickImage,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  height: 36.r,
                                  width: 36.r,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 28.r,
                                    width: 28.r,
                                    decoration: BoxDecoration(
                                      color: Appcolor.blackcolor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.add_a_photo_rounded,
                                      color: Appcolor.whitecolor,
                                      size: 16.r,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12.h),
                      Text(
                        'Sharath yl',
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '+91 9686648194',
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'ylsharath809@gmail.com',
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5.h),

              _buildSectionCard(
                title: 'ACCOUNT',
                children: [
                  _buildListTile('Notification', Icons.notifications, () {
                    Navigator.pushNamed(context, RouteName.notificationscreen);
                  }),
                  _divider(),
                  _buildListTile('Edit Profile', Icons.edit, () {
                    Navigator.pushNamed(context, RouteName.editprofilescreen);
                  }),
                ],
              ),

              SizedBox(height: 12.h),

              _buildSectionCard(
                title: 'LEGAL',
                children: [
                  _buildListTile(
                    'Privacy Policy',
                    Icons.privacy_tip_outlined,
                    () {
                      Navigator.pushNamed(
                        context,
                        RouteName.privacypolicyscreen,
                      );
                    },
                  ),
                  _divider(),
                  _buildListTile('Terms of Service', Icons.gavel, () {
                    Navigator.pushNamed(context, RouteName.termsofservices);
                  }),
                ],
              ),

              SizedBox(height: 12.h),

              _buildSectionCard(
                title: 'SETTINGS',
                children: [
                  _buildListTile('Select Theme', Icons.settings, () {
                    showthemeDialog(context);
                  }),
                  _divider(),
                  _buildListTile('Log Out', Icons.logout, _showDialog),
                  _divider(),
                  _buildListTile(
                    'Delete Account',
                    Icons.delete,
                    _showdeletedialog,
                  ),
                ],
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Appcolor.greycolor.withOpacity(0.08),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _divider() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.w),
    child: Divider(
      height: 1.h,
      thickness: 0.8,
      color: Appcolor.greycolor.withOpacity(0.25),
    ),
  );

  Widget _buildListTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: Container(
        height: 40.h,
        width: 40.w,
        decoration: BoxDecoration(
          color: Appcolor.greycolor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Appcolor.blackcolor, size: 18.r),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Appcolor.blackcolor,
        size: 16.r,
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
