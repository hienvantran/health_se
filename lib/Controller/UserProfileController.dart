import 'dart:convert';
import 'NetworkController.dart';
import '../Entity/UserProfile.dart';
import 'UserProfileHandler.dart';

class UserProfileController {
  static UserProfile user;

  static Future<UserProfile> retrieveUser(String userID) {
    Future<UserProfile> user =
        UserProfileHandler().getObject('/userProfile/$userID');

    print(user);
    return user;
  }

  static String returnImagePath(String gender) {
    if (gender == 'F')
      return 'images/female-avatar.jpg';
    else
      return 'images/male-avatar.jpeg';
  }
}
