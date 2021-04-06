import 'package:health_se/Controller/DailyFoodHandler.dart';
import 'package:health_se/Entity/FoodChoices.dart';
import 'package:health_se/Controller/UserProfileController.dart';
import 'package:health_se/Entity/UserProfile.dart';
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

  static Future<int> addRecord(String userName, int amount, String name) async {
    UserProfileHandler u = new UserProfileHandler();
    int calPerGram = await getFoodChoiceByName(name);

    String foodAmount = calCalorie(amount, calPerGram).toString();

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    Map<String, String> newRecord = {
      'foodCategory': name,
      'foodAmount': foodAmount,
      'timestamps': formattedDate
    };

    String url = '/userprofile/' + userName + '/foodrecords';
    await u.post(url, newRecord);

    UserProfile up = await u.getObject('/userprofile/' + userName);
    List<dynamic> list = up.getFoodRecordsList();
    print("test1\n");
    int intakeCal = calculateTotalCalorie(list);
    print("test2\n");
    return intakeCal;
  }

  static Future<int> getFoodChoiceByName(String name) async {
    List<FoodChoices> foodChoiceList = await getAllFoodChoices();
    for (int i = 0; i < foodChoiceList.length; i++) {
      if (foodChoiceList[i].getName() == name) {
        return foodChoiceList[i].getCalorie();
      }
    }
  }

  static int calCalorie(int amount, int calPerGram) {
    return amount * calPerGram;
  }

  static int calculateTotalCalorie(List<dynamic> list) {
    int totalCalorie = 0;
    for (int i = 0; i < list.length; i++) {
      totalCalorie += list[i]['foodAmount'];
    }
//    print("test1\n");
//    print(totalCalorie);
    return totalCalorie;
  }
}
