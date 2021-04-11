import 'dart:convert';
import 'package:health_se/Controller/NetworkController.dart';
import 'package:health_se/Entity/GymMap.dart';

class GymMapHandler extends NetworkController {
  List<dynamic> parseObjectFormat(String responseBody) {}

  @override
  GymMap parseOneObject(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return GymMap.fromJson(parsed);
  }
}
