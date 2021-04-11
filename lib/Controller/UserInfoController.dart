import 'package:health_se/Entity/InfectiousDisease.dart';
import 'package:health_se/Entity/HealthDiseases.dart';
import 'package:health_se/Entity/UserProfile.dart';
import 'package:geolocator/geolocator.dart';

class UserInfoController {
  static UserProfile user;

  static List<HealthDisease> healthDiseases;

  static Future<Position> location;

  static List<InfectiousDisease> infectiousDiseases;
}
