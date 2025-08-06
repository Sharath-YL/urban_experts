import 'package:flutter/material.dart';

class ProfileViewProvider with ChangeNotifier {
  bool _islaoding = false;

  bool get islaoding => _islaoding;

  String _uername = " ";

  String get uername => _uername;

  set uername(String value) {
    _uername = value;
    notifyListeners();
  }

  set islaoding(bool value) {
    _islaoding = value;
    notifyListeners();
  }
}
