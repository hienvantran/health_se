import 'package:geolocator/geolocator.dart';
import 'package:health_se/Controller/UserInfoController.dart';

class LocationController {
  static Future<Position> getCurrentLocation() async {
    final location =
        Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return location;
  }
}
