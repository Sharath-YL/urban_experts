import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/view/bookings/booking_screens.dart';
import 'package:mychoice/view/home_screens/home_screen.dart';
import 'package:mychoice/view/historyscreens/history_screen.dart';
import 'package:mychoice/view/profilescreens/profile_screen.dart';
import 'package:mychoice/viewmodel/bottomview_model/bottomview_provider.dart';
import 'package:provider/provider.dart';

class IndexScreens extends StatefulWidget {
  final PageController pageController;

  const IndexScreens({super.key, required this.pageController});

  @override
  State<IndexScreens> createState() => _IndexScreensState();
}

class _IndexScreensState extends State<IndexScreens> {
  DateTime? _lastBackPressTime;

  final List<String> labels = ["Home", "Bookings", "History", "Profile"];
  final List<IconData> icons = [
    Icons.home,
    Icons.book_online,
    Icons.history,
    Icons.person,
  ];

  final List<Widget> _screens = [
    const HomeScreen(),
    const BookingScreens(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final initial = widget.pageController.initialPage;
      context.read<BottomnavViewModel>().navindex = initial;
    });
  }

  @override
  void dispose() {
    widget.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomnavViewModel>(
      builder: (context, bottomNavProvider, child) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: PageView(
              controller: widget.pageController,
              onPageChanged: (index) {
                bottomNavProvider.navindex = index;
              },
              children: _screens,
            ),
            bottomNavigationBar: FlashyTabBar(
              animationDuration: const Duration(milliseconds: 300),
              selectedIndex: bottomNavProvider.navindex,
              showElevation: true,
              backgroundColor: Appcolor.whitecolor,
              items: List.generate(labels.length, (index) {
                return FlashyTabBarItem(
                  icon: Icon(
                    icons[index],
                    size: bottomNavProvider.navindex == index ? 22.sp : 20.sp,
                    color:
                        bottomNavProvider.navindex == index
                            ? Appcolor.blackcolor
                            : Colors.grey,
                  ),
                  title: Text(
                    labels[index],
                    style: GoogleFonts.poppins(
                      fontSize:
                          bottomNavProvider.navindex == index ? 14.sp : 12.sp,
                      fontWeight: FontWeight.bold,
                      color:
                          bottomNavProvider.navindex == index
                              ? Appcolor.blackcolor
                              : Colors.grey,
                    ),
                  ),
                );
              }),
              onItemSelected: (index) {
                bottomNavProvider.navindex = index;
                widget.pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
