import 'package:health_se/Entity/PointSchema.dart';

class Clusters {
  final int numberOfCases;
  final PointList boundaryPoints;
  PointSchema midPoint;

  Clusters({this.numberOfCases, this.boundaryPoints});

  factory Clusters.fromJson(Map<String, dynamic> json) {
    PointList pList = PointList.fromJson(json['boundaryPoint']);

    return Clusters(
      numberOfCases: json['numberOfCases'] as int,
      boundaryPoints: pList,
    );
  }

  void setMidPoint(PointSchema midPoint) {
    this.midPoint = midPoint;
  }
}

class ClustersMapList {
  final List<Clusters> clusterList;

  ClustersMapList({
    this.clusterList,
  });

  factory ClustersMapList.fromJson(List<dynamic> parsedJson) {
    List<Clusters> maps111 = <Clusters>[];
    maps111 = parsedJson.map((i) => Clusters.fromJson(i)).toList();
    return new ClustersMapList(clusterList: maps111);
  }
}
