import 'dart:convert';
import 'package:health_se/Entity/SuggestedExercise.dart';
import 'package:health_se/Controller/NetworkController.dart';

class SuggestedExerciseHandler extends NetworkController {
  @override
  List<SuggestedExercise> parseObjectFormat(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<SuggestedExercise>((json) => SuggestedExercise.fromJson(json))
        .toList();
  }

  @override
  SuggestedExercise parseOneObject(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return SuggestedExercise.fromJson(parsed);
  }
}
