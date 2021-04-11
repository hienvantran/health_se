import 'dart:convert';
import 'package:health_se/Entity/InfectiousDisease.dart';
import 'package:health_se/Controller/NetworkController.dart';

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
  }
}
