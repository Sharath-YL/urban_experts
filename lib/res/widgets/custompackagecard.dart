import 'dart:ui';

import 'package:flutter/material.dart' ;
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/utils/toastmessages.dart';

class PackageCard extends StatelessWidget {
  final String title;
  final double rating;
  final int reviewCount;
  final int price;
  final String duration;
  final List<String> services;
  final Color borderColor;
  final VoidCallback ontap;

  const PackageCard({
    required this.title,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.duration,
    required this.services,
    this.borderColor = Appcolor.primarycolor,
    Key? key,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Appcolor.primarycolor,
              Appcolor.blackcolor.withOpacity(0.8),
            ],
          ),

          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Appcolor.whitecolor,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Utils.flushbarSuccessMessage(
                        'order added to cart',
                        context,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.primarycolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16.0),
                  const SizedBox(width: 4.0),
                  Text(
                    '$rating (${reviewCount.toString()} reviews)',
                    style: const TextStyle(
                      color: Appcolor.whitecolor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                '₹$price • $duration',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Appcolor.whitecolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              ...services.map(
                (service) => Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    '• $service',
                    style: const TextStyle(
                      color: Appcolor.whitecolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Appcolor.whitecolor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Edit your package',
                    style: TextStyle(
                      color: Appcolor.whitecolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
