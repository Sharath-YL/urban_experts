import 'package:flutter/material.dart';
import 'package:mychoice/data/models/bookingmodel.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/view/Timesedules/timesecdule.dart';
import 'package:mychoice/view/auth_screens/loginscreen.dart';
import 'package:mychoice/view/auth_screens/otpscreen.dart';
import 'package:mychoice/view/auth_screens/signupscreen.dart';
import 'package:mychoice/view/bookings/booking_screens.dart';
import 'package:mychoice/view/bookings/vieworderdertailsScreen.dart';
import 'package:mychoice/view/cart/Mencartscreen.dart';
import 'package:mychoice/view/cart/confirmbookingscreen.dart';
import 'package:mychoice/view/cleaning_pestcontrol_screens/cleaning_description_screen.dart';
import 'package:mychoice/view/cleaning_pestcontrol_screens/cleaning_pest_controlscreen.dart';
import 'package:mychoice/view/cleaning_pestcontrol_screens/pestcontrol_confirmation_screen.dart';
import 'package:mychoice/view/cleaning_pestcontrol_screens/pestcontrol_timeselection.dart';
import 'package:mychoice/view/descriptions/descriptionscreen.dart';
import 'package:mychoice/view/home_screens/home_screen.dart';
import 'package:mychoice/view/home_screens/notifications_screen.dart';
import 'package:mychoice/view/locationscreens/location_screen.dart';
import 'package:mychoice/view/onboardingscreens/onboardingscreen.dart';

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
      case RouteName.onboardingscreen:
        return MaterialPageRoute(builder: (context) => Onboardingscreen());
      case RouteName.bookingscreen:
        return MaterialPageRoute(builder: (context) => BookingScreens());
      case RouteName.timesechudlescreen:
        return MaterialPageRoute(builder: (context) => TimesecduleScreen());
      case RouteName.confirmbookingscreen:
        return MaterialPageRoute(builder: (context) => Confirmbookingscreen());
      case RouteName.signupscreen:
        return MaterialPageRoute(builder: (context) => Signupscreen());

      case RouteName.OtpScreen:
        return MaterialPageRoute(builder: (context) => Otpscreen());
      case RouteName.locationscreen:
        return MaterialPageRoute(builder: (context) => LocationScreen());

      case RouteName.notificationscreen:
        return MaterialPageRoute(builder: (context) => NotificationsScreen());
      case RouteName.cleaningpestcontrolscreen:
        return MaterialPageRoute(
          builder: (context) => CleaningPestControlscreen(),
        );
      case RouteName.cleaningpestcontrodescriptionscreen:
        final id = settings.arguments;
        if (id is String) {
          return MaterialPageRoute(
            builder: (context) => CleaningDescriptionScreen(id: id),
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
      case RouteName.pestcontroltimeselectionselection:
        final id = settings.arguments;
        if (id is String) {
          return MaterialPageRoute(
            builder: (context) => PestcontrolTimeselection(id: id),
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
      case RouteName.pestcontrolconfirmationscreen:
        final id = settings.arguments;
        if (id is String) {
          return MaterialPageRoute(
            builder: (context) => PestcontrolConfirmationScreen(id: id),
          );
        } else {
          return MaterialPageRoute(
            builder:
                (context) => Scaffold(
                  body: Center(child: Text("invalid or missing id")),
                ),
          );
        }

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
