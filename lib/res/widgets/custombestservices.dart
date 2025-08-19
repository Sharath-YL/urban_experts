import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/utils/routes/routes.dart';

class Custombestservices extends StatefulWidget {
  const Custombestservices({super.key});

  @override
  State<Custombestservices> createState() => _CustombestservicesState();
}

class _CustombestservicesState extends State<Custombestservices> {
  final List<String> serviceImages = [
    "assets/images/pexels-element5-973403.jpg",
    "assets/images/pexels-cottonbro-3997993.jpg",
    "assets/images/professional-washer-blue-uniform-washing-luxury-car-with-water-gun-open-air-car-wash.jpg",
    "https://images.pexels.com/photos/209271/pexels-photo-209271.jpeg",
  ];

  final List<Map<String, dynamic>> services = [
    {
      "title": "Salon",
      "rating": 4.79,
      "ratingCount": "113K",
      "price": "₹ 1,098",
    },
    {
      "title": "Massage Therapy",
      "rating": 4.80,
      "ratingCount": "48K",
      "price": "₹ 1,498",
    },
    {
      "title": "Bathroom Cleaning",
      "rating": 4.0,
      "ratingCount": "N/A",
      "price": "₹ 1,500",
    },
    {
      "title": "Car Cleaning",
      "rating": 4.5,
      "ratingCount": "75K",
      "price": "₹ 1,200",
    },
  ];

  bool _isNetwork(String src) {
    final uri = Uri.tryParse(src);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  Widget _buildImage(String src) {
    if (_isNetwork(src)) {
      return Image.network(
        src,
        fit: BoxFit.cover,
        errorBuilder:
            (_, __, ___) =>
                Icon(Icons.broken_image, size: 28.sp, color: Colors.grey),
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        },
      );
    }
    return Image.asset(
      src,
      fit: BoxFit.cover,
      errorBuilder:
          (_, __, ___) =>
              Icon(Icons.broken_image, size: 28.sp, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final clampedMQ = mq.copyWith(
      textScaleFactor: mq.textScaleFactor.clamp(0.8, 1.2),
    );

    return MediaQuery(
      data: clampedMQ,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: SizedBox(
          height: 260.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            separatorBuilder: (_, __) => SizedBox(width: 14.w),
            itemBuilder: (context, index) {
              final item = services[index];

              return ConstrainedBox(
                constraints: BoxConstraints(minWidth: 200.w, maxWidth: 240.w),
                child: Container(
                  width: 220.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        offset: const Offset(0, 6),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Stack(
                            children: [
                              AspectRatio(
                                aspectRatio: 16 / 10,
                                child: _buildImage(serviceImages[index]),
                              ),
                              Positioned(
                                left: 8,
                                bottom: 8,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.65),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        "${item["rating"]} • ${item["ratingCount"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 8,
                                bottom: 8,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Appcolor.primarycolor.withOpacity(
                                      0.95,
                                    ),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    item["price"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.5.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(12.w, 2.h, 12.w, 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["title"],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Appcolor.blackcolor,
                                  height: 1.2,
                                ),
                              ),
                              SizedBox(height: 6.h),

                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.verified,
                                    size: 16.sp,
                                    color: Appcolor.sucesscolor,
                                  ),
                                  SizedBox(width: 6.w),
                                  Flexible(
                                    child: Text(
                                      "Trusted professionals",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 11.5.sp,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const Spacer(),

                              SizedBox(
                                width: double.infinity,
                                height:
                                    38.h, // stable height prevents vertical overflow
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Appcolor.blackcolor,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    padding:
                                        EdgeInsets
                                            .zero, 
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                  onPressed: () { 
                                     Navigator.pushNamed(
                              context,
                              RouteName.cleaningpestcontrolscreen,
                            );
                                  },
                                  child: Text(
                                    "Book now",
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
