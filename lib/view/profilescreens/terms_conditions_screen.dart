import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/view/profilescreens/privacy_policyscreen.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Terms of Service",
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorscheme.surface,
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: colorscheme.primaryContainer,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0).r,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          decoration: BoxDecoration(
            color:
                colorscheme.brightness == Brightness.dark
                    ? colorscheme.onPrimaryFixed
                    : Colors.grey[200],
            border: Border.all(color: colorscheme.secondary, width: 0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15.0).r,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorscheme.primaryContainer,
                  borderRadius:
                      BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ).r,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Terms of service for Urban Experts',
                      style: GoogleFonts.poppins(
                        color:
                            colorscheme.brightness == Brightness.dark
                                ? colorscheme.onPrimaryContainer
                                : colorscheme.onPrimaryContainer,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'Effective Date: 20 December 2025',
                      style: GoogleFonts.poppins(
                        color:
                            colorscheme.brightness == Brightness.dark
                                ? colorscheme.onPrimaryContainer
                                : colorscheme.onPrimaryContainer,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Divider(color: Colors.grey, thickness: 0.4),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0).r,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorscheme.primaryContainer,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1 . Introduction',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'Welcome to Urban Experts, These Terms of Service ("Terms") govern your access to and use of our Experts, including all features, updates, and content provided therein (collectively, the “Service”).',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'By accessing or using the Game, you agree to be bound by these Terms. If you do not agree with these Terms, you should not use the Service.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Divider(color: Colors.grey, thickness: 0.4),
                    SizedBox(height: 5.0.h),
                    Text(
                      '2. Changes to Terms of Service',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'We may update or modify these Terms from time to time. When we make changes, we will post the updated Terms on this page and update the “Effective Date” at the top. We encourage you to review these Terms regularly to stay informed about any changes. Your continued use of the Game after changes are made constitutes your acceptance of the updated Terms.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Divider(color: Colors.grey, thickness: 0.4),
                    SizedBox(height: 5.0.h),
                    Text(
                      '3. User Accounts',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'To access certain features of the Game, you may be required to create an account. When creating an account, you agree to:',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Expanded(
                          child: Text(
                            'Provide accurate and complete information during registration.',
                            style: TextStyle(
                              color: colorscheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Expanded(
                          child: Text(
                            'Maintain the confidentiality of your account credentials and take full responsibility for all activities that occur under your account.',
                            style: TextStyle(
                              color: colorscheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Expanded(
                          child: Text(
                            'Notify us immediately if you suspect any unauthorized access or use of your account.',
                            style: TextStyle(
                              color: colorscheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'You agree that you will not create more than one account for personal use, and you will not impersonate any person or entity, or misrepresent your affiliation with any person or entity. ',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Divider(color: Colors.grey, thickness: 0.4),
                    SizedBox(height: 5.0.h),
                    Text(
                      '4. Use of the Urban Experts',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'By using the Game, you agree to:',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Expanded(
                          child: Text(
                            'Use the Game for lawful purposes only.',
                            style: TextStyle(
                              color: colorscheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Expanded(
                          child: Text(
                            'Not engage in any conduct that could damage, disable, overburden, or impair the Game’s services.',
                            style: TextStyle(
                              color: colorscheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Expanded(
                          child: Text(
                            'Not interfere with or disrupt any part of the Game, including servers, networks, or any other systems that provide the Game’s services.',
                            style: TextStyle(
                              color: colorscheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0.h),
                    Text(
                      'You also agree to refrain from:',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Expanded(
                          child: Text(
                            'Cheating, hacking, or using unauthorized third-party software.',
                            style: TextStyle(
                              color: colorscheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Expanded(
                          child: Text(
                            'Posting or transmitting any content that violates the rights of others, is unlawful, abusive, defamatory, obscene, or harmful.',
                            style: TextStyle(
                              color: colorscheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Expanded(
                          child: Text(
                            'Attempting to reverse-engineer, decompile, or disassemble the Game.',
                            style: TextStyle(
                              color: colorscheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0.h),
                    Divider(color: Colors.grey, thickness: 0.4),
                    SizedBox(height: 5.0.h),
                    Text(
                      '5. User Content',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'You may be allowed to upload or post content while using the Game, such as game progress, screenshots, and other content (collectively, “User Content”). By submitting User Content, you grant us a worldwide, royalty-free, transferable license to use, display, modify, and distribute the content in connection with the Game and its promotion.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 10.0.h),
                    Text(
                      'You retain ownership of your User Content, but you are solely responsible for the content you upload. You agree that you will not post any User Content that infringes upon the intellectual property rights of others or violates applicable laws.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Divider(color: Colors.grey, thickness: 0.4),
                    SizedBox(height: 5.0.h),
                    Text(
                      '6. Privacy Policy',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'Your privacy is important to us. Our Privacy Policy outlines how we collect, use, and protect your personal information when you use the Game. By using the Game, you consent to the collection and use of your information as described in our Privacy Policy.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'Please read our Privacy Policy here : ',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PrivacyPolicyscreen(),
                          ),
                        );
                      },
                      child: Text(
                        'privacy policy',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Divider(color: Colors.grey, thickness: 0.4),
                    SizedBox(height: 5.0.h),
                    Text(
                      "7. Payments and Virtual Items",
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'The Game may offer paid content or in-game purchases, such as virtual currency, items, or other premium features ("Paid Features"). If you make any purchases, you agree to pay all applicable fees and taxes associated with such purchases.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'Purchases of virtual items are non-refundable, and virtual items have no monetary value outside of the Game. We reserve the right to modify, suspend, or discontinue any Paid Features at any time without notice.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Divider(color: Colors.grey, thickness: 0.4),
                    SizedBox(height: 5.0.h),
                    Text(
                      '8. Termination',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'We may suspend or terminate your access to the Game at any time, with or without notice, for reasons including, but not limited to:',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Expanded(
                          child: Text(
                            'Violation of these Terms.',
                            style: TextStyle(
                              color: colorscheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Expanded(
                          child: Text(
                            'Engaging in fraudulent, illegal, or abusive activity.',
                            style: TextStyle(
                              color: colorscheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Expanded(
                          child: Text(
                            'Technical issues or maintenance requirements that necessitate a temporary shutdown of the Game.',
                            style: TextStyle(
                              color: colorscheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'Upon termination, your right to access the Game will immediately cease, and you must discontinue use of the Service.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Divider(color: Colors.grey, thickness: 0.4),
                    SizedBox(height: 5.0.h),
                    Text(
                      '9. Disclaimers and Limitations of Liability',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'To the fullest extent permitted by law, the Game is provided “as is” and "as available" without warranties of any kind, either express or implied. We do not guarantee that the Game will be uninterrupted, error-free, or free from viruses or other harmful components.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'We are not liable for any damages arising from your use or inability to use the Game, including direct, indirect, incidental, special, consequential, or punitive damages.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Divider(color: Colors.grey, thickness: 0.4),
                    SizedBox(height: 5.0.h),
                    Text(
                      '10. Indemnification',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'You agree to indemnify and hold harmless Urban Experts and its affiliates, employees, agents, and licensors from any claims, damages, losses, or expenses arising from your violation of these Terms or your use of the Game.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Divider(color: Colors.grey, thickness: 0.4),
                    SizedBox(height: 5.0.h),
                    Text(
                      '11. Governing Law',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'These Terms are governed by and construed in accordance with the laws of [Insert Jurisdiction], without regard to its conflict of law principles. Any disputes arising out of or relating to these Terms will be resolved in the competent courts of  Jurisdiction.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Divider(color: Colors.grey, thickness: 0.4),
                    SizedBox(height: 5.0.h),
                    Text(
                      '12. Contact Us ',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Text(
                          'Email : ',
                          style: TextStyle(
                            color:
                                colorscheme.brightness == Brightness.dark
                                    ? colorscheme.onPrimaryContainer
                                    : colorscheme.onPrimaryContainer,
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Ylsharath@gmail.com',
                          style: TextStyle(
                            color: colorscheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Text(
                          'Address : ',
                          style: TextStyle(
                            color:
                                colorscheme.brightness == Brightness.dark
                                    ? colorscheme.onPrimaryContainer
                                    : colorscheme.onPrimaryContainer,
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Bangalore,Karnataka',
                          style: TextStyle(
                            color: colorscheme.onPrimaryContainer,
                          ),
                        ),
                      ],
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
}
