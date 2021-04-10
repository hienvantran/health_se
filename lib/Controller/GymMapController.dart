import 'dart:async';
import "package:health_se/entity/Clusters.dart";
import 'package:health_se/Entity/PointSchema.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:health_se/Controller/FilterController.dart';
import 'package:health_se/Entity/InfectiousDiseaseMap.dart';
import 'package:health_se/Entity/GymMap.dart';
import 'package:health_se/Controller/GymMapHandler.dart';

class GymMapController {
  //get the midpoint of the clusters

  static Future<GymMap> loadMap() async {
    Future<GymMap> mapNeeded =
        await GymMapHandler().getObject('/suggestedExercise/gym/map');
    return mapNeeded;
  }
}
