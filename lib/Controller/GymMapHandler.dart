import 'dart:convert';

import 'package:health_se/Controller/NetworkController.dart';
import 'package:health_se/Entity/GymMap.dart';
import 'package:health_se/Entity/GymPoints.dart';
import 'package:health_se/Entity/GymMap.dart';
import 'package:health_se/Entity/PointSchema.dart';

class GymMapHandler extends NetworkController {
  List<dynamic> parseObjectFormat(String responseBody) {}

  @override
  GymMap parseOneObject(String responseBody) {
    // TODO: implement parseOneObject
    final parsed = jsonDecode(responseBody);
    return GymMap.fromJson(parsed);
  }
}
