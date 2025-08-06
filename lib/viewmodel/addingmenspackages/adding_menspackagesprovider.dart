import 'package:flutter/material.dart';

class AddingMenspackagesprovider with ChangeNotifier {
  bool _isLoading = false;
  bool _isHaircutSelected = false;
  bool _isHairColorSelected = false;
  String? _selectedHairColor = 'Brown black';
  final List<String> _availableHairColors = [
    'Brown black',
    'Deep black',
    'Natural brown',
    '',
  ];
  final List<Map<String, dynamic>> _cartItems = [];
  int _subtotal = 0;
  int _savings = 0;
  int _total = 0;
  int _totalPrice = 0;
  int _originalPrice = 658;

  bool get isLoading => _isLoading;
  bool get isHaircutSelected => _isHaircutSelected;
  bool get isHairColorSelected => _isHairColorSelected;
  String? get selectedHairColor => _selectedHairColor;
  int get totalPrice => _totalPrice;
  int get originalPrice => _originalPrice;
  int get subtotal => _subtotal;
  int get savings => _savings;
  int get total => _total;
  List<Map<String, dynamic>> get cartItems => _cartItems;
  List<String> get availableHairColors => _availableHairColors;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void initializePackage(Map<String, dynamic> package) {
    _subtotal = package['price']?.toDouble() ?? 0.0;
    _totalPrice = package['price']?.toDouble() ?? 0.0;
    _originalPrice = package['price']?.toDouble() ?? 0.0;
    _isHaircutSelected = false;
    _isHairColorSelected = false;
    _selectedHairColor = '';
    notifyListeners();
  }

  void toggleHaircut(bool value) {
    _isHaircutSelected = value;
    if (!_isHaircutSelected && !_isHairColorSelected) {
      _isHaircutSelected = true;
    }
    _updateCartAndTotals();
    notifyListeners();
  }

  void toggleHairColor(bool value) {
    _isHairColorSelected = value;
    if (!_isHaircutSelected && !_isHairColorSelected) {
      _isHairColorSelected = true;
    }
    _updateCartAndTotals();
    notifyListeners();
  }

  void setSelectedHairColor(String? value) {
    _selectedHairColor = value;
    _updateCartAndTotals();
    notifyListeners();
  }

  void _updateCartAndTotals() {
    _cartItems.clear();
    _subtotal = 0;
    _totalPrice = 0;
    _savings = 100;

    if (_isHaircutSelected) {
      _cartItems.add({'title': 'Haircut for men', 'price': 259, 'quantity': 1});
      _subtotal += 259;
      _totalPrice += 259;
    }

    // Handle Hair color section
    if (_isHairColorSelected) {
      if (_selectedHairColor != null && _selectedHairColor!.isNotEmpty) {
        // Specific Garnier color selected
        _cartItems.add({
          'title': 'Hair color (Garnier) - $_selectedHairColor',
          'price': 299,
          'quantity': 1,
        });
        _subtotal += 299;
        _totalPrice += 299;
      } else {
        _cartItems.add({
          'title': 'Hair colour application only',
          'price': 199,
          'quantity': 1,
        });
        _subtotal += 199;
        _totalPrice += 199;
      }
    }

    _total = _subtotal - _savings;
    _originalPrice = 658;
  }

  Future<void> addpackagecolor() async {
    try {
      isLoading = true;
      await Future.delayed(Duration(seconds: 1));
      isLoading = false;
    } catch (error) {
      print("Error during adding of the package color: $error");
      isLoading = false;
    }
  }
}
