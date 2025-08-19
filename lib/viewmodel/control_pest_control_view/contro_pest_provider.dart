import 'package:flutter/material.dart';
import 'package:mychoice/data/models/control_pest_model.dart';

class ControPestProvider with ChangeNotifier {
  bool _islaoding = false;

  bool get islaoding => _islaoding;

  List<ControlPestModel> _items =[ ];

  List<ControlPestModel> get items => _items;

  final Map<String, int> _additionalAmounts = {};
  final List<String> _selectedOptionIds = [];

  List<String> get selectedOptionIds => _selectedOptionIds;

  final Map<String, int> _quantities = {};

  int getQty(String optionId) => _quantities[optionId] ?? 0;

  int get totalSelectedCount => _quantities.values.fold(0, (a, b) => a + b);

  void incrementOption(String optionId) {
    final next = (_quantities[optionId] ?? 0) + 1;
    _quantities[optionId] = next;
    selectedOptionIds.add(optionId);
    notifyListeners();
  }

  void decrementOption(String optionId) {
    final cur = _quantities[optionId] ?? 0;
    if (cur <= 1) {
      _quantities.remove(optionId);
      selectedOptionIds.remove(optionId);
    } else {
      _quantities[optionId] = cur - 1;
    }
    notifyListeners();
  }

  int getTotalPrice(String itemId, String optionPlacename) {
    final item = _items.firstWhere(
      (item) => item.id == itemId,
      orElse: () => throw Exception('ID not found'),
    );
    final option = item.selectedOptions.firstWhere(
      (option) => option.placename == optionPlacename,
      orElse: () => throw Exception('Option not found'),
    );
    return option.price +
        (_additionalAmounts['$itemId _$optionPlacename'] ?? 0);
  }

  void toggleOptionSelection(String optionId) {
    if (_selectedOptionIds.contains(optionId)) {
      _selectedOptionIds.remove(optionId);
    } else {
      _selectedOptionIds.add(optionId);
    }
    notifyListeners();
  }

  void clearSelectedOptions() {
    _selectedOptionIds.clear();
    _quantities.clear();
    notifyListeners();
  }

  void updateAdditionalAmount(
    String itemId,
    String optionPlacename,
    int amount,
  ) {
    _additionalAmounts['$itemId _$optionPlacename'] = amount;
    notifyListeners();
  }

  set islaoding(bool value) {
    _islaoding = value;
    notifyListeners();
  }

