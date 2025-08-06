import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/custombottomsheet.dart';
import 'package:mychoice/res/widgets/custompackagecard.dart';
import 'package:mychoice/res/widgets/customtopmenswidget.dart';
import 'package:mychoice/view/Timesedules/timesecdule.dart';
import 'package:mychoice/view/cart/Mencartscreen.dart';
import 'package:mychoice/viewmodel/addingmenspackages/adding_menspackagesprovider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class Descriptionscreen extends StatefulWidget {
  final String id;
  const Descriptionscreen({super.key, required this.id});

  @override
  State<Descriptionscreen> createState() => _DescriptionscreenState();
}

class _DescriptionscreenState extends State<Descriptionscreen> {
  late VideoPlayerController _videoPlayerController;
  bool startPlaying = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(
      'assets/vedios/mens_haircutting.mp4',
    );

    _videoPlayerController.addListener(() {
      if (startPlaying && !_videoPlayerController.value.isPlaying) {
        setState(() {});
      }
    });

    _videoPlayerController
        .initialize()
        .then((_) {
          setState(() {
            startPlaying = true;
          });
          _videoPlayerController.play();
        })
        .catchError((error) {
          print("Error initializing video: $error");
        });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812));
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder:
            (_, __) => [
              SliverToBoxAdapter(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 250.h,
                      width: double.infinity,
                      child:
                          _videoPlayerController.value.isInitialized
                              ? AspectRatio(
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio,
                                child: VideoPlayer(_videoPlayerController),
                              )
                              : Center(child: CircularProgressIndicator()),
                    ),
                    Positioned(
                      top: 50.h,
                      left: 20.w,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _videoPlayerController.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 48.sp,
                      ),
                      onPressed: () {
                        setState(() {
                          _videoPlayerController.value.isPlaying
                              ? _videoPlayerController.pause()
                              : _videoPlayerController.play();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.sp,
                  vertical: 10.dg,
                ),
                child: Text(
                  "Salon Prime",
                  style: TextStyle(
                    color: Appcolor.blackcolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "⭐ 4.85 (3.3M Bookings) ",
                  style: TextStyle(
                    color: Appcolor.blackcolor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.0.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Categaries',
                  style: TextStyle(
                    fontSize: 20,
                    color: Appcolor.blackcolor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Wrap(
                  spacing: 15.w,
                  runSpacing: 15.h,
                  children: [
                    TopServiceCategoryWidget(
                      title: 'Massage',
                      imageUrl:
                          'https://tse4.mm.bing.net/th/id/OIP.zmkPJBzXBnwOmio5wPd34gHaE8?pid=Api&P=0&h=180',
                    ),
                    TopServiceCategoryWidget(
                      title: 'Hair Cutting',
                      imageUrl:
                          'https://tse2.mm.bing.net/th/id/OIP.QQ5l9tWGjowB2CkMwMkV2wHaE8?pid=Api&P=0&h=180',
                    ),
                    TopServiceCategoryWidget(
                      title: 'Hair color',
                      imageUrl:
                          'https://tse3.mm.bing.net/th/id/OIP.DsQ0QdtMUWmvYPVq_DKlAgHaEK?pid=Api&P=0&h=180',
                    ),
                    TopServiceCategoryWidget(
                      title: 'Detan',
                      imageUrl:
                          'https://tse1.mm.bing.net/th/id/OIP.KHXs0uCJuE-hr-iVMh4MbwAAAA?pid=Api&P=0&h=180',
                    ),
                    TopServiceCategoryWidget(
                      title: 'Facial & Cleanup',
                      imageUrl:
                          'https://www.swagmee.com/media/wysiwyg/blog/Why_is_Facial_and_Clean_Up_Important_for_Men.jpg',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Pacakges',
                  style: TextStyle(
                    color: Appcolor.blackcolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              PackageCard(
                ontap: () {
                  FlexibleBottomSheet.show(
                    context: context,
                    initialHeight: 0.5,
                    minHeight: 0.0,
                    maxHeight: 0.9,
                    headerHeight: 56,
                    headerBuilder:
                        (context, offset) => Container(
                          color: Appcolor.primarycolor,
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Haircut & color',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                    bodyBuilder: (context, offset) {
                      return Consumer<AddingMenspackagesprovider>(
                        builder: (context, provider, child) {
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '• Service time: 60 mins',
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Haircut or color',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                CheckboxListTile(
                                  title: const Text('Haircut for men'),
                                  value: provider.isHaircutSelected,
                                  onChanged:
                                      (val) =>
                                          provider.toggleHaircut(val ?? false),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                                const Text(
                                  '₹259',
                                  style: TextStyle(fontSize: 14),
                                ),
                                CheckboxListTile(
                                  title: const Text(
                                    'Hair colour application only',
                                  ),
                                  value: provider.isHairColorSelected,
                                  onChanged:
                                      (val) => provider.toggleHairColor(
                                        val ?? false,
                                      ),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                                const Text(
                                  '₹199',
                                  style: TextStyle(fontSize: 14),
                                ),
                                CheckboxListTile(
                                  title: const Text(
                                    "I don't need haircut or color",
                                  ),
                                  value:
                                      !provider.isHaircutSelected &&
                                      !provider.isHairColorSelected,
                                  onChanged: null,
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Hair color (Garnier)',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                ...provider.availableHairColors
                                    .map(
                                      (color) => Column(
                                        children: [
                                          RadioListTile<String>(
                                            title: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    color == ''
                                                        ? "I don't need hair color Garnier"
                                                        : color +
                                                            (color ==
                                                                    'Brown black'
                                                                ? ' (shade 3)'
                                                                : color ==
                                                                    'Deep black'
                                                                ? ' (shade 1)'
                                                                : ' (shade 4)'),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(width: 5.0.dg),
                                                Text(
                                                  color == '' ? '₹0' : '₹299',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            value: color,
                                            groupValue:
                                                provider.selectedHairColor,
                                            onChanged:
                                                (val) => provider
                                                    .setSelectedHairColor(val),
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                                const SizedBox(height: 16),
                                if (provider.totalPrice <
                                    provider.originalPrice)
                                  Container(
                                    color: Appcolor.secondarycolor,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '🎉 You are saving ₹${provider.originalPrice - provider.totalPrice} in this package',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '₹${provider.totalPrice}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (provider.totalPrice <
                                        provider.originalPrice)
                                      Text(
                                        '₹${provider.originalPrice}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        print(
                                          "Subtotal before add: ${provider.subtotal}",
                                        );
                                        print(
                                          "TotalPrice before add: ${provider.totalPrice}",
                                        );
                                        await provider.addpackagecolor();
                                        if (!provider.isLoading) {
                                          final currentProvider = Provider.of<
                                            AddingMenspackagesprovider
                                          >(context, listen: false);
                                          print(
                                            "Subtotal after add: ${currentProvider.subtotal}",
                                          );
                                          print(
                                            "TotalPrice after add: ${currentProvider.totalPrice}",
                                          );
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => TimesecduleScreen(),
                                            ),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Appcolor.primarycolor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                        ),
                                      ),
                                      child:
                                          provider.isLoading
                                              ? const CircularProgressIndicator(
                                                padding: EdgeInsets.all(8.0),
                                                strokeWidth: 5.0,
                                                color: Appcolor.whitecolor,
                                              )
                                              : const Text(
                                                'Add to cart',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                title: 'Hair Cut',
                rating: 3.59,
                reviewCount: 2,
                price: 500,
                duration: '60mins',
                services: ['Hair cutting', 'Hair color'],
              ),
              PackageCard(
                ontap: () {},
                title: 'Facial and clean',
                rating: 3.59,
                reviewCount: 2,
                price: 3000,
                duration: '60mins',
                services: ['Face wash ', 'pedicure'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
