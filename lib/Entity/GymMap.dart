

import 'GymPoints.dart';

class GymMap {
  final GymPoints pointList;
  GymMap({this.pointList});

  factory GymMap.fromJson(Map <String,dynamic> json) {
    GymPoints pList = GymPoints.fromJson(json);
    return GymMap(
      pointList: pList,
    );
  }
}
