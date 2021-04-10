import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:health_se/Controller/FilterController.dart';
import 'package:health_se/Controller/MapHandler.dart';
import 'package:health_se/Entity/InfectiousDiseaseMap.dart';
import 'package:health_se/Entity/PointSchema.dart';
import 'package:health_se/Controller/FilterController.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: test(),
    );
  }
}

class test extends StatefulWidget {
  testState createState() => testState();
}

class testState extends State<test> {
  Completer<GoogleMapController> _controller = Completer();

// 2
  static final CameraPosition _myLocation = CameraPosition(
    target: LatLng(1.32941051118544, 103.887581360714),
  );
  List<Marker> markers = <Marker>[];
  static const String _API_KEY = 'AIzaSyALEYGT-cFANGs-8BnYcqarG1KGt_x8e04';

  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _myLocation,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          searchNearby(0, 0); // 2
        },
        label: Text('Places Nearby'), // 3
        icon: Icon(Icons.place), // 4
      ),
    );
  }

  void searchNearby(double latitude, double longitude) async {
    List<double> longs = [];
    List<double> lats = [];
    MapHandler mh = MapHandler();
    PointSchema loc = new PointSchema();
    loc.setLongitude(longitude);
    loc.setLatitude(latitude);

    // InfectiousDiseaseMap mapNeeded = await mh
    //     .getObject('/infectiousDisease/Dengue/map/2021-04-03T13:24:53.410Z');
    // print('it reaches here');
    // print(mapNeeded.diseaseName);
    //
    InfectiousDiseaseMap mapNeeded =
        await FilterController.getFilteredCases("dengue", loc, "test");

    //retrieves longitude and latitude

    //working code for showing all
    // for (int i = 0; i < mapNeeded.cluster.clusterList.length; i++) {
    //   //loops through all the cluster list
    //   for (int j = 0;
    //       j < mapNeeded.cluster.clusterList[i].boundaryPoints.pointList.length;
    //       j++) {
    //     //loops through all boundary points in list
    //     longs.add(mapNeeded
    //         .cluster.clusterList[i].boundaryPoints.pointList[j].longitude);
    //     lats.add(mapNeeded
    //         .cluster.clusterList[i].boundaryPoints.pointList[j].latitude);
    //   }
    // }

    for (int i = 0; i < mapNeeded.cluster.clusterList.length; i++) {
      //only need display midpoint for each cluster
      if (mapNeeded.cluster.clusterList[i] == null) {
        print("does it come here? ");
        print("the value of i when it comes here is");
        continue;
      }
      lats.add(mapNeeded.cluster.clusterList[i].midPoint.getLatitude());
      longs.add(mapNeeded.cluster.clusterList[i].midPoint.getLongitude());
    }

    print(longs[0]);
    print(lats[0]);

    setState(() {
      markers.clear();
    });
    setState(() {
      //
      List<String> title = ["test1", "test2", "test3", "test4"];
      List<String> description = [
        "please close",
        "please close",
        "please close",
        "please close"
      ];
      // 3
      for (int i = 0; i < longs.length; i++) {
        // 4
        String markerId = "$i";
        markers.add(
          Marker(
            markerId: MarkerId(markerId),
            position: LatLng(lats[i], longs[i]),
            infoWindow: InfoWindow(title: "test"),
            onTap: () {
              //alertDialog(title[i], description[i]);
            },
          ),
        );
      }
    });
  }

  Future<void> alertDialog(String title, String description) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
