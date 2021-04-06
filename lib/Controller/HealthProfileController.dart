import 'dart:convert';
import '../Entity/HealthDiseases.dart';
import '../Entity/UserProfile.dart';
import 'NetworkController.dart';
import 'HealthProfileHandler.dart';

class HealthProfileController {
  static List<HealthDisease> diseases;

  static Future<List<dynamic>> getHealthDiseases() {
    UserProfile u;
    Future<List<dynamic>> allDiseases =
        HealthDiseaseHandler().get('/healthDisease');
  }
}
