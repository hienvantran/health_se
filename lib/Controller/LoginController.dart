import 'dart:async';
import 'dart:convert';
import 'package:health_se/Controller/UserProfileHandler.dart';
import 'package:health_se/Controller/UserProfileController.dart';
import 'package:health_se/Controller/UserInfoController.dart';
import 'package:http/http.dart' as http;
import 'NetworkController.dart';
import '../Entity/UserProfile.dart';

class LoginController {
  // static Future<dynamic> loginPost(Map<String, String> newData) async {
  //   var responseUrl =
  //       Uri.https('myhealth001.herokuapp.com', '/login', {'q': '{http}'});
  //   var response = await http.post(responseUrl, body: newData);
  //   return response;
  // }

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
