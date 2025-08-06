// lib/providers/booking_provider.dart
import 'package:flutter/material.dart';
import 'package:mychoice/data/models/bookingmodel.dart';

class BookingProvider with ChangeNotifier {
  List<Booking> _bookings = [];
  bool _isLoading = true;

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;

  Future<void> fetchBookings() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));

    _bookings = [
      Booking(
        id: '1',
        title: 'Mens Hair cut',
        rating: 5.0,
        price: 2500,
        duration: '60mins',
        imageUrl:
            'https://tse3.mm.bing.net/th/id/OIP.RDN06zToKAL3Lbx9B7OxJgHaDa?pid=Api&P=0&h=180',
        providerName: 'Sharath',
        providerImageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
        otp: '5831',
        service: 'Mens Hair cut',
        dateTime: 'July 28, 2025, 2:00 PM',
        address: '#123, Sunshine Apartments, Indiranagar',
        timeline: [
          TimelineItem(event: 'Order Placed', time: 'July 28, 2025, 1:00 PM'),
          TimelineItem(
            event: 'Provider Assigned',
            time: 'July 28, 2025, 1:30 PM',
          ),
          TimelineItem(event: 'In Progress', time: 'July 28, 2025, 2:00 PM'),
          TimelineItem(event: 'Completed', time: 'July 28, 2025, 3:00 PM'),
        ],
        totalAmount: '₹2,500.00',
        paymentMode: 'Paid via UPI',
      ),
      Booking(
        id: '2',
        title: 'AC and Appliances Repair',
        rating: 3.5,
        price: 4000,
        duration: '120mins',
        imageUrl:
            'https://tse3.mm.bing.net/th/id/OIP.KIZyFbNVIlvn41MHrMC1bgHaE8?pid=Api&P=0&h=180',
        providerName: 'Vikram',
        providerImageUrl: 'https://randomuser.me/api/portraits/men/33.jpg',
        otp: '9274',
        service: 'AC Deep Clean',
        dateTime: 'July 29, 2025, 10:00 AM',
        address: '#456, Green Valley, Koramangala',
        timeline: [
          TimelineItem(event: 'Order Placed', time: 'July 29, 2025, 9:00 AM'),
          TimelineItem(
            event: 'Provider Assigned',
            time: 'July 29, 2025, 9:30 AM',
          ),
          TimelineItem(event: 'In Progress', time: 'July 29, 2025, 10:00 AM'),
          TimelineItem(event: 'Completed', time: 'July 29, 2025, 11:30 AM'),
        ],
        totalAmount: '₹4,000.00',
        paymentMode: 'Paid via Credit Card',
      ),
      Booking(
        id: '3',
        title: 'cleaning & pest control',
        rating: 4.5,
        price: 4500,
        duration: '100mins',
        imageUrl:
            'https://tse3.mm.bing.net/th/id/OIP.bLpJha5mn3nGDNYZ9MqgpAHaDt?pid=Api&P=0&h=180',
        providerName: 'MAdhi',
        providerImageUrl: 'https://randomuser.me/api/portraits/men/33.jpg',
        otp: '9274',
        service: 'cleaning & pest control',
        dateTime: 'July 29, 2025, 10:00 AM',
        address: '#456, hoskerhlli, rrnagar',
        timeline: [
          TimelineItem(event: 'Order Placed', time: 'July 29, 2025, 9:00 AM'),
          TimelineItem(
            event: 'Provider Assigned',
            time: 'July 29, 2025, 9:30 AM',
          ),
          TimelineItem(event: 'In Progress', time: 'July 29, 2025, 10:00 AM'),
          TimelineItem(event: 'Completed', time: 'July 29, 2025, 11:30 AM'),
        ],
        totalAmount: '₹4,500.00',
        paymentMode: 'Paid via Credit Card',
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }
}
