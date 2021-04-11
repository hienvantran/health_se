import 'package:geolocator/geolocator.dart';

class LocationController {
  static Future<Position> getCurrentLocation() async {
    final location =
        Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return location;
  }
}
