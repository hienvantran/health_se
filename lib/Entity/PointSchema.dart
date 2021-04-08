class PointSchema {
  double longitude;
  double latitude;

  PointSchema({this.latitude, this.longitude});

  factory PointSchema.fromJson(Map<String, dynamic> json) {
    return PointSchema(
      longitude: json['longitude'] as double,
      latitude: json['latitude'] as double,
    );
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

class PointList {
  final List<PointSchema> pointList;

  PointList({
    this.pointList,
  });

  factory PointList.fromJson(List<dynamic> parsedJson) {
    List<PointSchema> maps111 = new List<PointSchema>();
    maps111 = parsedJson.map((i) => PointSchema.fromJson(i)).toList();
    return new PointList(pointList: maps111);
  }
}
