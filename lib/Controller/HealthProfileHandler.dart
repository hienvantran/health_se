import 'dart:convert';
import 'package:health_se/Entity/HealthDiseases.dart';
import 'package:health_se/Controller/NetworkController.dart';

class HealthDiseaseHandler extends NetworkController {
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
  }
}
