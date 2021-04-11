import 'dart:async';
import 'package:health_se/Controller/GymMapHandler.dart';

class GymMapController {
  static Future<dynamic> loadMap() async {
    Future<dynamic> mapNeeded =
        GymMapHandler().getObject('/suggestedExercise/gym/map');
    return mapNeeded;
  }
}
