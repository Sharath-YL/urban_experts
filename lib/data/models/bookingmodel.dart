import 'package:flutter/material.dart';



class Booking {
  final String id;
  final String title;
  final double rating;
  final int price;
  final String duration;
  final String imageUrl;
  final String providerName;
  final String providerImageUrl;
  final String otp;
  final String service;
  final String dateTime;
  final String address;
  final List<TimelineItem> timeline;
  final String totalAmount;
  final String paymentMode;

  Booking({
    required this.id,
    required this.title,
    required this.rating,
    required this.price,
    required this.duration,
    required this.imageUrl,
    required this.providerName,
    required this.providerImageUrl,
    required this.otp,
    required this.service,
    required this.dateTime,
    required this.address,
    required this.timeline,
    required this.totalAmount,
    required this.paymentMode,
  });
}

class TimelineItem {
  final String event;
  final String time;

  TimelineItem({required this.event, required this.time});
}