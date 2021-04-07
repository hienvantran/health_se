import 'dart:convert';
import 'NetworkController.dart';
import '../Entity/UserProfile.dart';
import 'package:http/http.dart' as http;

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

  Future<dynamic> deleteAllFoodRecords(String userid) async {
    String url = '/userprofile/' + userid + '/foodRecords';
    var responseUrl = Uri.https(baseUrl, url, {'q': '{http}'});
    var response = await http.delete(responseUrl);
    log.i(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return -1;
    }
  }
}
