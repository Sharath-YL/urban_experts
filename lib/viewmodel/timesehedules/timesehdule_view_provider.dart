import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mychoice/data/models/timesechudele_model.dart';

class TimeScheduleViewProvider with ChangeNotifier {
  bool _isLoading = false;
  List<BookingSlot> _timeSlots = [];
  Map<String, List<BookingSlot>> _bookedSlots = {};
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  String? _selectedTimeSlot;

  bool get isLoading => _isLoading;
  List<BookingSlot> get timeSlots => _timeSlots;
  Map<String, List<BookingSlot>> get bookedSlots => _bookedSlots;
  DateTime get selectedDate => _selectedDate;
  DateTime get focusedDate => _focusedDate;
  String? get selectedTimeSlot => _selectedTimeSlot;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set timeSlots(List<BookingSlot> value) {
    _timeSlots = value;
    notifyListeners();
  }

  set bookedSlots(Map<String, List<BookingSlot>> value) {
    _bookedSlots = value;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    _focusedDate = date;
    _selectedTimeSlot = null; 
    notifyListeners();
    fetchScheduleData();
  }

  void setSelectedTimeSlot(String? timeSlot) {
    _selectedTimeSlot = timeSlot;
    notifyListeners();
  }

  Future<void> fetchScheduleData() async {
    isLoading = true;

    await Future.delayed(Duration(seconds: 1));

    _timeSlots = [
      '09:00 AM', '10:00 AM', '11:00 AM', '12:00 PM',
      '01:00 PM', '02:00 PM', '03:00 PM', '04:00 PM',
      '05:00 PM', '06:00 PM',
    ].map((time) => BookingSlot(time: time)).toList();

    _bookedSlots = {
      DateFormat('yyyy-MM-dd').format(DateTime.now()): [
        BookingSlot(time: '10:00 AM', isBooked: true),
        BookingSlot(time: '02:00 PM', isBooked: true),
      ],
      DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 1))): [
        BookingSlot(time: '11:00 AM', isBooked: true),
        BookingSlot(time: '03:00 PM', isBooked: true),
      ],
    };

    isLoading = false;
  }
}