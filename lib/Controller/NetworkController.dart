import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class NetworkController {
  final String baseUrl = 'myhealth001.herokuapp.com';
  var log = Logger();

  Future<dynamic> get(String url) async {
    var responseUrl = Uri.https(baseUrl, url, {'q': '{http}'});
    var response = await http.get(responseUrl);
    log.i(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return -1;
    }
  }

  Future<dynamic> put(String url, Map<String, String> newData) async {
    var responseUrl = Uri.https(baseUrl, url, {'q': '{http}'});
    var response = await http.put(responseUrl, body: newData);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return -1;
    }
  }

  Future<dynamic> post(String url, Map<String, String> newData) async {
    var responseUrl = Uri.https(baseUrl, url, {'q': '{http}'});
    var response = await http.post(responseUrl, body: newData);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.statusCode;
    }
  }

  //use this if you want to update changes for a given route
  void updateChanges(String route, Map<String, String> updates) {
    put(route, updates);
  }

  //use this if you want to add a new object
  void addChanges(String route, Map<String, String> updates) {
    post(route, updates);
  }

  //the get method is implemented in each class.
  /*
  Future<dynamic> getListOfObjects(String route) {
    return get(route).then((responseBody) => parseObjectFormat(responseBody));
  }*/

  Future<List<dynamic>> getListOfObjects(String route) {
    return get(route).then((responseBody) => parseObjectFormat(responseBody));
  }

  Future<dynamic> getObject(String route) {
    return get(route).then((responseBody) => parseOneObject(responseBody));
  }

  //Future<dynamic> getSpecificObject(String route);

  //implemented in each of the actually object handler
  //abstract method
  List<dynamic> parseObjectFormat(String responseBody);
  dynamic parseOneObject(String responseBody);
}
