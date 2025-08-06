import 'package:flutter/material.dart';

class ThemeViewModel with ChangeNotifier {
  bool _isDarkMode = false;

  bool _issystemprefs = false;

  bool get isDarkMode => _isDarkMode;

  bool get issystemprefs => _issystemprefs;

  set isDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  set issystemprefs(bool value) {
    _issystemprefs = value;
    notifyListeners();
  }
}
