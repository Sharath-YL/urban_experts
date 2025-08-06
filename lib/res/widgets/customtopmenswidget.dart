import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopServiceCategoryWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback? onTap;

  const TopServiceCategoryWidget({
    super.key,
    required this.title,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 100.h,
            width: 100.h,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          SizedBox(
            width: 70.w,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.sp,fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
