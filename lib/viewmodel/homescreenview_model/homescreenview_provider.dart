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
          title: "Women hair Cutting",
          ratings: "4.5 Ratings",

          imageurl: "assets/images/cocktail_6939446.png",
          videoUrl: "assets/vedios/mens_haircutting.mp4",
          categories: [
            {
              'title': 'Massage',
              'imageUrl':
                  'https://tse4.mm.bing.net/th/id/OIP.zoZo436xdTLbz3f5fZps4gHaIV?pid=Api&P=0&h=180',
            },
            {
              'title': 'Hair Cutting',
              'imageUrl':
                  'https://tse1.mm.bing.net/th/id/OIP.ev5kbGRYzhO-i8nFmLe5PwHaFc?pid=Api&P=0&h=180',
            },
            {
              'title': 'Hair Color',
              'imageUrl':
                  'https://tse4.mm.bing.net/th/id/OIP.zoZo436xdTLbz3f5fZps4gHaIV?pid=Api&P=0&h=180',
            },
            {
              'title': 'Facial',
              'imageUrl':
                  'https://www.swagmee.com/media/wysiwyg/blog/Why_is_Facial_and_Clean_Up_Important_for_Men.jpg',
            },
          ],
          packages: [
            {
              'title': 'Haircut & Spa',
              'rating': 4.2,
              'reviewCount': 1500,
              'price': 600,
              'duration': '60 mins',
              'services': ['Hair Cutting', 'Spa Treatment'],
              'options': [
                {
                  'type': 'Hair Cutting',
                  'values': [
                    {'label': 'Short Hair', 'price': 200},
                    {'label': 'Medium Hair', 'price': 250},
                    {'label': 'Long Hair', 'price': 300},
                    {'label': 'No Haircut', 'price': 0},
                  ],
                },
                {
                  'type': 'Spa Treatment',
                  'values': [
                    {'label': 'Aroma Spa', 'price': 350},
                    {'label': 'Herbal Spa', 'price': 300},
                    {'label': 'No Spa', 'price': 0},
                  ],
                },
              ],
            },
            {
              'title': 'Facial & Massage',
              'rating': 4.5,
              'reviewCount': 2000,
              'price': 800,
              'duration': '75 mins',
              'services': ['Facial', 'Massage'],
              'options': [
                {
                  'type': 'Facial Type',
                  'values': [
                    {'label': 'Fruit Facial', 'price': 200},
                    {'label': 'Gold Facial', 'price': 300},
                    {'label': 'No Facial', 'price': 0},
                  ],
                },
                {
                  'type': 'Massage Oil',
                  'values': [
                    {'label': 'Aroma Oil', 'price': 150},
                    {'label': 'Herbal Oil', 'price': 100},
                    {'label': 'No Oil', 'price': 0},
                  ],
                },
              ],
            },
          ],
        ),
        Recentworkmodel(
          id: "2",
          title: "Painting",
          ratings: "3.56 Ratings",
          imageurl: "assets/images/painting_6303092.png",
          videoUrl: "assets/vedios/mens_haircutting.mp4",
          categories: [
            {
              'title': 'Massage',
              'imageUrl':
                  'https://tse4.mm.bing.net/th/id/OIP.zmkPJBzXBnwOmio5wPd34gHaE8?pid=Api&P=0&h=180',
            },
            {
              'title': 'Hair Cutting',
              'imageUrl':
                  'https://tse2.mm.bing.net/th/id/OIP.QQ5l9tWGjowB2CkMwMkV2wHaE8?pid=Api&P=0&h=180',
            },
            {
              'title': 'Hair Color',
              'imageUrl':
                  'https://tse3.mm.bing.net/th/id/OIP.DsQ0QdtMUWmvYPVq_DKlAgHaEK?pid=Api&P=0&h=180',
            },
            {
              'title': 'Detan',
              'imageUrl':
                  'https://tse1.mm.bing.net/th/id/OIP.KHXs0uCJuE-hr-iVMh4MbwAAAA?pid=Api&P=0&h=180',
            },
            {
              'title': 'Facial & Cleanup',
              'imageUrl':
                  'https://www.swagmee.com/media/wysiwyg/blog/Why_is_Facial_and_Clean_Up_Important_for_Men.jpg',
            },
          ],
          packages: [
            {
              'title': 'Haircut & Color',
              'rating': 3.59,
              'reviewCount': 2,
              'price': 500,
              'duration': '60 mins',
              'services': ['Hair Cutting', 'Hair Color'],
              'options': [
                {
                  'type': 'Hair Cutting',
                  'values': [
                    {'label': 'Short Hair', 'price': 150},
                    {'label': 'Medium Hair', 'price': 200},
                    {'label': 'No Haircut', 'price': 0},
                  ],
                },
                {
                  'type': 'Hair Color',
                  'values': [
                    {'label': 'Red', 'price': 250},
                    {'label': 'Blue', 'price': 250},
                    {'label': 'Black', 'price': 200},
                    {'label': 'No Color', 'price': 0},
                  ],
                },
              ],
            },
            {
              'title': 'Facial & Cleanup',
              'rating': 3.59,
              'reviewCount': 2,
              'price': 3000,
              'duration': '60 mins',
              'services': ['Face Wash', 'Pedicure'],
              'options': [
                {
                  'type': 'Face Wash',
                  'values': [
                    {'label': 'Deep Cleanse', 'price': 200},
                    {'label': 'Hydrating Wash', 'price': 250},
                    {'label': 'No Face Wash', 'price': 0},
                  ],
                },
                {
                  'type': 'Pedicure',
                  'values': [
                    {'label': 'Basic Pedicure', 'price': 300},
                    {'label': 'Spa Pedicure', 'price': 400},
                    {'label': 'No Pedicure', 'price': 0},
                  ],
                },
              ],
            },
          ],
        ),
        Recentworkmodel(
          id: "3",
          title: "Electrical",
          ratings: "5.0 Ratings",
          imageurl: "assets/images/idea_1637826.png",
          videoUrl: "assets/vedios/mens_haircutting.mp4",
          categories: [
            {
              'title': 'AC Repair',
              'imageUrl':
                  'https://tse3.mm.bing.net/th/id/OIP.KIZyFbNVIlvn41MHrMC1bgHaE8?pid=Api&P=0&h=180',
            },
            {
              'title': 'Refrigerator Repair',
              'imageUrl':
                  'https://tse2.mm.bing.net/th/id/OIP.yO_sPyFFlXCWFPWZuTwFtAHaE6?pid=Api&P=0&h=180',
            },
          ],
          packages: [
            {
              'title': 'AC Servicing',
              'rating': 4.0,
              'reviewCount': 1000,
              'price': 1200,
              'duration': '90 mins',
              'services': ['AC Cleaning', 'Gas Refill'],
              'options': [
                {
                  'type': 'Ac services',
                  'values': [
                    {'label': 'Air refuling', 'price': 200},
                    {'label': 'ac cleaning', 'price': 250},
                    {'label': 'Ac coloring', 'price': 300},
                    {'label': 'No repair', 'price': 0},
                  ],
                },
                {
                  'type': 'Ac Services',
                  'values': [
                    {'label': 'Air refuling', 'price': 350},
                    {'label': 'Ac coloring', 'price': 300},
                    {'label': 'No repair', 'price': 0},
                  ],
                },
              ],
            },
          ],
        ),

        Recentworkmodel(
          id: "4",
          title: "Cleaning ",
          ratings: "4.65 Ratings",
          imageurl: "assets/images/room-fumigation_13505602.png",
          videoUrl: "assets/vedios/mens_haircutting.mp4",
          categories: [
            {
              'title': 'cleaning',
              'imageUrl':
                  'https://tse1.mm.bing.net/th/id/OIP.I6TQ2G-RhSxGDycIkxX_UAHaDt?pid=Api&P=0&h=180',
            },
            {
              'title': 'pest control',
              'imageUrl':
                  'https://tse1.mm.bing.net/th/id/OIP.CGBsmmwhTZb4JSSIaiPMGAHaE8?pid=Api&P=0&h=180',
            },
            {
              'title': 'cleaning',
              'imageUrl':
                  'https://tse1.mm.bing.net/th/id/OIP.I6TQ2G-RhSxGDycIkxX_UAHaDt?pid=Api&P=0&h=180',
            },
            {
              'title': 'Detan',
              'imageUrl':
                  'https://tse3.mm.bing.net/th/id/OIP.I5uVo2vVLIvHeYgN6xqLhwHaE8?pid=Api&P=0&h=180',
            },
            {
              'title': 'cleaning & control',
              'imageUrl':
                  'https://tse4.mm.bing.net/th/id/OIP.IklaEi9--JqI_-jysZucrwHaE8?pid=Api&P=0&h=180',
            },
          ],
          packages: [
            {
              'title': 'cleaning & pest control',
              'rating': 3.59,
              'reviewCount': 2,
              'price': 500,
              'duration': '60 mins',
              'services': ['cleaning', 'pest control'],
              'options': [
                {
                  'type': 'cleaing',
                  'values': [
                    {'label': 'cleaning ', 'price': 300},
                    {'label': 'pest control', 'price': 350},
                    {'label': 'coloring', 'price': 300},
                    {'label': 'No pest control', 'price': 0},
                  ],
                },
                {
                  'type': 'pest control',
                  'values': [
                    {'label': 'pest control', 'price': 350},
                    {'label': 'pest control coloring', 'price': 300},
                    {'label': 'No control', 'price': 0},
                  ],
                },
              ],
            },
            {
              'title': 'cleaning & pest control',
              'rating': 3.59,
              'reviewCount': 2,
              'price': 500,
              'duration': '60 mins',
              'services': ['cleaning', 'pest control'],
              'options': [
                {
                  'type': 'cleaing',
                  'values': [
                    {'label': 'cleaning ', 'price': 300},
                    {'label': 'pest control', 'price': 350},
                    {'label': 'coloring', 'price': 300},
                    {'label': 'No pest control', 'price': 0},
                  ],
                },
                {
                  'type': 'pest control',
                  'values': [
                    {'label': 'pest control', 'price': 350},
                    {'label': 'pest control coloring', 'price': 300},
                    {'label': 'No control', 'price': 0},
                  ],
                },
              ],
            },
          ],
        ),
        Recentworkmodel(
          id: "5",
          ratings: "4.3 Ratings",
          title: "Ac Services",
          imageurl: "assets/images/ac-repair-service_17712762.png",
          videoUrl: "assets/vedios/mens_haircutting.mp4",
          categories: [
            {
              'title': 'Electrician',
              'imageUrl':
                  'https://tse1.mm.bing.net/th/id/OIP.ZtO9MncYkEfDi2DMmOSa8gHaE8?pid=Api&P=0&h=180',
            },
            {
              'title': 'plumbing',
              'imageUrl':
                  'https://tse3.mm.bing.net/th/id/OIP.UFuZhXs77tYckET8M-h9YwHaE8?pid=Api&P=0&h=180',
            },
            {
              'title': 'carpentor',
              'imageUrl':
                  'https://tse3.mm.bing.net/th/id/OIP.6aq2GuyScstyLKHN5EmfLAAAAA?pid=Api&P=0&h=180',
            },
            {
              'title': 'Electrical work',
              'imageUrl':
                  'https://tse1.mm.bing.net/th/id/OIP.KHXs0uCJuE-hr-iVMh4MbwAAAA?pid=Api&P=0&h=180',
            },
            {
              'title': 'plumbing work',
              'imageUrl':
                  'https://tse1.mm.bing.net/th/id/OIP.ZtO9MncYkEfDi2DMmOSa8gHaE8?pid=Api&P=0&h=180',
            },
          ],
          packages: [
            {
              'title': 'Electrician & Plumber ',
              'rating': 3.59,
              'reviewCount': 2,
              'price': 500,
              'duration': '60 mins',
              'services': ['Wiring', 'carpentring'],
              'options': [
                {
                  'type': 'Electricain',
                  'values': [
                    {'label': 'Wireing', 'price': 400},
                    {'label': 'HOme Wiring', 'price': 2000},
                    {'label': 'Plumbering', 'price': 300},
                    {'label': 'No work', 'price': 0},
                  ],
                },
                {
                  'type': 'Plumbering & carpentering',
                  'values': [
                    {'label': 'Home Wiring', 'price': 3500},
                    {'label': 'Plumbering', 'price': 300},
                    {'label': 'No repair', 'price': 0},
                  ],
                },
              ],
            },
            {
              'title': 'Carpenter',
              'rating': 3.59,
              'reviewCount': 2,
              'price': 3000,
              'duration': '60 mins',
              'services': ['Electricain', 'wiring'],
            },
          ],
        ),
        Recentworkmodel(
          id: "6",
          ratings: "2.8 Ratings",
          title: "Home Services",
          imageurl: "assets/images/repair_12236185.png",
          categories: [
            {
              'title': 'water purifier',
              'imageUrl':
                  'https://tse3.mm.bing.net/th/id/OIP.hJRfTXVBzph7aw0y4LostgHaEK?pid=Api&P=0&h=180',
            },
            {
              'title': 'native purifier',
              'imageUrl':
                  'https://tse4.mm.bing.net/th/id/OIP.OMD2pyN0KZaCB62fRrQedgHaE6?pid=Api&P=0&h=180',
            },
            {
              'title': 'Repair purifier',
              'imageUrl':
                  'https://tse4.mm.bing.net/th/id/OIP.OMD2pyN0KZaCB62fRrQedgHaE6?pid=Api&P=0&h=180',
            },
            {
              'title': 'native purifier',
              'imageUrl':
                  'https://tse4.mm.bing.net/th/id/OIP.OMD2pyN0KZaCB62fRrQedgHaE6?pid=Api&P=0&h=180',
            },
            {
              'title': 'Repair purifier',
              'imageUrl':
                  'https://tse4.mm.bing.net/th/id/OIP.OMD2pyN0KZaCB62fRrQedgHaE6?pid=Api&P=0&h=180',
            },
          ],
          packages: [
            {
              'title': 'Water purifier',
              'rating': 3.59,
              'reviewCount': 2,
              'price': 500,
              'duration': '60 mins',
              'services': ['Aqautic purifing', 'cleaning & repairing'],
              'options': [
                {
                  'type': 'Water purifier',
                  'values': [
                    {'label': 'Aqatic refueling', 'price': 2350},
                    {'label': 'water purifing', 'price': 2000},
                    {'label': 'clean water', 'price': 300},
                    {'label': 'No refuling', 'price': 0},
                  ],
                },
                {
                  'type': 'Aqautic purifing',
                  'values': [
                    {'label': 'Aqatic refueling', 'price': 350},
                    {'label': 'water purifing', 'price': 300},
                    {'label': 'No refuling', 'price': 0},
                  ],
                },
              ],
            },
            {
              'title': 'Aqatic purifier',
              'rating': 3.59,
              'reviewCount': 2,
              'price': 3000,
              'duration': '60 mins',
              'services': ['Aqautic purifing', 'cleaning & repairing'],
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
