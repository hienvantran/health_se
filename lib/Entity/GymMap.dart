import 'GymPoints.dart';

class GymMap {
  final List<GymPoints> pointList;
  GymMap({this.pointList});

  factory GymMap.fromJson(List<dynamic> parsedJson) {
    List<GymPoints> points = <GymPoints>[];
    points = parsedJson.map((i) => GymPoints.fromJson(i)).toList();
    return new GymMap(
      pointList: points,
    );
  }
}
