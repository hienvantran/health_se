import 'dart:convert';
import 'NetworkController.dart';
import '../Entity/UserProfile.dart';

class UserProfileHandler extends NetworkController {
  @override
  List<UserProfile> parseObjectFormat(String responseBody) {
    // TODO: implement parseObjectFormat
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<UserProfile>((json) => UserProfile.fromJson(json))
        .toList();
  }

  UserProfile parseOneObject(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return UserProfile.fromJson(parsed);
    //return parsed.map<UserProfile>((json) => UserProfile.fromJson(json));
  }
}
