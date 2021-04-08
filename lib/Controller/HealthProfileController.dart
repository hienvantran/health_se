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
    print("Tsesssss\n");
    double BMI = user.getBmi();
    print(BMI);
    int age = int.parse(user.getAge());
    print(age);
    double bodyfat = user.getBodyFatPercentage() / 100;
    print(bodyfat);
    String gender = user.getGender();
    int height = user.getHeight();
    int waist = user.getWaist();

    List<String> list = <String>[];
    if ((BMI > 30.0) && (age > 30) && (bodyfat > 0.25) && (gender == "male"))
      list.add("Hypertension");
    if ((BMI > 30.0) && (age > 30) && (bodyfat > 0.35) && (gender == "female"))
      list.add("Hypertension");
    if ((BMI < 18.0) && (age < 30)) list.add("Malnutrition");
    if ((gender == "female") && (BMI >= 25) && (BMI <= 27.49))
      list.add("Diabetes");
    if ((gender == "M") && (BMI >= 27.5) && (BMI <= 29.99))
      list.add("Diabetes");
    if ((BMI > 23.0) && (BMI < 30.0) && gender == "male" && (waist > 84.0))
      list.add("Heart Disease");
    if ((BMI > 18.4) && (BMI < 27.0) && gender == "female" && (waist > 71.0))
      list.add("Heart Disease");
    if ((height >= 185.0) && (BMI > 25.0) && (gender == "male"))
      list.add("Decreased immune function");
    if ((gender == "female") && (height >= 170.0) && (BMI >= 25.0))
      list.add("Decreased immune function");
    return list;
  }

  static Future<void> getHealthDiseases() async {
    List<String> diseaseNames = getHealthDiseaseNames();
    print("TESTING DISEASES3\n");
    print(diseaseNames);
    String testurl = '/healthDisease';
    List<HealthDisease> testdis =
        await HealthDiseaseHandler().getListOfObjects(testurl);
    for (int j = 0; j < testdis.length; j++) {
      print(testdis[j].getDiseaseName());
      print('\n');
    }
    List<HealthDisease> diseases = <HealthDisease>[];
    for (int i = 0; i < diseaseNames.length; i++) {
      String name = diseaseNames[i];
      print("TESTING DISEASES3\n");
      print(name);
      String url = '/healthDisease/$name';
      HealthDisease dis = await HealthDiseaseHandler().getObject(url);
      diseases.add(dis);
    }
    print("TESTING DISEASES\n");
    print(diseases.length);
    UserInfoController.healthDiseases = diseases;
    print("TESTING DISEASES2\n");
    print(UserInfoController.healthDiseases.length);
  }
}
