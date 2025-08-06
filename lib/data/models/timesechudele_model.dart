class BookingSlot {
  final String time;
  final bool isBooked;

  BookingSlot({required this.time, this.isBooked = false});

  factory BookingSlot.fromJson(Map<String, dynamic> json) {
    return BookingSlot(
      time: json['time'] as String,
      isBooked: json['isBooked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'time': time, 'isBooked': isBooked};
  }
}
