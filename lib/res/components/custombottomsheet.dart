import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychoice/res/components/customtextbutton.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/custombuttons.dart';
import 'package:mychoice/viewmodel/control_pest_control_view/contro_pest_provider.dart';
import 'package:provider/provider.dart';

void showDescriptionBottomSheet(BuildContext context, String description) {
  showModalBottomSheet(
    backgroundColor: Appcolor.whitecolor,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Description",
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Appcolor.blackcolor,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Appcolor.blackcolor,
              ),
            ),
            SizedBox(height: 20.h),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Appcolor.primarycolor,
            //     minimumSize: Size(double.infinity, 50.h),
            //   ),
            //   child: Text(
            //     "Close",
            //     style: TextStyle(color: Appcolor.whitecolor),
            //   ),
            // ),
            ResumeButton(
              buttonText: "close",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}

// void showAmountBottomSheet(
//   BuildContext context,
//   String itemId,
//   String optionPlacename,
// ) {
//   final provider = Provider.of<ControPestProvider>(context, listen: false);
//   showModalBottomSheet(
//     backgroundColor: Appcolor.whitecolor,
//     context: context,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (context) {
//       return Container(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               "Select Additional Amount",
//               style: TextStyle(
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.bold,
//                 color: Appcolor.blackcolor,
//               ),
//             ),
//             SizedBox(height: 15.h),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 AppTextButton(
//                   text: "100",
//                   onTap: () {
//                     provider.updateAdditionalAmount(
//                       itemId,
//                       optionPlacename,
//                       100,
//                     );
//                     Navigator.pop(context);
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         backgroundColor: Appcolor.sucesscolor,
//                         content: Text(
//                           "You have selected 100, and your order order will be updated.",
//                           style: TextStyle(
//                             color: Appcolor.whitecolor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 AppTextButton(
//                   text: "200",
//                   onTap: () {
//                     provider.updateAdditionalAmount(
//                       itemId,
//                       optionPlacename,
//                       200,
//                     );
//                     Navigator.pop(context);
//                   },
//                 ),
//                 AppTextButton(
//                   text: "300",
//                   onTap: () {
//                     provider.updateAdditionalAmount(
//                       itemId,
//                       optionPlacename,
//                       100,
//                     );
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: 20.h),

//             ResumeButton(
//               buttonText: "Cancel",
//               onPressed: () {
//                 provider.updateAdditionalAmount(itemId, optionPlacename, 0);
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
