import 'dart:convert';
import 'package:health_se/Entity/DietPlan.dart';
import 'package:health_se/Controller/NetworkController.dart';

class SuggestedDietHandler extends NetworkController {
  @override
  List<DietPlan> parseObjectFormat(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<DietPlan>((json) => DietPlan.fromJson(json)).toList();
  }

  @override
  DietPlan parseOneObject(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return DietPlan.fromJson(parsed);
  }
}
