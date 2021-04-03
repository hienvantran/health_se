import 'package:health_se/Controller/DailyFoodHandler';
import 'package:health_se/Entity/FoodChoices.dart';

class DailyFoodController {
  static List<FoodChoices> test;

  static Future<List<dynamic>> getAllFoodChoices() {
    FoodChoicesHandler u = new FoodChoicesHandler();
    return u.getListOfObjects('/dailyDiet/food');
  }

  static String getA() {
    return 'a';
  }
}
