import 'package:health_se/Entity/PointSchema.dart';
import 'package:health_se/Controller/FilterController.dart';
import 'package:health_se/Entity/InfectiousDiseaseMap.dart';

class InfectiousMapController {
  static Future<InfectiousDiseaseMap> loadFilteredMap(
      PointSchema userInputLocation) async {
    var date = new DateTime.now();

    //get today's map
    InfectiousDiseaseMap mapNeeded = await FilterController.getFilteredCases(
        "Dengue", userInputLocation, date.toIso8601String());

    return mapNeeded;
  }
}
