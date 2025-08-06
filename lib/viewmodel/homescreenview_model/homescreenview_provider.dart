import 'package:flutter/material.dart';
import 'package:mychoice/data/models/recentworkmodel.dart';

class HomescreenviewProvider with ChangeNotifier {
  bool _isloading = false;
  List<Recentworkmodel> _recentwork = [];

  bool get isloading => _isloading;

  set isloading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  List<Recentworkmodel> get recentworkmodel => _recentwork;

  Future<void> getworkdetails() async {
    try {
      isloading = true;
      _recentwork = [
        Recentworkmodel(
          id: "1",
          title: "Women Salon & Spa",
          imageurl: "https://tse4.mm.bing.net/th/id/OIP.mZgBe1esdO_u81ju5DI-YwHaE7?pid=Api&P=0&h=180",
          videoUrl: "assets/vedios/mens_haircutting.mp4",
          categories: [
            {'title': 'Massage', 'imageUrl': 'https://tse4.mm.bing.net/th/id/OIP.zmkPJBzXBnwOmio5wPd34gHaE8?pid=Api&P=0&h=180'},
            {'title': 'Hair Cutting', 'imageUrl': 'https://tse2.mm.bing.net/th/id/OIP.QQ5l9tWGjowB2CkMwMkV2wHaE8?pid=Api&P=0&h=180'},
            {'title': 'Hair Color', 'imageUrl': 'https://tse3.mm.bing.net/th/id/OIP.DsQ0QdtMUWmvYPVq_DKlAgHaEK?pid=Api&P=0&h=180'},
            {'title': 'Facial', 'imageUrl': 'https://www.swagmee.com/media/wysiwyg/blog/Why_is_Facial_and_Clean_Up_Important_for_Men.jpg'},
          ],
          packages: [
            {
              'title': 'Haircut & Spa',
              'rating': 4.2,
              'reviewCount': 1500,
              'price': 600,
              'duration': '60 mins',
              'services': ['Hair Cutting', 'Spa Treatment'],
            },
            {
              'title': 'Facial & Massage',
              'rating': 4.5,
              'reviewCount': 2000,
              'price': 800,
              'duration': '75 mins',
              'services': ['Facial', 'Massage'],
            },
          ],
        ),
        Recentworkmodel(
          id: "2",
          title: "Men's Salon & Massage",
          imageurl: "https://tse3.mm.bing.net/th/id/OIP.RDN06zToKAL3Lbx9B7OxJgHaDa?pid=Api&P=0&h=180",
          videoUrl: "assets/vedios/mens_haircutting.mp4",
          categories: [
            {'title': 'Massage', 'imageUrl': 'https://tse4.mm.bing.net/th/id/OIP.zmkPJBzXBnwOmio5wPd34gHaE8?pid=Api&P=0&h=180'},
            {'title': 'Hair Cutting', 'imageUrl': 'https://tse2.mm.bing.net/th/id/OIP.QQ5l9tWGjowB2CkMwMkV2wHaE8?pid=Api&P=0&h=180'},
            {'title': 'Hair Color', 'imageUrl': 'https://tse3.mm.bing.net/th/id/OIP.DsQ0QdtMUWmvYPVq_DKlAgHaEK?pid=Api&P=0&h=180'},
            {'title': 'Detan', 'imageUrl': 'https://tse1.mm.bing.net/th/id/OIP.KHXs0uCJuE-hr-iVMh4MbwAAAA?pid=Api&P=0&h=180'},
            {'title': 'Facial & Cleanup', 'imageUrl': 'https://www.swagmee.com/media/wysiwyg/blog/Why_is_Facial_and_Clean_Up_Important_for_Men.jpg'},
          ],
          packages: [
            {
              'title': 'Haircut & Color',
              'rating': 3.59,
              'reviewCount': 2,
              'price': 500,
              'duration': '60 mins',
              'services': ['Hair Cutting', 'Hair Color'],
            },
            {
              'title': 'Facial & Cleanup',
              'rating': 3.59,
              'reviewCount': 2,
              'price': 3000,
              'duration': '60 mins',
              'services': ['Face Wash', 'Pedicure'],
            },
          ],
        ),
        Recentworkmodel(
          id: "3",
          title: "AC & Appliance Repair",
          imageurl: "https://tse3.mm.bing.net/th/id/OIP.KIZyFbNVIlvn41MHrMC1bgHaE8?pid=Api&P=0&h=180",
          videoUrl: "assets/vedios/mens_haircutting.mp4",
          categories: [
            {'title': 'AC Repair', 'imageUrl': 'https://tse3.mm.bing.net/th/id/OIP.KIZyFbNVIlvn41MHrMC1bgHaE8?pid=Api&P=0&h=180'},
            {'title': 'Refrigerator Repair', 'imageUrl': 'https://tse1.mm.bing.net/th/id/OIP.5fXz6Qz1gQ7Y0H2Z2X2X2QHaE8?pid=Api&P=0&h=180'},
          ],
          packages: [
            {
              'title': 'AC Servicing',
              'rating': 4.0,
              'reviewCount': 1000,
              'price': 1200,
              'duration': '90 mins',
              'services': ['AC Cleaning', 'Gas Refill'],
            },
          ],
        ),

         Recentworkmodel(
          id: "4",
          title: "Cleaning & Pest Control",
          imageurl: "https://tse3.mm.bing.net/th/id/OIP.bLpJha5mn3nGDNYZ9MqgpAHaDt?pid=Api&P=0&h=180",
          videoUrl: "assets/vedios/mens_haircutting.mp4",
          categories: [ 
             {'title': 'Massage', 'imageUrl': 'https://tse4.mm.bing.net/th/id/OIP.zmkPJBzXBnwOmio5wPd34gHaE8?pid=Api&P=0&h=180'},
            {'title': 'Hair Cutting', 'imageUrl': 'https://tse2.mm.bing.net/th/id/OIP.QQ5l9tWGjowB2CkMwMkV2wHaE8?pid=Api&P=0&h=180'},
            {'title': 'Hair Color', 'imageUrl': 'https://tse3.mm.bing.net/th/id/OIP.DsQ0QdtMUWmvYPVq_DKlAgHaEK?pid=Api&P=0&h=180'},
            {'title': 'Detan', 'imageUrl': 'https://tse1.mm.bing.net/th/id/OIP.KHXs0uCJuE-hr-iVMh4MbwAAAA?pid=Api&P=0&h=180'},
            {'title': 'Facial & Cleanup', 'imageUrl': 'https://www.swagmee.com/media/wysiwyg/blog/Why_is_Facial_and_Clean_Up_Important_for_Men.jpg'},

          ],
            packages: [
            {
              'title': 'Haircut & Color',
              'rating': 3.59,
              'reviewCount': 2,
              'price': 500,
              'duration': '60 mins',
              'services': ['Hair Cutting', 'Hair Color'],
            },
            {
              'title': 'Facial & Cleanup',
              'rating': 3.59,
              'reviewCount': 2,
              'price': 3000,
              'duration': '60 mins',
              'services': ['Face Wash', 'Pedicure'],
            },
          ],

        ),
         Recentworkmodel(
          id: "5",
          title: "Electrician, Plumber & Carpenter",
          imageurl: "https://tse3.mm.bing.net/th/id/OIP.UFuZhXs77tYckET8M-h9YwHaE8?pid=Api&P=0&h=180",
           videoUrl: "assets/vedios/mens_haircutting.mp4",
          categories: [ 
             {'title': 'Massage', 'imageUrl': 'https://tse4.mm.bing.net/th/id/OIP.zmkPJBzXBnwOmio5wPd34gHaE8?pid=Api&P=0&h=180'},
            {'title': 'Hair Cutting', 'imageUrl': 'https://tse2.mm.bing.net/th/id/OIP.QQ5l9tWGjowB2CkMwMkV2wHaE8?pid=Api&P=0&h=180'},
            {'title': 'Hair Color', 'imageUrl': 'https://tse3.mm.bing.net/th/id/OIP.DsQ0QdtMUWmvYPVq_DKlAgHaEK?pid=Api&P=0&h=180'},
            {'title': 'Detan', 'imageUrl': 'https://tse1.mm.bing.net/th/id/OIP.KHXs0uCJuE-hr-iVMh4MbwAAAA?pid=Api&P=0&h=180'},
            {'title': 'Facial & Cleanup', 'imageUrl': 'https://www.swagmee.com/media/wysiwyg/blog/Why_is_Facial_and_Clean_Up_Important_for_Men.jpg'},

          ],
            packages: [
            {
              'title': 'Haircut & Color',
              'rating': 3.59,
              'reviewCount': 2,
              'price': 500,
              'duration': '60 mins',
              'services': ['Hair Cutting', 'Hair Color'],
            },
            {
              'title': 'Facial & Cleanup',
              'rating': 3.59,
              'reviewCount': 2,
              'price': 3000,
              'duration': '60 mins',
              'services': ['Face Wash', 'Pedicure'],
            },
          ],
          
        ),
          Recentworkmodel(
          id: "6",
          title: "Native Water Purifier",
          imageurl: "https://tse3.mm.bing.net/th/id/OIP.dHPj3qeLUU_EYQoQYDW0JwHaEJ?pid=Api&P=0&h=180",
            categories: [ 
             {'title': 'Massage', 'imageUrl': 'https://tse4.mm.bing.net/th/id/OIP.zmkPJBzXBnwOmio5wPd34gHaE8?pid=Api&P=0&h=180'},
            {'title': 'Hair Cutting', 'imageUrl': 'https://tse2.mm.bing.net/th/id/OIP.QQ5l9tWGjowB2CkMwMkV2wHaE8?pid=Api&P=0&h=180'},
            {'title': 'Hair Color', 'imageUrl': 'https://tse3.mm.bing.net/th/id/OIP.DsQ0QdtMUWmvYPVq_DKlAgHaEK?pid=Api&P=0&h=180'},
            {'title': 'Detan', 'imageUrl': 'https://tse1.mm.bing.net/th/id/OIP.KHXs0uCJuE-hr-iVMh4MbwAAAA?pid=Api&P=0&h=180'},
            {'title': 'Facial & Cleanup', 'imageUrl': 'https://www.swagmee.com/media/wysiwyg/blog/Why_is_Facial_and_Clean_Up_Important_for_Men.jpg'},

          ],
            packages: [
            {
              'title': 'Haircut & Color',
              'rating': 3.59,
              'reviewCount': 2,
              'price': 500,
              'duration': '60 mins',
              'services': ['Hair Cutting', 'Hair Color'],
            },
            {
              'title': 'Facial & Cleanup',
              'rating': 3.59,
              'reviewCount': 2,
              'price': 3000,
              'duration': '60 mins',
              'services': ['Face Wash', 'Pedicure'],
            },
          ],

        ),
      ];
      isloading = false;
      notifyListeners();
    } catch (error) {
      isloading = false;
      notifyListeners();
    }
  }
}