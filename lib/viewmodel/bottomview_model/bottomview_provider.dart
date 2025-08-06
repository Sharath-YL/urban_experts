import 'package:flutter/material.dart';
import 'package:mychoice/utils/exports.dart';

class BottomnavViewModel extends ChangeNotifier {
  int _navindex = 0;
  int get navindex => _navindex;

  set navindex(int value) {
    if (_navindex != value) {
      _navindex = value;
      notifyListeners();
    }
  }
}
