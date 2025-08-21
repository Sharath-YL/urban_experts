import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({Key? key}) : super(key: key);

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  int _current = 0;

  final List<String> imgList = [
    'https://tse1.mm.bing.net/th/id/OIP.x6R1CaquUXRHIwNCLsSF-AHaE7?pid=Api&P=0&h=180',
    'https://tse1.mm.bing.net/th/id/OIP.x6R1CaquUXRHIwNCLsSF-AHaE7?pid=Api&P=0&h=180',
    'https://tse3.mm.bing.net/th/id/OIP.KIZyFbNVIlvn41MHrMC1bgHaE8?pid=Api&P=0&h=180',
  ];

  final List<Widget> imageSliders = [
    Container(
      height: 90.0.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.loose,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            child: Image.network(
              'https://tse1.mm.bing.net/th/id/OIP.x6R1CaquUXRHIwNCLsSF-AHaE7?pid=Api&P=0&h=180',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
            top: 10.0,
            left: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [SizedBox(height: 40.0.h)],
            ),
          ),
        ],
      ),
    ),
    Container(
      height: 90.0.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
              children: [SizedBox(height: 40.0.h)],
            ),
          ),
        ],
      ),
    ),
    Container(
      height: 90.0.h,
      width: double.infinity,

      margin: EdgeInsets.all(5.0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            child: Image.network(
              'https://tse2.mm.bing.net/th/id/OIP.R2wA8hy63KfFMxQaVKkE4QHaEi?pid=Api&P=0&h=180',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
            top: 10.0,
            left: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
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
            aspectRatio: 16 / 8,
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
                  onTap: () => {},
                  child: Container(
                    width: 15.0,
                    height: 10.0,
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
