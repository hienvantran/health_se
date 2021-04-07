import "package:health_se/Entity/Clusters.dart";
import 'package:health_se/Entity/PointSchema.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

class InfectiousMapController {
  //get the midpoint of the clusters
  static PointSchema getClusterMidPoint(Clusters cluster) {
    double sumLat = 0;
    double sumLong = 0;
    List<LatLng> path = new List<LatLng>();

    int numberOfPoints = cluster.boundaryPoints.pointList.length;
    print(cluster.boundaryPoints.pointList[1].latitude);
    print(cluster.boundaryPoints.pointList.length);
    for (int i = 0; i < cluster.boundaryPoints.pointList.length; i++) {
      double temp1 = cluster.boundaryPoints.pointList[i].latitude;
      double temp2 = cluster.boundaryPoints.pointList[i].longitude;
      sumLat += temp1;
      sumLong += temp2;
    }
    PointSchema temp = PointSchema();
    temp.setLongitude(sumLong / numberOfPoints);
    temp.setLatitude(sumLat / numberOfPoints);

    return temp;
  }

  void getInput() {}

  //LoadFilteredMap()
  void loadFilteredMap() {
    getInput();
    //getFilteredCases(disease, date, locationbyinput) //since we have fixed distance, and user location
    //get today's map
    //getClusterMidPoint();
    //filter(distance,midpoints, location)
    //ends
  }
  //
}
