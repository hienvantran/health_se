import 'package:health_se/Entity/Clusters.dart';

class InfectiousDiseaseMap {
  final ClustersMapList cluster;
  final String diseaseName;
  final String date;
  final int numberOfClusters;

  InfectiousDiseaseMap(
      {this.cluster, this.diseaseName, this.date, this.numberOfClusters});

  factory InfectiousDiseaseMap.fromJson(Map<String, dynamic> json) {
    ClustersMapList mList = ClustersMapList.fromJson(json['cluster']);
    return InfectiousDiseaseMap(
      diseaseName: json['diseaseName'] as String,
      cluster: mList,
      date: json['date'] as String,
      numberOfClusters: json['numberOfClusters'] as int,
    );
  }
}

class InfectiousDiseaseMapList {
  final List<InfectiousDiseaseMap> mapList;

  InfectiousDiseaseMapList({
    this.mapList,
  });

  factory InfectiousDiseaseMapList.fromJson(List<dynamic> parsedJson) {
    List<InfectiousDiseaseMap> maps111 = new List<InfectiousDiseaseMap>();
    maps111 = parsedJson.map((i) => InfectiousDiseaseMap.fromJson(i)).toList();
    return new InfectiousDiseaseMapList(mapList: maps111);
  }
}
