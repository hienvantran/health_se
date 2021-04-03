import 'dart:convert';
import '../Entity/DietPlan.dart';
import 'NetworkController.dart';

class SuggestedDietController extends NetworkController {
  @override
  List<DietPlan> parseObjectFormat(String responseBody) {
    // TODO: implement parseObjectFormat
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<DietPlan>((json) => DietPlan.fromJson(json)).toList();
  }

  @override
  DietPlan parseOneObject(String responseBody) {
    // TODO: implement parseOneObject
    final parsed = jsonDecode(responseBody);
    return DietPlan.fromJson(parsed);
    //parsed.map<HealthDisease>((json) => HealthDisease.fromJson(json));
  }
}
