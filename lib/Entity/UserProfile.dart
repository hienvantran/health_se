class UserProfile {
  final int id;
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
      id: json['id'] as int,
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

  int getUserID() {
    return id;
  }

  String getUsername() {
    return name;
  }

  List<dynamic> getFoodRecordList() {
    return foodRecordList;
  }
}
