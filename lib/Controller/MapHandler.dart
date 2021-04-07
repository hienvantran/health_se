import 'dart:convert';
import 'package:health_se/controller/NetworkController.dart';
import 'package:health_se/entity/InfectiousDiseaseMap.dart';
import 'dart:developer';

class MapHandler extends NetworkController {

  @override
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
    // log(responseBody);
    // log("it ends");
    final parsed = jsonDecode(responseBody);
    //log(parsed);
    InfectiousDiseaseMapList result = InfectiousDiseaseMapList.fromJson(parsed);
    return result.mapList[0];
  }
}
