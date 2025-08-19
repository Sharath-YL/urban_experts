// control_pest_model.dart
import 'package:flutter/material.dart';

class PestOption {
  final String placename;
  final String subtitle;
  final String description;
  final int price;
  final String image;
  final int time;
  final String area;
  final String id;

  const PestOption({
    required this.placename,
    required this.id,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.image,
    required this.time,
    required this.area,
  });
}

class ControlPestModel {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final int price;
  final String image;
  final int time;
  final String area;
  final String placename;

  final List<PestOption> selectedOptions;

  ControlPestModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.image,
    required this.time,
    required this.area,
    required this.placename,
    this.selectedOptions = const [],
  });
}
