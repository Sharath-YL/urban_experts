// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomContentWidget extends StatelessWidget {
//   final String title;
//   final String imagePath;
//   final VoidCallback onTap;

//   const CustomContentWidget({
//     super.key,
//     required this.title,
//     required this.imagePath,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 80.h,
//         margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.r),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.horizontal(
//                 left: Radius.circular(12.r),
//               ),
//               child: Image(
//                 image: NetworkImage(imagePath),
//                 height: 80.h,
//                 width: 100.w,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Container(
//                     height: 80.h,
//                     width: 100.w,
//                     color: Colors.grey[300],
//                     child: const Icon(Icons.error, color: Colors.red),
//                   );
//                 },
//                 loadingBuilder: (context, child, loadingProgress) {
//                   if (loadingProgress == null) return child;
//                   return Container(
//                     height: 80.h,
//                     width: 100.w,
//                     color: Colors.grey[200],
//                     child: const Center(child: CircularProgressIndicator()),
//                   );
//                 },
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




