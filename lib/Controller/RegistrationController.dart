import 'dart:convert';
import 'package:health_se/Controller/UserInfoController.dart';
import 'package:health_se/Controller/UserProfileHandler.dart';
import 'package:health_se/Entity/UserProfile.dart';

class RegistrationController {
  static Future<bool> createProfile(
      String email, String username, String password) async {
    UserProfileHandler u = new UserProfileHandler();

    Map<String, String> newRecord = {
      "name": "Name",
      "age": "Age",
      "gender": "Gender",
      'weight': "0",
      'height': "0",
      'waist': "0",
      'email': email,
      'username': username,
      'password': password
    };

    String url = '/userProfile';
    final res = await u.post(url, newRecord);
    print(res);
    print("This is :$res");
    if (res == -1)
      return false;
    else {
      UserInfoController.user = UserProfile.fromJson(jsonDecode(res));
      return true;
    }
  }
}
