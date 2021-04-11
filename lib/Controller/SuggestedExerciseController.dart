import 'package:health_se/Controller/SuggestedExerciseHandler.dart';
import 'package:health_se/Entity/SuggestedExercise.dart';

class SuggestedExerciseController {
  static Future<List<dynamic>> getAllExercises() {
    return SuggestedExerciseHandler().getListOfObjects('/suggestedExercise');
  }

  static Future<String> getSugExercise(
      int intakeCal, int maintenanceCal) async {
    String output = '';
    int surplus = intakeCal - maintenanceCal;

    if (surplus <= 0) {
      return "Your calorie intake for today is LESS than your maintenance calories.\n\nExercise info will not be displayed\n";
    }
    List<SuggestedExercise> list = await getAllExercises();
    for (int i = 0; i < list.length; i++) {
      output = output + calExerciseTime(surplus, list[i]);
    }
    return output;
  }

  static String calExerciseTime(int surplus, SuggestedExercise sugExercise) {
    String name = sugExercise.getName();
    int duration = (surplus ~/ sugExercise.getCalorieBurnPerMin());
    return name + ': ' + duration.toString() + "min\n";
  }
}
