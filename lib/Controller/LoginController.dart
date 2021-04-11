import 'dart:async';
import 'dart:convert';
import 'package:health_se/Controller/UserProfileHandler.dart';
import 'package:health_se/Controller/UserInfoController.dart';
import 'package:health_se/Entity/UserProfile.dart';

class LoginController {
  static Future<bool> validateLogin(String username, String password) async {
    final Map<String, String> login = {
      "username": username,
      "password": password,
    };

    final res = await UserProfileHandler().post('/login', login);

    if (res == -1)
      return false;
    else {
      UserInfoController.user = UserProfile.fromJson(jsonDecode(res));
      return true;
    }
  }
}
