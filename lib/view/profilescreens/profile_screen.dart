import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/view/auth_screens/loginscreen.dart';
import 'package:mychoice/view/home_screens/index_screens.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _showdailog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Logout?",
            style: TextStyle(
              color: Appcolor.blackcolor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          content: Text(
            "Are you sure want to logout?",
            style: TextStyle(
              color: Appcolor.greycolor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 40.h,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Appcolor.primarycolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Appcolor.whitecolor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () async {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => Loginscreen()),
                      (Route) => false,
                    );
                  },
                  child: Container(
                    height: 40.h,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Appcolor.primarycolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          color: Appcolor.whitecolor,
                          fontSize: 10,
                        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),

            Container(
              height: 80.h,
              width: 80.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  image: NetworkImage(
                    "https://tse2.mm.bing.net/th/id/OIP.6MT8enO2sKdofIZiM9AS0AHaHa?pid=Api&P=0&h=180",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 12),

            const Text(
              'sharath',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const Text(
              'syalfreelance@gmail.com',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                ;
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
              ),
              child: const Text(
                'Edit Profile',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: ListView(
                children: [
                  // _buildListTile('My Booking', Icons.calendar_today, () {
                  //   Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder:
                  //           (_) => IndexScreens(
                  //             pageController: PageController(initialPage: 1),
                  //           ),
                  //     ),
                  //     (Route) => false,
                  //   );
                  // }),
                  Divider(thickness: 2, color: Appcolor.greycolor),
                  _buildListTile('Help Center', Icons.help_outline, () {}),
                  Divider(thickness: 2, color: Appcolor.greycolor),

                  _buildListTile("FAQ's", Icons.question_answer, () {}),
                  Divider(thickness: 2, color: Appcolor.greycolor),
                  _buildListTile(
                    'Privacy Policy',
                    Icons.privacy_tip_outlined,
                    () {},
                  ),
                  Divider(thickness: 2, color: Appcolor.greycolor),
                  _buildListTile(
                    'Logout',
                    Icons.logout,
                    // _logout,
                    () {
                      _showdailog();
                    },
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Appcolor.blackcolor,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      leading: Container(
        height: 35.h,
        width: 35.w,
        decoration: BoxDecoration(
          color: Appcolor.greycolor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Icon(icon, color: Appcolor.blackcolor, size: 15)),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Appcolor.blackcolor,
        size: 15,
      ),
      onTap: onTap,
    );
  }
}
