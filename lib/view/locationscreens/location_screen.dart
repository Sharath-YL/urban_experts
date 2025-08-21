import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychoice/view/home_screens/index_screens.dart';
import 'package:mychoice/viewmodel/location_view/location_provider.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Timer? _navTimer;
  bool _navScheduled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LocationProvider>(
        context,
        listen: false,
      ).getposition(context).catchError((e) {
        print("Error in initial location fetch: $e");
      });
    });
  }

  @override
  void dispose() {
    _navTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    if (!_navScheduled &&
        !locationProvider.isLoading &&
        locationProvider.address != null) {
      _navScheduled = true;
      _navTimer = Timer(const Duration(seconds: 5), () {
        if (!mounted) return;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder:
                (_) => IndexScreens(
                  pageController: PageController(initialPage: 0),
                ),
          ),
        );
      });
    }

    final addressText = locationProvider.address ?? "";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child:
              locationProvider.isLoading
                  ? _LoadingView()
                  : _DeliveredView(addressText: addressText),
        ),
      ),
    );
  }

  Widget _LoadingView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.my_location, size: 44, color: Colors.black87),
        SizedBox(height: 16.h),
        const SizedBox(
          height: 32,
          width: 32,
          child: CircularProgressIndicator(strokeWidth: 3),
        ),
        SizedBox(height: 16.h),
        Text(
          "We’re fetching your location…",
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _DeliveredView({required String addressText}) {
    final lines =
        addressText.isEmpty
            ? const <String>[]
            : addressText.split(RegExp(r',\s*')).fold<List<String>>([], (
              acc,
              chunk,
            ) {
              if (acc.isEmpty || acc.last.length > 26) {
                acc.add(chunk);
              } else {
                acc[acc.length - 1] = "${acc.last}, $chunk";
              }
              return acc;
            });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: const BoxDecoration(
                color: Color(0xFF2E7D32),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 8),
            Container(width: 3, height: 28, color: const Color(0xFF81C784)),
          ],
        ),
        SizedBox(height: 24.h),

        Text(
          "Delivering service at",
          style: GoogleFonts.poppins(
            color: const Color(0xFF2E7D32),
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.w),
          child: Text(
            lines.isEmpty ? addressText : lines.join("\n"),
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.black.withOpacity(0.6),
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
