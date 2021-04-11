import 'package:health_se/Controller/InfectiousDiseaseHandler.dart';
import 'package:health_se/Entity/InfectiousDisease.dart';
import 'package:health_se/Entity/InfectiousDiseaseMap.dart';
import 'package:health_se/Entity/PointSchema.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:health_se/Controller/FilterController.dart';
import 'package:health_se/Controller/MapHandler.dart';

class RiskController {
  //uses getAllRisk to display all the available risk in the database
  Future<List<InfectiousDisease>> getAllRisk(
      double userLatitude, double userLongitude) async {
    PointSchema userLocation = PointSchema();
    userLocation.setLatitude(userLatitude);
    userLocation.setLongitude(userLongitude);
    List<InfectiousDisease> allList =
        await InfectiousDiseaseHandler().getListOfObjects("/infectiousDisease");
    for (int i = 0; i < allList.length; i++) {
      riskLevel(allList[i].diseaseName, userLocation);
    }
    return allList;
  }

  //pass in the distance of each clusters and then find
  Future<InfectiousDisease> riskLevel(
      String disease, PointSchema userLocation) async {
    //date is today's date
    var now = DateTime.now().toIso8601String();

    int casesNearby = await numberOfCases(disease, userLocation, now);
    //since the map shows the nearby cases for the past 14 days, just need to concern with distance
    InfectiousDisease id = await getDiseaseInfo(disease);
    print(casesNearby);
    print("debugging");
    if (casesNearby > 5) {
      //high risk
      id.setRisk("High risk");
    } else if (1 <= casesNearby && casesNearby <= 5) {
      //low risk
      id.setRisk("Medium risk");
    } else {
      //cases == 0
      id.setRisk("Low risk");
    }

    return id;
  }

  Future<InfectiousDisease> getDiseaseInfo(String diseaseName) async {
    InfectiousDisease infectiousDisease = await InfectiousDiseaseHandler()
        .getObject("/infectiousDisease/" + diseaseName);
    return infectiousDisease;
  }

  //calculate the number of cases in each cluster that is within 5 km of user
  Future<int> numberOfCases(
      String disease, PointSchema userLocation, String date) async {
    int nearbyCases = 0;
    final int distance = 5000;
    InfectiousDiseaseMap mapNeeded = await MapHandler()
        .getObject('/infectiousDisease/' + disease + '/map/' + date);

    for (int i = 0; i < mapNeeded.numberOfClusters; i++) {
      PointSchema temp =
          FilterController.getClusterMidPoint(mapNeeded.cluster.clusterList[i]);
      //Now I have the midpoints of a cluster, I will calculate distance
      var calculatedDistance = SphericalUtil.computeDistanceBetween(
          LatLng(temp.latitude, temp.longitude),
          LatLng(userLocation.getLatitude(),
              userLocation.getLongitude())); //users location
      //if midpoint of cluster less than 5 km away, add the number of cases in that cluster
      if (calculatedDistance < distance) {
        nearbyCases += mapNeeded.cluster.clusterList[i].numberOfCases;
      }
    }
    return nearbyCases;
  }
}
