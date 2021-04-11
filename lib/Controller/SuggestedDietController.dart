import 'package:health_se/Entity/DietPlan.dart';
import 'package:health_se/Controller/SuggestedDietHandler.dart';

class SuggestedDietController {
  static Future<List<int>> getSugDiet(
      String plan, String composition, int calorie) async {
    SuggestedDietHandler sdh = new SuggestedDietHandler();
    DietPlan dietPlan = await sdh.getObject('/dailyDiet/diets/' + plan);

    List<int> nutritionListPrec = dietPlan.getCompositionByString(composition);
    List<int> nutritionList = [
      (nutritionListPrec[0] * calorie ~/ 400),
      (nutritionListPrec[1] * calorie ~/ 400),
      (nutritionListPrec[2] * calorie ~/ 900)
    ];

    return nutritionList;
  }

  static String returnImagePath(int index) {
    String path = '';
    switch (index) {
      case 0:
        path = 'images/High.png';
        break;
      case 1:
        path = 'images/Moderate.png';
        break;
      case 2:
        path = 'images/Low.png';
        break;
    }
    return path;
  }
}
