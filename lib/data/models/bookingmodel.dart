import 'package:flutter/material.dart';

class Booking {
  final String id;
  final String title;
  final double rating;
  final int? price;
  final String duration;
  final String imageurl;
  final String providerName;
  final String status;
  final String providerImageUrl;
  final String otp;
  final String service;
  final String dateTime;
  final String address;
  final List<TimelineItem> timeline;
  final String totalAmount;
  final String paymentMode;
  final String location;
  final List<Map<String, dynamic>> selectedOptions;
  final bool isPestControl;

  final List<Map<String, dynamic>> extraWork;
  final bool extraWorkApproved;

  const Booking({
    required this.id,
    required this.title,
    required this.status,
    required this.rating,
     this.price,
    required this.duration,
    required this.imageurl,
    required this.providerName,
    required this.providerImageUrl,
    required this.location,
    required this.selectedOptions,
    required this.otp,
    required this.service,
    required this.dateTime,
    required this.address,
    required this.timeline,
    required this.totalAmount,
    required this.paymentMode,
    this.isPestControl = false,
    this.extraWork = const [],
    this.extraWorkApproved = false,
  });

  Booking copyWith({
    String? id,
    String? title,
    double? rating,
    int? price,
    String? duration,
    String? imageurl,
    String? providerName,
    String? status,
    String? providerImageUrl,
    String? otp,
    String? service,
    String? dateTime,
    String? address,
    List<TimelineItem>? timeline,
    String? totalAmount,
    String? paymentMode,
    String? location,
    List<Map<String, dynamic>>? selectedOptions,
    bool? isPestControl,
    List<Map<String, dynamic>>? extraWork,
    bool? extraWorkApproved,
  }) {
    return Booking(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      duration: duration ?? this.duration,
      imageurl: imageurl ?? this.imageurl,
      providerName: providerName ?? this.providerName,
      providerImageUrl: providerImageUrl ?? this.providerImageUrl,
      otp: otp ?? this.otp,
      service: service ?? this.service,
      dateTime: dateTime ?? this.dateTime,
      address: address ?? this.address,
      timeline: timeline ?? this.timeline,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentMode: paymentMode ?? this.paymentMode,
      location: location ?? this.location,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      isPestControl: isPestControl ?? this.isPestControl,
      extraWork: extraWork ?? this.extraWork,
      extraWorkApproved: extraWorkApproved ?? this.extraWorkApproved,
    );
  }

  factory Booking.fromJson(Map<String, dynamic> j) {
    List<TimelineItem> parseTimeline(dynamic value) {
      final list = (value is List) ? value : const [];
      return list
          .where((e) => e is Map)
          .map(
            (e) => TimelineItem.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList();
    }

    List<Map<String, dynamic>> parseMapList(dynamic value) {
      final list = (value is List) ? value : const [];
      return list
          .where((e) => e is Map)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
    }

    return Booking(
      id: (j['id'] ?? '').toString(),
      title: (j['title'] ?? '').toString(),
      status: (j['status'] ?? 'Pending').toString(),
      rating: (j['rating'] is num) ? (j['rating'] as num).toDouble() : 0.0,
      price: (j['price'] is num) ? (j['price'] as num).toInt() : 0,
      duration: (j['duration'] ?? '').toString(),
      imageurl: (j['imageurl'] ?? '').toString(),
      providerName: (j['providerName'] ?? '').toString(),
      providerImageUrl: (j['providerImageUrl'] ?? '').toString(),
      otp: (j['otp'] ?? '').toString(),
      service: (j['service'] ?? '').toString(),
      dateTime: (j['dateTime'] ?? '').toString(),
      address: (j['address'] ?? '').toString(),
      timeline: parseTimeline(j['timeline']),
      totalAmount: (j['totalAmount'] ?? '₹0.00').toString(),
      paymentMode: (j['paymentMode'] ?? '').toString(),
      location: (j['location'] ?? '').toString(),
      selectedOptions: parseMapList(j['selectedOptions']),
      isPestControl: j['isPestControl'] == true,
      extraWork: parseMapList(j['extraWork']),
      extraWorkApproved: j['extraWorkApproved'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
      'rating': rating,
      'price': price,
      'duration': duration,
      'imageurl': imageurl,
      'providerName': providerName,
      'providerImageUrl': providerImageUrl,
      'otp': otp,
      'service': service,
      'dateTime': dateTime,
      'address': address,
      'timeline': timeline.map((e) => e.toJson()).toList(),
      'totalAmount': totalAmount,
      'paymentMode': paymentMode,
      'location': location,
      'selectedOptions': selectedOptions,
      'isPestControl': isPestControl,
      'extraWork': extraWork,
      'extraWorkApproved': extraWorkApproved,
    };
  }
}

class TimelineItem {
  final String event;
  final String time;

  const TimelineItem({required this.event, required this.time});

  factory TimelineItem.fromJson(Map<String, dynamic> j) {
    return TimelineItem(
      event: (j['event'] ?? '').toString(),
      time: (j['time'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {'event': event, 'time': time};
}
