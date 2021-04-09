import 'package:health_se/Entity/InfectiousDisease.dart';
import 'package:health_se/UI/HealthProfileUI.dart';
import '../Entity/HealthDiseases.dart';
import '../Entity/UserProfile.dart';
import 'package:health_se/Entity/PointSchema.dart';
import 'package:geolocator/geolocator.dart';

class UserInfoController {
  static UserProfile user;

  static List<HealthDisease> healthDiseases;

  static Future<Position> location;

  static List<InfectiousDisease> infectiousDiseases;
}
