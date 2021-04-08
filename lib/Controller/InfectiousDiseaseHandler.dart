import 'dart:convert';
import '../Entity/InfectiousDisease.dart';
import 'NetworkController.dart';

class InfectiousDiseaseHandler extends NetworkController {
  @override
  List<InfectiousDisease> parseObjectFormat(String responseBody) {
    // TODO: implement parseObjectFormat
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<InfectiousDisease>((json) => InfectiousDisease.fromJson(json))
        .toList();
  }

  @override
  InfectiousDisease parseOneObject(String responseBody) {
    // TODO: implement parseOneObject
    final parsed = jsonDecode(responseBody);
    return InfectiousDisease.fromJson(parsed);
    //parsed.map<HealthDisease>((json) => HealthDisease.fromJson(json));
  }
}
