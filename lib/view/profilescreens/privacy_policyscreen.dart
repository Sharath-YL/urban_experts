import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychoice/res/constants/colors.dart';

class PrivacyPolicyscreen extends StatefulWidget {
  const PrivacyPolicyscreen({super.key});

  @override
  State<PrivacyPolicyscreen> createState() => _PrivacyPolicyscreenState();
}

class _PrivacyPolicyscreenState extends State<PrivacyPolicyscreen> {
  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Privacy policy",
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
                      'Privacy Policy for Urban Experts',
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
                      'Effective Date: 02 March 2025',
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
                      'Introduction',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'Welcome to Urban Experts. We respect your privacy and are committed to protecting the personal information you share with us. This Privacy Policy explains how we collect, use, disclose, and protect your information when you play our game, access our website, or use any other services related to Urban Experts (collectively referred to as "Services").',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'By using the Services, you agree to the collection and use of information in accordance with this policy.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Divider(color: Colors.grey, thickness: 0.4),
                    SizedBox(height: 5.0.h),
                    Text(
                      '1. Information We Collect',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'We collect the following types of information:',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Text(
                          'Personal Information: ',
                          style: TextStyle(
                            color: colorscheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'When you create an account, interact with our Services, or contact us, we may collect personal information such as your name, email address, and other contact details.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Text(
                          'Gameplay Data:  ',
                          style: TextStyle(
                            color: colorscheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'We collect data about your gameplay activity, such as in-game actions, achievements, progress, and scores.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Text(
                          'Device Information: ',
                          style: TextStyle(
                            color: colorscheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'We may collect information about the device you are using to access our game, such as the device type, operating system, IP address, and mobile network information.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Text(
                          'Cookies and Tracking Technologies:',
                          style: TextStyle(
                            color: colorscheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'We use cookies, web beacons, and other tracking technologies to enhance your experience and collect information about how you use our game and services. This helps us improve our game and deliver targeted advertisements (if applicable).',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Divider(color: Colors.grey, thickness: 0.4),
                    SizedBox(height: 5.0.h),
                    Text(
                      '2. How We Use Your Information',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'We use the information we collect for the following purposes:',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Expanded(
                          child: Text(
                            'To provide, maintain, and improve the Services.',
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
                            'To personalize your experience and deliver content tailored to your preferences.',
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
                            'To communicate with you, including sending game updates, promotional offers, or support responses.',
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
                            'To analyze game performance and user behavior to enhance gameplay and fix bugs.',
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
                            'To ensure the security and integrity of our game.',
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
                            'To comply with legal obligations.',
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
                      '3. Sharing Your Information',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'We may share your information in the following situations:',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Text(
                          'With Service Providers:',
                          style: TextStyle(
                            color: colorscheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'We may share your information with third-party vendors, contractors, or other service providers who perform services on our behalf, such as hosting, analytics, customer support, or advertising.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Text(
                          'Business Transfers:',
                          style: TextStyle(
                            color: colorscheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'In the event of a merger, acquisition, or sale of assets, your information may be transferred as part of the transaction.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Text(
                          'Legal Compliance : ',
                          style: TextStyle(
                            color: colorscheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'We may disclose your information if required to do so by law or in response to valid legal requests, such as subpoenas or government orders.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Divider(color: Colors.grey, thickness: 0.4),
                    SizedBox(height: 5.0.h),
                    Text(
                      '4. Data Security',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'We take reasonable measures to protect your information from unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet or electronic storage is completely secure, and we cannot guarantee the absolute security of your information.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Divider(color: Colors.grey, thickness: 0.4),
                    SizedBox(height: 5.0.h),
                    Text(
                      '5. Your Rights and Choices',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'Depending on your location, you may have the following rights:',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Text(
                          'Access and Update : ',
                          style: TextStyle(
                            color: colorscheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'You can access, update, or delete your personal information by logging into your account or contacting us directly.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Text(
                          'Opt-out of Communications:  ',
                          style: TextStyle(
                            color: colorscheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'You can unsubscribe from marketing emails or notifications by following the instructions in the email or adjusting your account settings.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 5.0.sp),
                        SizedBox(width: 5.0.w),
                        Text(
                          'Do Not Track : ',
                          style: TextStyle(
                            color: colorscheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Some browsers allow you to send a "Do Not Track" signal to websites, but we do not currently respond to such signals.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),

                    SizedBox(height: 5.0.h),
                    Divider(color: Colors.grey, thickness: 0.4),
                    SizedBox(height: 5.0.h),
                    Text(
                      '6. International Data Transfers',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'If you are accessing our Services from outside the country in which we are based, please note that your data may be transferred to, stored, and processed in a different country. By using our Services, you consent to the transfer of your data to these countries.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Divider(color: Colors.grey, thickness: 0.4),
                    SizedBox(height: 5.0.h),
                    Text(
                      '7. Changes to This Privacy Policy',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'We may update this Privacy Policy from time to time. When we make changes, we will post the updated policy on this page and update the effective date at the top. We encourage you to review this policy periodically to stay informed about how we are protecting your information.',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
                    ),
                    SizedBox(height: 5.0.h),
                    Divider(color: Colors.grey, thickness: 0.4),
                    SizedBox(height: 5.0.h),
                    Text(
                      '8. Contact Us',
                      style: TextStyle(
                        color: Appcolor.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Text(
                      'If you have any questions or concerns about this Privacy Policy or our practices, please contact us at:',
                      style: TextStyle(color: colorscheme.onPrimaryContainer),
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
                          'abc@gmail.com',
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
