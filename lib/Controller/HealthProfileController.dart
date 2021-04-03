import 'dart:convert';

import '../Entity/HealthDiseases.dart';
import 'NetworkController.dart';

class HealthDiseaseHandler extends NetworkController {
  //returns all the list of healthDisease

  //either implement in network handler or here.

  //implements the abstract parse of information
  //returns a list of healthDisease

  @override
  List<HealthDisease> parseObjectFormat(String responseBody) {
    // TODO: implement parseObjectFormat
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<HealthDisease>((json) => HealthDisease.fromJson(json))
        .toList();
  }

  @override
  HealthDisease parseOneObject(String responseBody) {
    // TODO: implement parseOneObject
    final parsed = jsonDecode(responseBody);
    return HealthDisease.fromJson(parsed);
    //parsed.map<HealthDisease>((json) => HealthDisease.fromJson(json));
  }
}
