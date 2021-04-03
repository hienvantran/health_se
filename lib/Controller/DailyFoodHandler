import 'dart:convert';

import '../Entity/FoodChoices.dart';
import 'NetworkController.dart';

class FoodChoicesHandler extends NetworkController {
  @override
  List<FoodChoices> parseObjectFormat(String responseBody) {
    // TODO: implement parseObjectFormat
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<FoodChoices>((json) => FoodChoices.fromJson(json))
        .toList();
  }

  @override
  FoodChoices parseOneObject(String responseBody) {
    // TODO: implement parseOneObject
    final parsed = jsonDecode(responseBody);
    return FoodChoices.fromJson(parsed);
  }
}
