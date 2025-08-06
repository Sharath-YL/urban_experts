import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mychoice/utils/exports.dart';
import 'package:shared_preferences/shared_preferences.dart'; 

class LocationProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String? _address;
  String? get address => _address;
  set address(String? value) {
    print("address in set function is $value");
    _address = value;
    notifyListeners();
  }

  Placemark? _placemarkValue;
  Placemark? get placemarkValue => _placemarkValue;
  set placemarkValue(Placemark? value) {
    _placemarkValue = value;
    notifyListeners();
  }

  Position? _positionValue;
  Position? get positionValue => _positionValue;
  set positionValue(Position? value) {
    _positionValue = value;
    notifyListeners();
  }

  Future<Position> _determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("location services are disabled");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Location Settings'),
            content: const Text(
              'Please enable location services to fetch the current location',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await Geolocator.openLocationSettings();
                  getposition(context);
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      print("permission is denied to access the location");
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getposition(BuildContext context) async {
    try {
      isLoading = true;
      Position position = await _determinePosition(context);
      await getpositionfromlatandlong(position);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("permission is denied to access the location1");
      await prefs.setString('latitude', position.latitude.toString());
      await prefs.setString('longitude', position.longitude.toString());
      print("got the position from provider and position is $position");
    } catch (e) {
      print("Error in getposition: $e");
      isLoading = false;
      notifyListeners();
    }
    isLoading = false;
  }

  Future<void> getpositionfromlatandlong(Position position) async {
    try {
      positionValue = position;
      List<Placemark> placemark = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      placemarkValue = placemark[0];
      Placemark place = placemark[0];
      address =
          '${place.thoroughfare},${place.subLocality},${place.subAdministrativeArea},${place.administrativeArea},${place.postalCode}';
      print("address in get position from lat long is $address");
    } catch (e) {
      print("Error in getpositionfromlatandlong: $e");
    }
    isLoading = false;
    notifyListeners();
  }
}
