class GymPoints {
  double longitude;
  double latitude;
  String name;
  String operatingHour;

  GymPoints({this.latitude, this.longitude, this.name, this.operatingHour});

  factory GymPoints.fromJson(Map<String, dynamic> json) {
    return GymPoints(
      longitude: json['longitude'] as double,
      latitude: json['latitude'] as double,
      name: json['name'] as String,
      operatingHour: json['operatingHour'] as String,
    );
  }

  String getName() {
    return name;
  }

  String getOperatingHour() {
    return operatingHour;
  }

  void setLongitude(double longitude) {
    this.longitude = longitude;
  }

  void setLatitude(double latitude) {
    this.latitude = latitude;
  }

  double getLongitude() {
    return longitude;
  }

  double getLatitude() {
    return latitude;
  }
}
