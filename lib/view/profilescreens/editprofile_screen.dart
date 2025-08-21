import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychoice/res/components/customtextbutton.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/custombuttons.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/view/home_screens/index_screens.dart';

class EditprofileScreen extends StatefulWidget {
  const EditprofileScreen({super.key});

  @override
  State<EditprofileScreen> createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditprofileScreen> {
  final formKey = GlobalKey<FormState>();

  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();

  @override
  void dispose() {
    nameC.dispose();
    emailC.dispose();
    phoneC.dispose();
    super.dispose();
  }

  String? _validateName(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter your name';
    if (v.trim().length < 2) return 'Name is too short';
    return null;
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter your email';
    final emailReg = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$');
    if (!emailReg.hasMatch(v.trim())) return 'Enter a valid email';
    return null;
  }

  String? _validatePhone(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter your phone';
    final digits = v.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 10) return 'Enter at least 10 digits';
    return null;
  }

  void _save() {
    FocusScope.of(context).unfocus();
    if (formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green.shade600,
          content: const Text('Profile updated successfully'),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.whitecolor,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Appcolor.whitecolor.withOpacity(0.2),
                      Appcolor.blackcolor.withOpacity(0.2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
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
                      'Edit Profile',
                      style: GoogleFonts.poppins(
                        color: Appcolor.blackcolor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Positioned.fill(
              top: 70.h,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  children: [
                    SizedBox(height: 14.h),

                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      elevation: 8,
                      shadowColor: Appcolor.blackcolor.withOpacity(0.12),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 20.h,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ResumeTextfield(
                                label: 'Full Name',
                                hint: 'Enter your name',
                                controller: nameC,
                                textInputAction: TextInputAction.next,
                                prefixIcon: const Icon(
                                  Icons.person_rounded,
                                  color: Appcolor.blackcolor,
                                ),
                                validator: _validateName,
                              ),
                              ResumeTextfield(
                                label: 'Email',
                                hint: 'example@mail.com',
                                controller: emailC,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                prefixIcon: const Icon(
                                  Icons.email_rounded,
                                  color: Appcolor.blackcolor,
                                ),
                                validator: _validateEmail,
                                suffixIcon:
                                    (emailC.text.isNotEmpty)
                                        ? IconButton(
                                          tooltip: 'Clear',
                                          onPressed: () {
                                            emailC.clear();
                                            setState(() {});
                                          },
                                          icon: const Icon(Icons.clear_rounded),
                                        )
                                        : null,
                                onChanged: (_) => setState(() {}),
                              ),
                              ResumeTextfield(
                                label: 'Phone',
                                hint: 'Enter phone number',
                                controller: phoneC,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.done,
                                prefixIcon: const Icon(
                                  Icons.phone_rounded,
                                  color: Appcolor.blackcolor,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9+\-\s]'),
                                  ),
                                ],
                                validator: _validatePhone,
                              ),
                              SizedBox(height: 8.h),
                              ResumeButton(
                                buttonText: "Save & Continue",
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => IndexScreens(
                                            pageController: PageController(
                                              initialPage: 3,
                                            ),
                                          ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
