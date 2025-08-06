import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showExitPopUp(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.black,
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 1.h, top: 1.h),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xFFcdcdcd).withOpacity(0.7),
                  width: 0.4,
                ),
                top: BorderSide(
                  color: const Color(0xFFcdcdcd).withOpacity(0.7),
                  width: 0.4,
                ),
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 10.w),
                    Text(
                      'Leaving so soon',
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: const Text("❓", style: TextStyle(fontSize: 20.0)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              ('Using the app...');
            },
            child: Card(
              color: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
                width: 260,
                height: 50,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.black],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("😀", style: TextStyle(fontSize: 20.0)),
                    SizedBox(width: 8),
                    Text(
                      'Use App',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          GestureDetector(
            onTap: () {
              SystemNavigator.pop();
              ('Exiting the app...');
            },
            child: Card(
              color: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
                width: 260,
                height: 50,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.black],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("🙁", style: TextStyle(fontSize: 20.0)),
                    SizedBox(width: 8),
                    Text(
                      'Exit App',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      );
    },
  );
}
