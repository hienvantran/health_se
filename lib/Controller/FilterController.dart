import 'package:health_se/Controller/InfectiousMapController.dart';
import 'package:health_se/Controller/MapHandler.dart';
import 'package:health_se/Entity/Clusters.dart';
import "package:health_se/Entity/InfectiousDiseaseMap.dart";
import 'package:health_se/Entity/PointSchema.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

class FilterController {
  static Future<dynamic> getFilteredCases(
      String disease, PointSchema location, String date,
      [int distance = 5000]) async {
    List<PointSchema> midPoints = new List<PointSchema>();
    MapHandler mh = MapHandler();
    InfectiousDiseaseMap mapNeeded =
        await mh //equivalent of calling diseases, and date.
            .getObject('/infectiousDisease/' + disease + '/map/' + date);
    for (int i = 0; i < mapNeeded.numberOfClusters; i++) {
      //for each cluster, i will feed this set of cluster in to clusterMidPoints to calculate midPoints
      midPoints.add(getClusterMidPoint(mapNeeded.cluster.clusterList[i]));
    }
    //call itself filter(int distance midpoints location)
    return filter(mapNeeded, midPoints, location, distance);
  }

  static PointSchema getClusterMidPoint(Clusters cluster) {
    double sumLat = 0;
    double sumLong = 0;

    int numberOfPoints = cluster.boundaryPoints.pointList.length;
    print(cluster.boundaryPoints.pointList[1].latitude);
    print(cluster.boundaryPoints.pointList.length);
    for (int i = 0; i < cluster.boundaryPoints.pointList.length; i++) {
      double temp1 = cluster.boundaryPoints.pointList[i].getLatitude();
      double temp2 = cluster.boundaryPoints.pointList[i].getLongitude();
      sumLat += temp1;
      sumLong += temp2;
    }
    PointSchema temp = PointSchema();
    temp.setLongitude(sumLong / numberOfPoints);
    temp.setLatitude(sumLat / numberOfPoints);

    return temp;
  }

  //filter will return points that are filtered by user
  static InfectiousDiseaseMap filter(InfectiousDiseaseMap map1,
      List<PointSchema> midPoints, PointSchema location, int distance) {
    //InfectiousDiseaseMap map2 = new InfectiousDiseaseMap();
    //for each cluster, check midPoint and see if it fits criteria
    for (int i = 0; i < map1.numberOfClusters; i++) {
      //calculated distance is in meters
      map1.cluster.clusterList[i].setMidPoint(midPoints[i]);
      var calculatedDistance = SphericalUtil.computeDistanceBetween(
          LatLng(midPoints[i].getLatitude(), midPoints[i].getLongitude()),
          LatLng(1.32941051118544, 103.887581360714));
      print("The calculated distance is");
      print(calculatedDistance);
      if ((calculatedDistance) > distance) {
        //means that i will remove those that are more than filtered distance
        map1.cluster.clusterList[i] = null;
      }
    }
    return map1;
  }
}
