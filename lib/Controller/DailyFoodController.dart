import 'package:health_se/Controller/DailyFoodHandler';
import 'package:health_se/Entity/FoodChoices.dart';
import 'package:health_se/Entity/FoodRecord.dart';
import 'package:health_se/Controller/UserProfileController.dart';
import 'dart:collection';
import 'package:intl/intl.dart';

class DailyFoodController {
  static List<FoodChoices> test;

  static Future<List<dynamic>> getAllFoodChoices() {
    FoodChoicesHandler u = new FoodChoicesHandler();
    return u.getListOfObjects('/dailyDiet/food');
  }

  static String getA() {
    return 'a';
  }

  static Future<void> addRecord(
      String userName, int amount, String name) async {
    print("test\n");
    UserProfileHandler u = new UserProfileHandler();
    int calPerGram = await getFoodChoiceByName(name);
    print('test3\n');
    print(calPerGram);
    print('\n');
    String foodAmount = calCalorie(amount, calPerGram).toString();
    print(foodAmount);
    print('\n');

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    print(formattedDate);
    print('\n');
//    HashMap newRecord = new HashMap<String, String>();
//    newRecord['foodCategory'] = name;
//    newRecord['foodAmount'] = foodAmount;
//    newRecord['timestamps'] = formattedDate;
//    'timestamps': formattedDate]
    Map<String, String> newRecord = {
      'foodCategory': name,
      'foodAmount': foodAmount,
      'timestamps': formattedDate
    };
    print('test4\n');
    print(newRecord);

    String url = '/userprofile/604fd4b12630973608ce2e36/foodrecords';
    await u.post(url, newRecord);
  }

  static Future<int> getFoodChoiceByName(String name) async {
    List<FoodChoices> foodChoiceList = await getAllFoodChoices();
    for (int i = 0; i <= foodChoiceList.length; i++) {
      if (foodChoiceList[i].getName() == name) {
        print("test2\n");
        print(foodChoiceList[i].getCalorie());
        return foodChoiceList[i].getCalorie();
      }
    }
  }

  static int calCalorie(int amount, int calPerGram) {
    return amount * calPerGram;
  }
}
