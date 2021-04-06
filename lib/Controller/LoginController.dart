import 'dart:async';
import 'dart:convert';
import 'package:health_se/Controller/UserProfileHandler.dart';
import 'package:logger/logger.dart';
import 'package:health_se/Controller/UserProfileController.dart';
import 'package:http/http.dart' as http;
import 'NetworkController.dart';
import '../Entity/UserProfile.dart';

class LoginController {
  static Future<dynamic> loginPost(Map<String, String> newData) async {
    var responseUrl =
        Uri.https('myhealth001.herokuapp.com', '/login', {'q': '{http}'});
    var response = await http.post(responseUrl, body: newData);
    return response;
  }

  static Future<bool> validateLogin(String username, String password) async {
    final Map<String, String> login = {
      "username": username,
      "password": password,
    };
    print(username);
    print(password);
    var res = await loginPost(login);
    print(res.statusCode);
    if (res.statusCode == 403)
      return false;
    else {
      //UserProfileController.user =UserProfileHandler().parseOneObject(res.body);
      final parsed = jsonDecode(res.body);
      UserProfileController.user = UserProfile.fromJson(parsed);
      print(res.body);
      return true;
    }
  }
}
