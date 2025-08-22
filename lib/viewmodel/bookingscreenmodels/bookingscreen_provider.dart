import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mychoice/data/models/bookingmodel.dart';
import 'package:mychoice/data/models/control_pest_model.dart';
import 'package:mychoice/data/models/recentworkmodel.dart';
import 'package:mychoice/viewmodel/addingmenspackages/Cartprovider.dart';
import 'package:mychoice/viewmodel/control_pest_control_view/contro_pest_provider.dart';
import 'package:mychoice/viewmodel/homescreenview_model/homescreenview_provider.dart';
import 'package:mychoice/viewmodel/location_view/location_provider.dart';
import 'package:mychoice/viewmodel/timesehedules/timesehdule_view_provider.dart';

class BookingProvider with ChangeNotifier {
  List<Booking> _bookings = [];
  bool _isLoading = false;

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;

  Future<void> fetchBookings() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();
  }

  void addBooking({
    required TimeScheduleViewProvider timeProvider,
    required LocationProvider locationProvider,
    required HomescreenviewProvider homeprovider,
    required String itemId,
  }) {
    final String? bookedTime = timeProvider.selectedTimeSlot;
    final DateTime? bookedDate = timeProvider.selectedDate;
    final String? address = locationProvider.address;

    if (bookedDate == null || bookedTime == null || address == null
    // cartItems.isEmpty
    ) {
      debugPrint("Missing booking details");
      return;
    }

    final Recentworkmodel serviceitem = homeprovider.recentworkmodel.firstWhere(
      (item) => item.id == itemId,
      orElse: () => throw Exception('Pest control item not found'),
    );
    final String imageUrl =
        serviceitem.imageurl.isNotEmpty
            ? serviceitem.imageurl
            : 'https://tse3.mm.bing.net/th/id/OIP.CU6e8R5wcdDgGuNg82tbewHaDY?pid=Api&P=0&h=180';

    final String dateTime =
        '${DateFormat('MMM d, yyyy').format(bookedDate)} at $bookedTime';
    final String bookingId = DateTime.now().millisecondsSinceEpoch.toString();

    final List<Map<String, dynamic>> selectedOptions =
        serviceitem.selectedoptoins
            .map((o) {
              final q = homeprovider.getQty(o.id);
              return {
                'id': o.id,
                'title': '${o.placename} x$q',
                'qty': q,
                'unitPrice': o.price,
                'price': (o.price ?? 0) * q,
              };
            })
            .where((m) => (m['qty'] as int) > 0)
            .toList();

    int _toInt(dynamic v) =>
        v is num ? v.toInt() : int.tryParse('${v ?? ''}') ?? 0;

    final int totalPrice =
        selectedOptions.isNotEmpty
            ? selectedOptions.fold(0, (sum, m) => sum + (m['price'] as int))
            : serviceitem.price;

    final newBooking = Booking(
      id: bookingId,
      title: serviceitem.title,
      status: 'Pending',
      rating: 4.5,
      price: totalPrice,
      duration: '60mins',
      imageurl: imageUrl,
      providerName: '',
      providerImageUrl: '',
      otp: '1234',
      service: serviceitem.title,
      dateTime: dateTime,
      address: address,
      location: address,
      totalAmount: totalPrice.toString(),

      selectedOptions: selectedOptions,
      timeline: [
        TimelineItem(
          event: 'Order Placed',
          time: DateFormat('MMM d, yyyy, h:mm a').format(DateTime.now()),
        ),
      ],
      paymentMode: 'Paid via UPI',
      extraWork: const [],
      extraWorkApproved: false,
    );

    _bookings.add(newBooking);
    notifyListeners();

    _startStatusTransitionTimer(bookingId);
  }

  int _parseRupees(String s) {
    final digits = s.replaceAll(RegExp(r'[^\d]'), '');
    return digits.isEmpty ? 0 : int.parse(digits);
  }

  String _formatRupees(int amount) => '₹$amount.00';

  void addExtraWork(String bookingId, List<Map<String, dynamic>> newWork) {
    final i = _bookings.indexWhere((b) => b.id == bookingId);
    if (i == -1) return;
    _bookings[i] = _bookings[i].copyWith(
      extraWork: newWork,
      timeline: [
        ..._bookings[i].timeline,
        TimelineItem(
          event: 'Additional work proposed',
          time: DateFormat('MMM d, yyyy, h:mm a').format(DateTime.now()),
        ),
      ],
    );
    notifyListeners();
  }

  void approveExtraWork(String bookingId) {
    final i = _bookings.indexWhere((b) => b.id == bookingId);
    if (i == -1) return;
    final b = _bookings[i];
    final oldTotal = _parseRupees(b.totalAmount);
    final extraTotal = b.extraWork.fold(
      0,
      (sum, e) => sum + ((e['price'] as int?) ?? 0),
    );
    final newTotal = oldTotal + extraTotal;

    _bookings[i] = b.copyWith(
      extraWorkApproved: true,
      totalAmount: _formatRupees(newTotal),
      timeline: [
        ...b.timeline,
        TimelineItem(
          event: 'Additional work approved',
          time: DateFormat('MMM d, yyyy, h:mm a').format(DateTime.now()),
        ),
      ],
    );
    notifyListeners();
  }

  void rejectExtraWork(String bookingId) {
    final i = _bookings.indexWhere((b) => b.id == bookingId);
    if (i == -1) return;
    final b = _bookings[i];
    _bookings[i] = b.copyWith(
      extraWork: const [],
      extraWorkApproved: false,
      timeline: [
        ...b.timeline,
        TimelineItem(
          event: 'Additional work rejected',
          time: DateFormat('MMM d, yyyy, h:mm a').format(DateTime.now()),
        ),
      ],
    );
    notifyListeners();
  }

  void addpestcontrolbooking({
    required TimeScheduleViewProvider timeProvider,
    required ControPestProvider pestProvider,
    required String itemId,
    required LocationProvider locationProvider,
  }) {
    final String? bookedTime = timeProvider.selectedTimeSlot;
    final DateTime? bookedDate = timeProvider.selectedDate;
    final String? address = locationProvider.address ?? "";

    if (bookedDate == null || bookedTime == null || address == null) {
      debugPrint("Missing booking details for pest control booking");
      return;
    }

    try {
      final ControlPestModel pestItem = pestProvider.items.firstWhere(
        (item) => item.id == itemId,
        orElse: () => throw Exception('Pest control item not found'),
      );

      final List<Map<String, dynamic>> selectedOptions =
          pestItem.selectedOptions
              .map((o) {
                final q = pestProvider.getQty(o.id);
                return {
                  'id': o.id,
                  'title': '${o.placename} x$q',
                  'qty': q,
                  'unitPrice': o.price,
                  'price': (o.price ?? 0) * q,
                };
              })
              .where((m) => (m['qty'] as int) > 0)
              .toList();

      final int totalPrice =
          selectedOptions.isNotEmpty
              ? selectedOptions.fold(0, (sum, m) => sum + (m['price'] as int))
              : pestItem.price;

      final String imageUrl =
          pestItem.image.isNotEmpty
              ? pestItem.image
              : 'https://tse3.mm.bing.net/th/id/OIP.CU6e8R5wcdDgGuNg82tbewHaDY?pid=Api&P=0&h=180';

      _addBookingInternal(
        bookedTime: bookedTime,
        bookedDate: bookedDate,
        address: address,
        title: pestItem.title,
        totalPrice: totalPrice,
        imageUrl: imageUrl,
        selectedOptions: selectedOptions,
        service: pestItem.title,
        location: pestItem.placename,
      );
    } catch (e) {
      debugPrint("Error adding pest control booking: $e");
      return;
    }
  }

  void _addBookingInternal({
    required String bookedTime,
    required DateTime bookedDate,
    required String address,
    required String title,
    required int totalPrice,
    required String imageUrl,
    required List<Map<String, dynamic>> selectedOptions,
    required String service,
    String? location,
  }) {
    final String dateTime =
        '${DateFormat('MMM d, yyyy').format(bookedDate)} at $bookedTime';
    final String bookingId = DateTime.now().millisecondsSinceEpoch.toString();

    final newBooking = Booking(
      id: bookingId,
      title: title,
      status: 'Pending',
      rating: 4.5,
      price: totalPrice,
      duration: '60mins',
      imageurl: imageUrl,
      providerName: '',
      providerImageUrl: '',
      otp: '1234',
      service: service,
      dateTime: dateTime,
      address: address,
      location: location ?? address,
      selectedOptions: selectedOptions,
      timeline: [
        TimelineItem(
          event: 'Order Placed',
          time: DateFormat('MMM d, yyyy, h:mm a').format(DateTime.now()),
        ),
      ],
      totalAmount: '₹$totalPrice.00',
      paymentMode: 'Paid via UPI',
      extraWork: const [],
      extraWorkApproved: false,
    );

    _bookings.add(newBooking);
    notifyListeners();

    _startStatusTransitionTimer(bookingId);
  }

  void _startStatusTransitionTimer(String bookingId) {
    Timer(const Duration(seconds: 20), () {
      final idx = _bookings.indexWhere((b) => b.id == bookingId);
      if (idx == -1) return;

      final current = _bookings[idx];
      _bookings[idx] = current.copyWith(
        status: 'Active',
        providerName: 'Sharath',
      );

      _bookings[idx] = Booking(
        id: current.id,
        title: current.title,
        status: 'Active',
        rating: current.rating,
        price: current.price,
        duration: current.duration,
        imageurl: current.imageurl,
        providerName: 'Sharath',
        providerImageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
        otp: current.otp,
        service: current.service,
        dateTime: current.dateTime,
        address: current.address,
        location: current.location,
        selectedOptions: current.selectedOptions,
        timeline: [
          ...current.timeline,
          TimelineItem(
            event: 'Provider Assigned',
            time: DateFormat('MMM d, yyyy, h:mm a').format(DateTime.now()),
          ),
        ],
        totalAmount: current.totalAmount,
        paymentMode: current.paymentMode,
        extraWork: current.extraWork,
        extraWorkApproved: current.extraWorkApproved,
        isPestControl: current.isPestControl,
      );

      notifyListeners();

      Timer(const Duration(seconds: 15), () {
        addExtraWork(bookingId, [
          {'title': 'Sofa shampoo (3-seater)', 'price': 499},
          {'title': 'Window deep clean (2 rooms)', 'price': 349},
        ]);
      });

      Timer(const Duration(seconds: 20), () {
        final idx2 = _bookings.indexWhere((b) => b.id == bookingId);
        if (idx2 == -1) return;
        final cur = _bookings[idx2];

        _bookings[idx2] = Booking(
          id: cur.id,
          title: cur.title,
          status: 'Completed',
          rating: cur.rating,
          price: cur.price,
          duration: cur.duration,
          imageurl: cur.imageurl,
          providerName: cur.providerName,
          providerImageUrl: cur.providerImageUrl,
          otp: cur.otp,
          service: cur.service,
          dateTime: cur.dateTime,
          address: cur.address,
          location: cur.location,
          selectedOptions: cur.selectedOptions,
          timeline: [
            ...cur.timeline,
            TimelineItem(
              event: 'Completed',
              time: DateFormat('MMM d, yyyy, h:mm a').format(DateTime.now()),
            ),
          ],
          totalAmount: cur.totalAmount,
          paymentMode: cur.paymentMode,
          extraWork: cur.extraWork,
          extraWorkApproved: cur.extraWorkApproved,
          isPestControl: cur.isPestControl,
        );
        notifyListeners();
      });
    });
  }

  void cancelBooking(String bookingId) {
    final idx = _bookings.indexWhere((b) => b.id == bookingId);
    if (idx == -1) return;

    if (_bookings[idx].status == 'Active') {
      final cur = _bookings[idx];
      _bookings[idx] = Booking(
        id: cur.id,
        title: cur.title,
        status: 'Cancelled',
        rating: cur.rating,
        price: cur.price,
        duration: cur.duration,
        imageurl: cur.imageurl,
        providerName: cur.providerName,
        providerImageUrl: cur.providerImageUrl,
        otp: cur.otp,
        service: cur.service,
        dateTime: cur.dateTime,
        address: cur.address,
        location: cur.location,
        selectedOptions: cur.selectedOptions,
        timeline: [
          ...cur.timeline,
          TimelineItem(
            event: 'Cancelled',
            time: DateFormat('MMM d, yyyy, h:mm a').format(DateTime.now()),
          ),
        ],
        totalAmount: cur.totalAmount,
        paymentMode: cur.paymentMode,
        extraWork: cur.extraWork,
        extraWorkApproved: cur.extraWorkApproved,
        isPestControl: cur.isPestControl,
      );
      notifyListeners();
    }
  }
}
