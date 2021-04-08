import "package:health_se/entity/Clusters.dart";
import 'package:health_se/Entity/PointSchema.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:health_se/Controller/FilterController.dart';
import 'package:health_se/Entity/InfectiousDiseaseMap.dart';

class InfectiousMapController {
  //get the midpoint of the clusters

  void getInput() {}

  //LoadFilteredMap()
  Future<InfectiousDiseaseMap> loadFilteredMap(
      PointSchema userInputLocation) async {
    getInput();
    var date = new DateTime.now();

    //get today's map
    InfectiousDiseaseMap mapNeeded = await FilterController.getFilteredCases(
        "Dengue", userInputLocation, date.toIso8601String());

    return mapNeeded;
  }
}
