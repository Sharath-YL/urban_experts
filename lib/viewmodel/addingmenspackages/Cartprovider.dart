import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  bool _isLoading = false;
  List<Map<String, dynamic>> _cartItems = [];
  int _subtotal = 0;
  int _savings = 0;
  int _total = 0;
  int _originalPrice = 0;

  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get cartItems => _cartItems;
  int get subtotal => _subtotal;
  int get savings => _savings;
  int get total => _total;
  int get originalPrice => _originalPrice;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void initializeCart() {
    _cartItems.clear();
    _subtotal = 0;
    _savings = 0;
    _total = 0;
    _originalPrice = 0;
    notifyListeners();
  }

  void addToCart({
    required Map<String, dynamic> package,
    required Map<String, String> selectedOptions,
    required int totalPrice,
    required int originalPrice,
  }) {
    _cartItems.clear();
    _subtotal = totalPrice;
    _originalPrice = originalPrice;
    _savings = originalPrice > totalPrice ? originalPrice - totalPrice : 0;
    _total = totalPrice;

    _cartItems.add({
      'title': package['title'],
      'price': package['price'],
      'quantity': 1,
      'services': package['services'],
    });

    selectedOptions.forEach((type, label) {
      final option = (package['options'] as List<dynamic>?)?.firstWhere(
        (opt) => opt['type'] == type,
        orElse: () => null,
      );
      if (option != null) {
        final value = (option['values'] as List<dynamic>).firstWhere(
          (val) => val['label'] == label,
          orElse: () => {'price': 0},
        );
        if (value['price'] > 0) {
          _cartItems.add({
            'title': '$type - $label',
            'price': value['price'],
            'quantity': 1,
          });
        }
      }
    });

    notifyListeners();
  }

  Future<void> addPackageToCart({
    required Map<String, dynamic> package,
    required Map<String, String> selectedOptions,
    required int totalPrice,
    required int originalPrice,
  }) async {
    try {
      isLoading = true;
      await Future.delayed(const Duration(seconds: 1));
      addToCart(
        package: package,
        selectedOptions: selectedOptions,
        totalPrice: totalPrice,
        originalPrice: originalPrice,
      );
      isLoading = false;
    } catch (error) {
      print("Error adding package to cart: $error");
      isLoading = false;
    }
  }
}
