import 'package:intl/intl.dart';

class UserProfile {
  final String id;
  final String name;
  final String age;
  final String gender;
  final num weight;
  final num height;
  final num waist;
  final String username;
  final String email;
  final List<dynamic> foodRecordList;

  UserProfile(
      {this.id,
      this.name,
      this.age,
      this.gender,
      this.weight,
      this.height,
      this.waist,
      this.foodRecordList,
      this.email,
      this.username});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['_id'] as String,
      name: json['name'] as String,
      age: json['age'] as String,
      gender: json['gender'] as String,
      weight: json['weight'] as num,
      height: json['height'] as num,
      waist: json['waist'] as num,
      foodRecordList: json['foodRecords'] as List<dynamic>,
      email: json['email'] as String,
      username: json['username'] as String,
    );
  }

  double getBmi() {
    //weight is in kg
    //height is in meters
    return (weight / (height / 100 * height / 100));
  }

  double getBodyFatPercentage() {
    int g = (gender == 'M') ? 0 : 1;
    double BMI = getBmi();
    double val = -44.988 +
        (0.503 * int.parse(age)) +
        (10.689 * g) +
        (3.172 * BMI) -
        (0.026 * BMI * BMI) +
        (0.181 * BMI * g) -
        (0.02 * BMI * int.parse(age)) -
        (0.005 * BMI * BMI * g) +
        (0.00021 * BMI * BMI * int.parse(age));
    return val;
  }

  int getMaintenanceCal() {
    int s;
    if (gender == 'male')
      s = 5;
    else
      s = -161;
    print((10 * weight + 6.25 * height - 5 * int.parse(age) + s).toInt());
    return (10 * weight + 6.25 * height - 5 * int.parse(age) + s).toInt();
  }

  String getUserID() {
    return id;
  }

  String getName() {
    return name;
  }

  String getAge() {
    return age;
  }

  String getGender() {
    return gender;
  }

  int getWeight() {
    return weight;
  }

  int getHeight() {
    return height;
  }

  int getWaist() {
    return waist;
  }

  String getUsername() {
    return username;
  }

  String getEmail() {
    return email;
  }

  List<dynamic> getFoodRecordsList() {
    return foodRecordList;
  }

  List<dynamic> getTodayRecords() {
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    List<dynamic> todayRecords = [];
    for (int i = 0; i < foodRecordList.length; i++) {
      if (foodRecordList[i]["createdAt"].substring(0, 10) == currentDate) {
        todayRecords.add(foodRecordList[i]);
      }
    }
    print("FILTERING\n");
    print(todayRecords.length);
    return todayRecords;
  }
}
