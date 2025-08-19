import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/custombottomsheet.dart';
import 'package:mychoice/res/widgets/custompackagecard.dart';
import 'package:mychoice/res/widgets/customtopmenswidget.dart';
import 'package:mychoice/view/Timesedules/timesecdule.dart';
import 'package:mychoice/view/cleaning_pestcontrol_screens/cleaning_description_screen.dart';
import 'package:mychoice/view/cleaning_pestcontrol_screens/cleaning_pest_controlscreen.dart';
import 'package:mychoice/viewmodel/addingmenspackages/Cartprovider.dart';
import 'package:mychoice/viewmodel/homescreenview_model/homescreenview_provider.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:video_player/video_player.dart';

class Descriptionscreen extends StatefulWidget {
  final String id;
  const Descriptionscreen({super.key, required this.id});

  @override
  State<Descriptionscreen> createState() => _DescriptionscreenState();
}

class _DescriptionscreenState extends State<Descriptionscreen> {
  VideoPlayerController? _videoPlayerController;
  bool startPlaying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<HomescreenviewProvider>(
        context,
        listen: false,
      );
      // Initialize any required data here
    });
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    final homeProvider = Provider.of<HomescreenviewProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    final selectedModel = homeProvider.recentworkmodel.firstWhere(
      (item) => item.id == widget.id,
      orElse: () => throw Exception('ID not found'), 
      
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CircleAvatar(
            radius: 15,
            backgroundColor: Appcolor.greycolor,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Appcolor.blackcolor,
                size: 15,
              ),
            ),
          ),
        ),
        title: Text(
          selectedModel.title,
          style: TextStyle(
            color: Appcolor.blackcolor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      body: Skeletonizer(
        enabled: homeProvider.isloading || cartProvider.isLoading,
        child: Consumer2<HomescreenviewProvider, CartProvider>(
          builder: (context, homeProvider, cartprovider, child) {
            if (homeProvider.isloading || cartprovider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Appcolor.blackcolor),
              );
            }
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: Controlpestcontrol(
                title: selectedModel.title,
                subtitle: selectedModel.ratings,
                image: selectedModel.imageurl,
                ontap: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}





// tempory  


   // final selectedmodel = provider.recentworkmodel.firstWhere(
      //   (item) => item.id == widget.id,
      //   orElse: () => throw Exception('ID not found'),
      // );
      // _videoPlayerController = VideoPlayerController.asset(
      //   selectedmodel.videoUrl ?? "",
      // );

      // _videoPlayerController?.addListener(() {
      //   if (startPlaying && !_videoPlayerController!.value.isPlaying) {
      //     setState(() {});
      //   }
      // });

      // _videoPlayerController!
      //     .initialize()
      //     .then((_) {
      //       setState(() {
      //         startPlaying = true;
      //       });
      //       _videoPlayerController?.play();
      //     })
      //     .catchError((error) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(content: Text('Failed to load video: $error')),
      //       );
      //     });

  // body:
      // NestedScrollView(
      //   headerSliverBuilder:
      //       (_, __) => [
      //         SliverToBoxAdapter(
      //           child: Stack(
      //             alignment: Alignment.center,
      //             children: [
      //               Container(
      //                 height: 250.h,
      //                 width: double.infinity,
      //                 child:
      //                     _videoPlayerController != null &&
      //                             _videoPlayerController!.value.isInitialized
      //                         ? AspectRatio(
      //                           aspectRatio:
      //                               _videoPlayerController!.value.aspectRatio,
      //                           child: VideoPlayer(_videoPlayerController!),
      //                         )
      //                         : const Center(
      //                           child: CircularProgressIndicator(),
      //                         ),
      //               ),
      //               Positioned(
      //                 top: 50.h,
      //                 left: 20.w,
      //                 child: CircleAvatar(
      //                   backgroundColor: Colors.white,
      //                   child: IconButton(
      //                     icon: const Icon(
      //                       Icons.arrow_back,
      //                       color: Colors.black,
      //                     ),
      //                     onPressed: () => Navigator.pop(context),
      //                   ),
      //                 ),
      //               ),
      //               if (_videoPlayerController != null &&
      //                   _videoPlayerController!.value.isInitialized)
      //                 IconButton(
      //                   icon: Icon(
      //                     _videoPlayerController!.value.isPlaying
      //                         ? Icons.pause
      //                         : Icons.play_arrow,
      //                     color: Colors.white,
      //                     size: 48.sp,
      //                   ),
      //                   onPressed: () {
      //                     setState(() {
      //                       if (_videoPlayerController!.value.isPlaying) {
      //                         _videoPlayerController!.pause();
      //                       } else {
      //                         _videoPlayerController!.play();
      //                       }
      //                     });
      //                   },
      //                 ),
      //             ],
      //           ),
      //         ),
      //       ],



      
    // Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 10.sp),
    //   child: Text(
    //     selectedModel.ratings,
    //     style: TextStyle(
    //       color: Appcolor.blackcolor,
    //       fontWeight: FontWeight.bold,
    //     ),
    //   ),
    // ),
    // SizedBox(height: 10.h),
    // Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 10.sp),
    //   child: Text(
    //     'Categories',
    //     style: TextStyle(
    //       fontSize: 20.sp,
    //       color: Appcolor.blackcolor,
    //       fontWeight: FontWeight.bold,
    //     ),
    //   ),
    // ),
    // Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.h),
    //   child: Wrap(
    //     spacing: 10.w,
    //     runSpacing: 10.h,
    //     children:
    //         selectedModel.categories.map((category) {
    //           return TopServiceCategoryWidget(
    //             title: category['title'],
    //             imageUrl: category['imageUrl'],
    //           );
    //         }).toList(),
    //   ),
    // ),
    // Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 10.sp),
    //   child: Text(
    //     'Packages',
    //     style: TextStyle(
    //       color: Appcolor.blackcolor,
    //       fontWeight: FontWeight.bold,
    //       fontSize: 20.sp,
    //     ),
    //   ),
    // ),
    // SizedBox(height: 10.h),
    // ...selectedModel.packages.map((pkg) {
    //   return PackageCard(
    //     title: pkg["title"],
    //     rating: pkg['rating'],
    //     reviewCount: pkg['reviewCount'],
    //     price: pkg['price'],
    //     duration: pkg['duration'],
    //     services: List<String>.from(pkg['services']),
    //     ontap: () {
    //       FlexibleBottomSheets.show(
    //         context: context,
    //         initialHeight: 0.5,
    //         minHeight: 0.0,
    //         maxHeight: 0.9,
    //         headerHeight: 56,
    //         headerBuilder:
    //             (context, offset) => Container(
    //               color: Appcolor.primarycolor,
    //               padding: const EdgeInsets.all(16.0),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     pkg["title"] ?? '',
    //                     style: const TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                   GestureDetector(
    //                     onTap: () => Navigator.pop(context),
    //                     child: const Icon(
    //                       Icons.close,
    //                       color: Colors.white,
    //                       size: 24,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //         bodyBuilder: (context, offset) {
    //           Map<String, String> selectedOptions = {
    //             for (var option in pkg['options'] ?? [])
    //               option['type']:
    //                   (option['values'] as List).firstWhere(
    //                     (v) => v['price'] == 0,
    //                   )['label'],
    //           };
    //           int totalPrice = pkg['price'];
    //           int originalPrice = pkg['price'];

    //           return StatefulBuilder(
    //             builder: (context, setState) {
    //               return Container(
    //                 padding: const EdgeInsets.all(16.0),
    //                 child: Column(
    //                   mainAxisSize: MainAxisSize.min,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       '• Service time: ${pkg["duration"]}',
    //                       style: const TextStyle(fontSize: 14),
    //                     ),
    //                     const SizedBox(height: 16),
    //                     const Text(
    //                       'Package includes:',
    //                       style: TextStyle(
    //                         fontSize: 16,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                     ...List<String>.from(pkg['services']).map((
    //                       service,
    //                     ) {
    //                       return Padding(
    //                         padding: const EdgeInsets.symmetric(
    //                           vertical: 4.0,
    //                         ),
    //                         child: Row(
    //                           children: [
    //                             const Icon(
    //                               Icons.check,
    //                               size: 18,
    //                               color: Colors.green,
    //                             ),
    //                             const SizedBox(width: 6),
    //                             Expanded(child: Text(service)),
    //                           ],
    //                         ),
    //                       );
    //                     }),
    //                     const SizedBox(height: 16),
    //                     ...(pkg['options'] ?? []).map((option) {
    //                       final type = option['type'] as String;
    //                       final values =
    //                           option['values'] as List<dynamic>;
    //                       return Column(
    //                         crossAxisAlignment:
    //                             CrossAxisAlignment.start,
    //                         children: [
    //                           Text(
    //                             type,
    //                             style: const TextStyle(
    //                               fontSize: 16,
    //                               fontWeight: FontWeight.bold,
    //                             ),
    //                           ),
    //                           ...values.map((value) {
    //                             final label = value['label'] as String;
    //                             final price = value['price'] as int;
    //                             return CheckboxListTile(
    //                               title: Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   Expanded(child: Text(label)),
    //                                   Text('₹$price'),
    //                                 ],
    //                               ),
    //                               value: selectedOptions[type] == label,
    //                               onChanged: (bool? isSelected) {
    //                                 if (isSelected == true) {
    //                                   setState(() {
    //                                     final prevOption = values
    //                                         .firstWhere(
    //                                           (v) =>
    //                                               v['label'] ==
    //                                               selectedOptions[type],
    //                                           orElse:
    //                                               () => {'price': 0},
    //                                         );
    //                                     totalPrice =
    //                                         totalPrice -
    //                                         (prevOption['price']
    //                                             as int) +
    //                                         price;
    //                                     selectedOptions[type] = label;
    //                                   });
    //                                 }
    //                               },
    //                               controlAffinity:
    //                                   ListTileControlAffinity.leading,
    //                             );
    //                           }).toList(),
    //                           const SizedBox(height: 8),
    //                         ],
    //                       );
    //                     }).toList(),
    //                     if (totalPrice < originalPrice)
    //                       Container(
    //                         color: Appcolor.secondarycolor,
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: Text(
    //                           '🎉 You are saving ₹${originalPrice - totalPrice} in this package',
    //                           style: const TextStyle(
    //                             color: Colors.white,
    //                             fontSize: 14,
    //                           ),
    //                         ),
    //                       ),
    //                     const SizedBox(height: 8),
    //                     Row(
    //                       mainAxisAlignment:
    //                           MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Text(
    //                           '₹$totalPrice',
    //                           style: const TextStyle(
    //                             fontSize: 18,
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ),
    //                         if (totalPrice < originalPrice)
    //                           Text(
    //                             '₹$originalPrice',
    //                             style: const TextStyle(
    //                               fontSize: 14,
    //                               decoration:
    //                                   TextDecoration.lineThrough,
    //                             ),
    //                           ),
    //                         ElevatedButton(
    //                           onPressed: () async {
    //                             if (!homeProvider.isloading) {
    //                               await cartProvider.addPackageToCart(
    //                                 package: pkg,
    //                                 selectedOptions: selectedOptions,
    //                                 totalPrice: totalPrice,
    //                                 originalPrice: originalPrice,
    //                                 // imageurl: im
    //                               );
    //                               Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                   builder:
    //                                       (_) => TimesecduleScreen(),
    //                                 ),
    //                               );
    //                             }
    //                           },
    //                           style: ElevatedButton.styleFrom(
    //                             backgroundColor: Appcolor.primarycolor,
    //                             shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(
    //                                 8.0,
    //                               ),
    //                             ),
    //                           ),
    //                           child:
    //                               homeProvider.isloading
    //                                   ? const CircularProgressIndicator(
    //                                     strokeWidth: 2.0,
    //                                     valueColor:
    //                                         AlwaysStoppedAnimation<
    //                                           Color
    //                                         >(Colors.white),
    //                                   )
    //                                   : const Text(
    //                                     'Add to cart',
    //                                     style: TextStyle(
    //                                       color: Colors.white,
    //                                     ),
    //                                   ),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               );
    //             },
    //           );
    //         },
    //       );
    //     },
    //   );
    // }).toList(),
  
  