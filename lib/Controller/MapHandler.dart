import 'dart:convert';
import 'package:health_se/Controller/NetworkController.dart';
import 'package:health_se/Entity/InfectiousDiseaseMap.dart';
import 'dart:developer';

class MapHandler extends NetworkController {
  List<InfectiousDiseaseMap> parseObjectFormat(String responseBody) {
    // TODO: implement parseObjectFormat
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    print(parsed);
    return parsed
        .map<InfectiousDiseaseMap>(
            (json) => InfectiousDiseaseMap.fromJson(json))
        .toList();
  }

  @override
  InfectiousDiseaseMap parseOneObject(String responseBody) {
    // TODO: implement parseOneObject
    final parsed = jsonDecode(responseBody);
    print(parsed);
    InfectiousDiseaseMapList result = InfectiousDiseaseMapList.fromJson(parsed);
    print(result.mapList[0].cluster.clusterList[0].numberOfCases);
    return result.mapList[0]; //returns the map of the specified date
  }
}
