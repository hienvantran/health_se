import 'dart:convert';
import 'package:health_se/Controller/UserInfoController.dart';
import 'package:health_se/UI/HealthProfileUI.dart';

import 'NetworkController.dart';
import '../Entity/UserProfile.dart';
import 'UserProfileHandler.dart';

class UserProfileController {
  static Future<UserProfile> retrieveUser(String userID) async {
    UserProfile user =
        await UserProfileHandler().getObject('/userProfile/$userID');
    print("TESTING: ");
    print(user.getFoodRecordsList().length);
    return user;
  }

  static Future<void> updateUser(String userID) async {
    UserProfile user = await retrieveUser(userID);
    UserInfoController.user = user;
  }

  static String returnImagePath(String gender) {
    if (gender == 'female')
      return 'images/female-avatar.jpg';
    else
      return 'images/male-avatar.jpeg';
  }

  static Future<void> editProfile(Map<String, dynamic> editedInfo) async {
    String userID = UserInfoController.user.getUserID();
    String url = '/userProfile/$userID';
    final res = await UserProfileHandler().post(url, editedInfo);
    print(res);
    if (res == -1)
      return false;
    else {
      UserInfoController.user = UserProfile.fromJson(jsonDecode(res));
      return true;
    }
  }
}
