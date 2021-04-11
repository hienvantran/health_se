import 'dart:convert';
import 'package:health_se/Controller/NetworkController.dart';
import 'package:health_se/Entity/InfectiousDiseaseMap.dart';

class MapHandler extends NetworkController {
  List<InfectiousDiseaseMap> parseObjectFormat(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    print(parsed);
    return parsed
        .map<InfectiousDiseaseMap>(
            (json) => InfectiousDiseaseMap.fromJson(json))
        .toList();
  }

  @override
  InfectiousDiseaseMap parseOneObject(String responseBody) {
    final parsed = jsonDecode(responseBody);
    InfectiousDiseaseMapList result = InfectiousDiseaseMapList.fromJson(parsed);
    return result.mapList[0]; //returns the map of the specified date
  }
}
