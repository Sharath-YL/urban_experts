import 'package:flutter/material.dart';
import 'package:mychoice/data/models/bookingmodel.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/utils/exports.dart';
import 'package:mychoice/view/Timesedules/timesecdule.dart';
import 'package:mychoice/view/auth_screens/loginscreen.dart';
import 'package:mychoice/view/bookings/booking_screens.dart';
import 'package:mychoice/view/bookings/vieworderdertailsScreen.dart';
import 'package:mychoice/view/cart/Mencartscreen.dart';
import 'package:mychoice/view/cart/confirmbookingscreen.dart';
import 'package:mychoice/view/descriptions/descriptionscreen.dart';
import 'package:mychoice/view/home_screens/home_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.homescreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case RouteName.login:
        return MaterialPageRoute(builder: (context) => Loginscreen());
      case RouteName.description:
        final id = settings.arguments;
        if (id is String) {
          return MaterialPageRoute(
            builder: (context) => Descriptionscreen(id: id),
          );
        } else {
          return MaterialPageRoute(
            builder:
                (context) => Scaffold(
                  body: Center(
                    child: Text(
                      'Error: Invalid or missing service ID',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ),
                ),
          );
        }
      case RouteName.mencartscreen:
        return MaterialPageRoute(builder: (context) => MenCartScreen());
      case RouteName.viewordersetailsScreen:
        if (settings.arguments is Booking) {
          final booking = settings.arguments as Booking;
          return MaterialPageRoute(
            builder: (context) => Vieworderdertailsscreen(booking: booking),
          );
        } else {
          return MaterialPageRoute(
            builder:
                (_) => const Scaffold(
                  body: Center(child: Text('Error: Booking data not provided')),
                ),
          );
        }
      case RouteName.bookingscreen:
        return MaterialPageRoute(builder: (context) => BookingScreens());
      case RouteName.timesechudlescreen:
        return MaterialPageRoute(builder: (context) => TimesecduleScreen());
      case RouteName.confirmbookingscreen:
        return MaterialPageRoute(builder: (context) => Confirmbookingscreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}

class Arguments {
  final String id;

  Arguments({required this.id});
}