  Future<void> getControPest() async {
    try {
      islaoding = true;
      notifyListeners();
      _items = [
        ControlPestModel(
          id: "1",
          title: "Cockroach & Ant Control",
          subtitle: "include charge",
          description: "very imporatnt and will be cleaned with 24 hours",
          price: 1500,
          image:
              "https://tse2.mm.bing.net/th/id/OIP.6bdvHafp7ZEXYdzDiOGJFAHaEY?pid=Api&P=0&h=180",
          time: 200,
          area: "RR nagar",
          placename: "Apartment",
          selectedOptions: [
            PestOption(
              id: "1",
              placename: "Apartment",
              subtitle: "45 min",
              description: "Up to 2BHK apartment coverage.",
              price: 49,
              image: "",
              time: 45,
              area: "Citywide",
            ),
            PestOption(
              id: "2",
              placename: "Bungalow",
              subtitle: "60 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              placename: "corporate office",
              id: "3",
              subtitle: "100 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              placename: "provison store",
              id: "4",
              subtitle: "60 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              id: "5",
              placename: "Apartment (3BHK+)",
              subtitle: "45 min",
              description: "Large flats including balconies.",
              price: 149,
              image: "",
              time: 45,
              area: "Citywide",
            ),
            PestOption(
              id: "6",
              placename: "Utensils Removal Service",
              subtitle: "30 min",
              description: "Safe removal/covering before treatment.",
              price: 79,
              image: "",
              time: 30,
              area: "Kitchen",
            ),
            PestOption(
              id: "7",
              placename: "Retail Shops",
              subtitle: "60 min",
              description: "Small retail units, shelves & storage.",
              price: 99,
              image: "",
              time: 60,
              area: "Retail",
            ),
          ],
        ),
        ControlPestModel(
          id: "2",
          title: "Termite Control",
          subtitle: "include charge",
          description: "very imporatnt and will be cleaned with 24 hours",
          price: 2000,
          image:
              "https://tse2.mm.bing.net/th/id/OIP.PT5ZuaOj0yS8yxP-7INLhwHaE8?pid=Api&P=0&h=180",
          time: 1,
          area: "sahakar nagar",
          placename: "Retail Store",
          selectedOptions: [
            PestOption(
              id: "1",
              placename: "Apartment",
              subtitle: "45 min",
              description: "Up to 2BHK apartment coverage.",
              price: 49,
              image: "",
              time: 45,
              area: "Citywide",
            ),
            PestOption(
              id: "2",
              placename: "Bungalow",
              subtitle: "60 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              placename: "coorporate office",
              id: "3",
              subtitle: "100 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              placename: "Provisional Strore",
              id: "4",
              subtitle: "60 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              id: "5",
              placename: "Apartment (3BHK+)",
              subtitle: "45 min",
              description: "Large flats including balconies.",
              price: 149,
              image: "",
              time: 45,
              area: "Citywide",
            ),
            PestOption(
              id: "6",
              placename: "Utensils Removal Service",
              subtitle: "30 min",
              description: "Safe removal/covering before treatment.",
              price: 79,
              image: "",
              time: 30,
              area: "Kitchen",
            ),
            PestOption(
              id: "7",
              placename: "Retail Shops",
              subtitle: "60 min",
              description: "Small retail units, shelves & storage.",
              price: 99,
              image: "",
              time: 60,
              area: "Retail",
            ),
          ],
        ),
        ControlPestModel(
          id: "3",
          title: "Full Home Cleaning",
          subtitle: "include charge",
          description: "very imporatnt and will be cleaned with 24 hours",
          price: 4500,
          image:
              "https://tse1.mm.bing.net/th/id/OIP.XTpGpugbZ3NTl6zyT7bAiwHaEU?pid=Api&P=0&h=180",
          time: 1,
          area: "Indira nagar",
          placename: "Office",
          selectedOptions: [
            PestOption(
              id: "1",
              placename: "Apartment",
              subtitle: "45 min",
              description: "Up to 2BHK apartment coverage.",
              price: 49,
              image: "",
              time: 45,
              area: "Citywide",
            ),
            PestOption(
              id: "2",
              placename: "Bungalow",
              subtitle: "60 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              placename: "coorporate office",
              id: "3",
              subtitle: "100 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              placename: "Provisional Strore",
              id: "4",
              subtitle: "60 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              id: "5",
              placename: "Apartment (3BHK+)",
              subtitle: "45 min",
              description: "Large flats including balconies.",
              price: 149,
              image: "",
              time: 45,
              area: "Citywide",
            ),
            PestOption(
              id: "6",
              placename: "Utensils Removal Service",
              subtitle: "30 min",
              description: "Safe removal/covering before treatment.",
              price: 79,
              image: "",
              time: 30,
              area: "Kitchen",
            ),
            PestOption(
              id: "7",
              placename: "Retail Shops",
              subtitle: "60 min",
              description: "Small retail units, shelves & storage.",
              price: 99,
              image: "",
              time: 60,
              area: "Retail",
            ),
          ],
        ),
        ControlPestModel(
          id: "4",
          title: "Bathroom Cleaning",
          subtitle: "include charge",
          description: "very imporatnt and will be cleaned with 24 hours",
          price: 2400,
          image:
              "https://tse4.mm.bing.net/th/id/OIP.7lI5C9ko9eNBQJVQqXIysgHaE7?pid=Api&P=0&h=180",
          time: 1,
          area: "hoskerhalli",
          placename: "Residential",
          selectedOptions: [
            PestOption(
              id: "1",
              placename: "Apartment",
              subtitle: "45 min",
              description: "Up to 2BHK apartment coverage.",
              price: 49,
              image: "",
              time: 45,
              area: "Citywide",
            ),
            PestOption(
              id: "2",
              placename: "Bungalow",
              subtitle: "60 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              placename: "coorporate office",
              id: "3",
              subtitle: "100 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              placename: "Provisional Strore",
              id: "4",
              subtitle: "60 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              id: "5",
              placename: "Apartment (3BHK+)",
              subtitle: "45 min",
              description: "Large flats including balconies.",
              price: 149,
              image: "",
              time: 45,
              area: "Citywide",
            ),
            PestOption(
              id: "6",
              placename: "Utensils Removal Service",
              subtitle: "30 min",
              description: "Safe removal/covering before treatment.",
              price: 79,
              image: "",
              time: 30,
              area: "Kitchen",
            ),
            PestOption(
              id: "7",
              placename: "Retail Shops",
              subtitle: "60 min",
              description: "Small retail units, shelves & storage.",
              price: 99,
              image: "",
              time: 60,
              area: "Retail",
            ),
          ],
        ),
        ControlPestModel(
          id: "5",
          title: "Kitchen Cleaning",
          subtitle: "include charge",
          description: "very imporatnt and will be cleaned with 24 hours",
          price: 3200,
          image:
              "https://tse4.mm.bing.net/th/id/OIP.IHfFBfJ2gr7sNaz8dQIvmQHaEL?pid=Api&P=0&h=180",
          time: 3,
          area: "Indira nagar",
          placename: "utensils removal services ",
          selectedOptions: [
            PestOption(
              id: "1",
              placename: "Apartment",
              subtitle: "45 min",
              description: "Up to 2BHK apartment coverage.",
              price: 49,
              image: "",
              time: 45,
              area: "Citywide",
            ),
            PestOption(
              id: "2",
              placename: "Bungalow",
              subtitle: "60 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              placename: "coorporate office",
              id: "3",
              subtitle: "100 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              placename: "Provisional Strore",
              id: "4",
              subtitle: "60 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              id: "5",
              placename: "Apartment (3BHK+)",
              subtitle: "45 min",
              description: "Large flats including balconies.",
              price: 149,
              image: "",
              time: 45,
              area: "Citywide",
            ),
            PestOption(
              id: "6",
              placename: "Utensils Removal Service",
              subtitle: "30 min",
              description: "Safe removal/covering before treatment.",
              price: 79,
              image: "",
              time: 30,
              area: "Kitchen",
            ),
            PestOption(
              id: "7",
              placename: "Retail Shops",
              subtitle: "60 min",
              description: "Small retail units, shelves & storage.",
              price: 99,
              image: "",
              time: 60,
              area: "Retail",
            ),
          ],
        ),
        ControlPestModel(
          id: "6",
          title: "Sofa & Carpet  Cleaning",
          subtitle: "include charge",
          description: "very imporatnt and will be cleaned with 24 hours",
          price: 3200,
          image:
              "https://tse4.mm.bing.net/th/id/OIP.AITu9PMRNrC1X2q18zdXkQHaHC?pid=Api&P=0&h=180",
          time: 3,
          area: "Banashakri",
          placename: "home cleaning services ",
          selectedOptions: [
            PestOption(
              id: "1",
              placename: "Apartment",
              subtitle: "45 min",
              description: "Up to 2BHK apartment coverage.",
              price: 49,
              image: "",
              time: 45,
              area: "Citywide",
            ),
            PestOption(
              id: "2",
              placename: "Bungalow",
              subtitle: "60 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              placename: "coorporate office",
              id: "3",
              subtitle: "100 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              placename: "Provisional Strore",
              id: "4",
              subtitle: "60 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              id: "5",
              placename: "Apartment (3BHK+)",
              subtitle: "45 min",
              description: "Large flats including balconies.",
              price: 149,
              image: "",
              time: 45,
              area: "Citywide",
            ),
            PestOption(
              id: "6",
              placename: "Utensils Removal Service",
              subtitle: "30 min",
              description: "Safe removal/covering before treatment.",
              price: 79,
              image: "",
              time: 30,
              area: "Kitchen",
            ),
            PestOption(
              id: "7",
              placename: "Retail Shops",
              subtitle: "60 min",
              description: "Small retail units, shelves & storage.",
              price: 99,
              image: "",
              time: 60,
              area: "Retail",
            ),
          ],
        ),
        ControlPestModel(
          id: "7",
          title: "Bedbugs Control",
          subtitle: "include charge",
          description: "very imporatnt and will be cleaned with 24 hours",
          price: 4200,
          image:
              "https://tse4.mm.bing.net/th/id/OIP.cRcbomhP7FJzk1_T1TtQoAHaEE?pid=Api&P=0&h=180",
          time: 3,
          area: "magadi Road",
          placename: "office control services ",
          selectedOptions: [
            PestOption(
              id: "1",
              placename: "Apartment",
              subtitle: "45 min",
              description: "Up to 2BHK apartment coverage.",
              price: 49,
              image: "",
              time: 45,
              area: "Citywide",
            ),
            PestOption(
              id: "2",
              placename: "Bungalow",
              subtitle: "60 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              placename: "coorporate office",
              id: "3",
              subtitle: "100 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              placename: "Provisional Strore",
              id: "4",
              subtitle: "60 min",
              description: "Independent house + perimeter.",
              price: 99,
              image: "",
              time: 60,
              area: "Citywide",
            ),
            PestOption(
              id: "5",
              placename: "Apartment (3BHK+)",
              subtitle: "45 min",
              description: "Large flats including balconies.",
              price: 149,
              image: "",
              time: 45,
              area: "Citywide",
            ),
            PestOption(
              id: "6",
              placename: "Utensils Removal Service",
              subtitle: "30 min",
              description: "Safe removal/covering before treatment.",
              price: 79,
              image: "",
              time: 30,
              area: "Kitchen",
            ),
            PestOption(
              id: "7",
              placename: "Retail Shops",
              subtitle: "60 min",
              description: "Small retail units, shelves & storage.",
              price: 99,
              image: "",
              time: 60,
              area: "Retail",
            ),
          ],
        ),
        ControlPestModel(
          id: "8",
          title: "Pest Control",
          subtitle: "include charge",
          description: "very imporatnt and will be cleaned with 24 hours",
          price: 2200,
          image:
              "https://tse3.mm.bing.net/th/id/OIP._elWM4GhMwhPs-uSvQDpqQHaEP?pid=Api&P=0&h=180",
          time: 30,
          area: "challagatha",
          placename: "Apartment",
          selectedOptions: [],
        ),
      ];
      islaoding = false;
    } catch (error) {
      print("the error during the pest control  is $error");
      islaoding = false;
    }
    islaoding = false;
  }
}
