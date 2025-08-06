import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/constants/colors.dart';

class Custommostbookedservices extends StatefulWidget {
  const Custommostbookedservices({super.key});

  @override
  State<Custommostbookedservices> createState() =>
      _CustommostbookedservicesState();
}

class _CustommostbookedservicesState extends State<Custommostbookedservices> {
  int _currentIndex = 0;

  // List of service images
  final List<String> serviceImages = [
    "https://tse4.mm.bing.net/th/id/OIP.mZgBe1esdO_u81ju5DI-YwHaE7?pid=Api&P=0&h=180",
    "https://tse3.mm.bing.net/th/id/OIP.RDN06zToKAL3Lbx9B7OxJgHaDa?pid=Api&P=0&h=180",
    "https://tse3.mm.bing.net/th/id/OIP.KIZyFbNVIlvn41MHrMC1bgHaE8?pid=Api&P=0&h=180",
    "https://tse3.mm.bing.net/th/id/OIP.bLpJha5mn3nGDNYZ9MqgpAHaDt?pid=Api&P=0&h=180",
  ];

  // List of service data
  final List<Map<String, dynamic>> services = [
    {
      "title": "Pest control (includes utensil re...)",
      "rating": 4.79,
      "ratingCount": "113K",
      "price": "₹1,098",
    },
    {
      "title": "Apartment pest control (includes ut...)",
      "rating": 4.80,
      "ratingCount": "48K",
      "price": "₹1,498",
    },
    {"title": "Bec", "rating": 4.0, "ratingCount": "N/A", "price": "₹1.5"},
    {
      "title": "Cleaning & Pest Control",
      "rating": 4.5,
      "ratingCount": "75K",
      "price": "₹1,200",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0.sp, vertical: 5.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            "Most booked services",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Appcolor.blackcolor,
            ),
          ),
          SizedBox(height: 10.0.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(services.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(right: 15.0.w),
                  child: Container(
                    width: 150.w,
                    height: 220.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                      boxShadow: [
                        // BoxShadow(
                        //   color: Colors.grey.withOpacity(0.2),
                        //   spreadRadius: 2,
                        //   blurRadius: 4,
                        //   offset: const Offset(0, 2),
                        // ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(8.r),
                          ),
                          child: Image.network(
                            serviceImages[index],
                            height: 120.h,
                            width: 150.w,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.error,
                                size: 50.sp,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                services[index]["title"],
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Appcolor.blackcolor,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.0.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 4.0.w),
                                  Text(
                                    "${services[index]["rating"]} (${services[index]["ratingCount"]})",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.0.h),
                              Text(
                                services[index]["price"],
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
