import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/custombuttons.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({Key? key}) : super(key: key);

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  int _current = 0;

  final List<String> imgList = [
    'https://tse4.mm.bing.net/th/id/OIP.mZgBe1esdO_u81ju5DI-YwHaE7?pid=Api&P=0&h=180',
    'https://tse3.mm.bing.net/th/id/OIP.RDN06zToKAL3Lbx9B7OxJgHaDa?pid=Api&P=0&h=180',
    'https://tse3.mm.bing.net/th/id/OIP.KIZyFbNVIlvn41MHrMC1bgHaE8?pid=Api&P=0&h=180',
  ];

  final List<Widget> imageSliders = [
    Container(
      // margin: EdgeInsets.all(5.0),
      height: 100.0.h, 
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            // borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Image.network(
              'https://tse4.mm.bing.net/th/id/OIP.mZgBe1esdO_u81ju5DI-YwHaE7?pid=Api&P=0&h=180',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
            top: 10.0,
            left: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Women\s Salon &spa',
                  style: TextStyle(
                    color: Appcolor.whitecolor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0.h),
                Text(
                  "Starts with 6599",
                  style: TextStyle(
                    color: Appcolor.whitecolor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40.0.h),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2,
                    vertical: 2,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Appcolor.whitecolor,
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Book Now",
                      style: TextStyle(
                        color: Appcolor.blackcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    Container(
      width: double.infinity,

      margin: EdgeInsets.all(5.0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Image.network(
              'https://tse3.mm.bing.net/th/id/OIP.KIZyFbNVIlvn41MHrMC1bgHaE8?pid=Api&P=0&h=180',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
            top: 10.0,
            left: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transform your space\nwith wall panels',
                  style: TextStyle(
                    color: Appcolor.whitecolor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0.h),
                Text(
                  "Starts with 6599",
                  style: TextStyle(
                    color: Appcolor.whitecolor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0.h),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2,
                    vertical: 2,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Appcolor.whitecolor,
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Book Now",
                      style: TextStyle(
                        color: Appcolor.blackcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 16 / 9,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => {}, // Optional: jump to slide
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 4.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
