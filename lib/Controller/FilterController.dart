import 'package:health_se/Controller/InfectiousMapController.dart';
import 'package:health_se/Controller/MapHandler.dart';
import "package:health_se/Entity/InfectiousDiseaseMap.dart";
import 'package:health_se/Entity/PointSchema.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

class FilterController {
  //2 overload , one with disease date
  //the other one with distance, diseases, date, userLocation

  static Future<dynamic> getFilteredCases(
      String diseases, location, String date,
      [int distance = 5]) async {
    List<PointSchema> midPoints = <PointSchema>[];
    MapHandler mh = MapHandler();
    //2021-04-03T13:24:53.410Z
    InfectiousDiseaseMap mapNeeded = await mh
        .getObject('/infectiousDisease/Dengue/map/2021-04-03T13:24:53.410Z');

    for (int i = 0; i < mapNeeded.numberOfClusters; i++) {
      //for each cluster, i will feed this set of cluster in to clusterMidPoints to calculate midPoints
      midPoints.add(InfectiousMapController.getClusterMidPoint(
          mapNeeded.cluster.clusterList[i]));
    }
    PointSchema dummy;
    //call itself filter(int distance midpoints location)
    return filter(mapNeeded, midPoints, dummy, 5000);
  }

  //filter will return points that are filtered by user
  static InfectiousDiseaseMap filter(InfectiousDiseaseMap map1,
      List<PointSchema> midPoints, PointSchema location, int distance) {
    print('hi');
    //InfectiousDiseaseMap map2 = new InfectiousDiseaseMap();
    //for each cluster, check midPoint and see if it fits criteria
    for (int i = 0; i < map1.numberOfClusters; i++) {
      //calculated distance is in meters
      map1.cluster.clusterList[i].setMidPoint(midPoints[i]);
      var calculatedDistance = SphericalUtil.computeDistanceBetween(
          LatLng(midPoints[i].latitude, midPoints[i].longitude),
          LatLng(1.32941051118544, 103.887581360714));
      print("The calculated distance is");
      print(calculatedDistance);
      if (calculatedDistance > distance) {
        //means that i will remove those that are more than filtered distance
        print('test');
        map1.cluster.clusterList[i] = null;
        print('test');
      }
    }
    // print(map2.cluster.clusterList[0].numberOfCases);
    print("hidumb");
    return map1;
  }
}
