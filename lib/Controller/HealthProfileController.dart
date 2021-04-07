import 'dart:convert';
import 'package:health_se/UI/HealthProfileUI.dart';

import '../Entity/HealthDiseases.dart';
import '../Entity/UserProfile.dart';
import 'NetworkController.dart';
import 'HealthProfileHandler.dart';
import 'UserInfoController.dart';

class HealthProfileController {
  // static Future<List<dynamic>> getHealthDiseases() {
  //   UserProfile u;
  //   Future<List<dynamic>> allDiseases =
  //       HealthDiseaseHandler().get('/healthDisease');
  // }

  static List<String> getHealthDiseaseNames() {
    UserProfile user = UserInfoController.user;
    double BMI = user.getBmi();
    int age = int.parse(user.getAge());
    double bodyfat = user.getBodyFatPercentage();
    String gender = user.getGender();
    int height = user.getHeight();
    int waist = user.getWaist();

    List<String> list = <String>[];
    if ((BMI > 30.0) && (age > 30) && (bodyfat > 0.25) && (gender == "M"))
      list.add("Hypertension");
    if ((BMI > 30.0) && (age > 30) && (bodyfat > 0.35) && (gender == "F"))
      list.add("Hypertension");
    if ((BMI < 18.0) && (age < 30)) list.add("Malnutrition");
    if ((gender == "F") && (BMI >= 25) && (BMI <= 27.49))
      list.add("Diabetes Mellitus");
    if ((gender == "M") && (BMI >= 27.5) && (BMI <= 29.99))
      list.add("Diabetes Mellitus");
    if ((BMI > 23.0) && (BMI < 30.0) && gender == "M" && (waist > 84.0))
      list.add("Coronary Heart Disease");
    if ((BMI > 18.4) && (BMI < 27.0) && gender == "F" && (waist > 71.0))
      list.add("Coronary Heart Disease");
    if ((height >= 185.0) && (BMI > 25.0) && (gender == "M"))
      list.add("Decreased Immune Function");
    if ((gender == "F") && (height >= 170.0) && (BMI >= 25.0))
      list.add("Decreased Immune Function");
    return list;
  }

  static Future<void> getHealthDiseases() async {
    List<String> diseaseNames = getHealthDiseaseNames();
    List<HealthDisease> diseases = <HealthDisease>[];
    for (int i = 0; i < diseaseNames.length; i++) {
      String name = diseaseNames[i];
      String url = '/healthDisease/$name';
      HealthDisease dis = await HealthDiseaseHandler().getObject(url);
      diseases.add(dis);
    }
    UserInfoController.healthDiseases = diseases;
  }
}
