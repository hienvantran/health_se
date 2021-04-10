import 'package:flutter/material.dart';
import 'package:health_se/Controller/InfectiousMapController.dart';
import 'package:health_se/Controller/RiskController.dart';
import 'package:health_se/UI/InputLocationUI.dart';
import '../Controller/InfectiousDiseaseHandler.dart';
import 'GMap.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:health_se/Controller/FilterController.dart';
import 'package:health_se/Controller/UserInfoController.dart';
import 'package:health_se/Controller/MapHandler.dart';
import 'package:health_se/Entity/GymMap.dart';
import 'package:health_se/UI/FilterUI.dart';
import 'package:health_se/Controller/LocationController.dart';
import 'package:geolocator/geolocator.dart';
import 'package:health_se/Entity/PointSchema.dart';
import 'package:geocoder/geocoder.dart';
import 'package:health_se/UI/RiskInfoUI.dart';
import 'package:health_se/Entity/InfectiousDisease.dart';
import 'package:health_se/UI/mainUI.dart';
import 'package:health_se/Controller/GymMapController.dart';

class ExpansionGymMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Gym Map'),
      ),
      body: Container(
        child: Center(
          child: Text('Display Gym Map',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class map extends StatefulWidget {
  double userLongitude;
  double userLatitude;
  map({Key key, this.userLongitude, this.userLatitude}) : super(key: key);

  @override
  mapState createState() => mapState();
}

class mapState extends State<map> {
  Position _location = Position(latitude: 0.0, longitude: 0.0);
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = <Marker>[];
  static final CameraPosition _myLocation = CameraPosition(
    target: LatLng(1.32941051118544, 103.887581360714),
  );

  getLocation() async {
    final location = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _location = location;
    });
  }

  @override
  void initState() {
    super.initState();
    searchDefault();
  }

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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 270.0, left: 250.0),
        child: FloatingActionButton.extended(
          onPressed: () async {
            await getLocation();
            //searchFiltered(_location);
          },
          label: Text('Search Nearby'), // 3
          icon: Icon(Icons.place), // 4
        ),
      ),
    );
  }

  void searchDefault() async {
    PointSchema userLocation = PointSchema();
    // userLocation.setLongitude(loc.longitude);
    // userLocation.setLatitude(loc.latitude);
    // userLocation.setLongitude(widget.userLongitude);
    //  userLocation.setLatitude(widget.userLatitude);
    userLocation.setLongitude(103.68022);
    userLocation.setLatitude(1.34621);
    List<double> longs = [];
    List<double> lats = [];
    List<String> openingHours = [];
    List<String> names = [];
    // List<String> title = [];
    print(userLocation.getLatitude());
    print(userLocation.getLongitude());
    GymMap mapNeeded = await GymMapController.loadMap();

    for (int i = 0; i < mapNeeded.pointList.length; i++) {
      lats.add(mapNeeded.pointList[i].getLatitude());
      longs.add(mapNeeded.pointList[i].getLongitude());
      openingHours.add(mapNeeded.pointList[i].getOperatingHour());
      names.add(mapNeeded.pointList[i].getName());
    }

    setState(() {
      markers.clear();
    });
    setState(() {
      for (int i = 0; i <= longs.length; i++) {
        String markerId = "$i";
        if (i == longs.length) {
          markers.add(
            Marker(
              markerId: MarkerId(markerId),
              position: LatLng(
                  userLocation.getLatitude(), userLocation.getLongitude()),
              infoWindow: InfoWindow(title: "Users location"),
            ),
          );
        } else {
          String name = names[i];
          String openingHour = openingHours[i];
          markers.add(
            Marker(
              markerId: MarkerId(markerId),
              position: LatLng(lats[i], longs[i]),
              infoWindow: InfoWindow(title: "$name"),
              onTap: () {
                alertDialog("Opening hours: ", openingHour);
              },
            ),
          );
        }
      }
    });
  }

  // void searchFiltered(Position loc){
  //   PointSchema userLocation = PointSchema();
  //   // userLocation.setLongitude(loc.longitude);
  //   // userLocation.setLatitude(loc.latitude);
  //   // userLocation.setLongitude(widget.userLongitude);
  //   //  userLocation.setLatitude(widget.userLatitude);
  //   userLocation.setLongitude(103.68022);
  //   userLocation.setLatitude(1.34621);
  //   List<double> longs = [];
  //   List<double> lats = [];
  //   List<int> numberOfCases = [];
  //   // List<String> title = [];
  //   print(userLocation.getLatitude());
  //   print(userLocation.getLongitude());
  //   GymMap mapNeeded =
  //       await InfectiousMapController.loadFilteredMap(userLocation); // 2
  //   print("Why doesn't it come here?");
  //   for (int i = 0; i < mapNeeded.cluster.clusterList.length; i++) {
  //     //only need display midpoint for each cluster
  //     if (mapNeeded.cluster.clusterList[i] == null) {
  //       print("the value of i when it comes here is");
  //       continue;
  //     }
  //     lats.add(mapNeeded.cluster.clusterList[i].midPoint.getLatitude());
  //     longs.add(mapNeeded.cluster.clusterList[i].midPoint.getLongitude());
  //     numberOfCases.add(mapNeeded.cluster.clusterList[i].numberOfCases);
  //   }
  //
  //   setState(() {
  //     markers.clear();
  //   });
  //   setState(() {
  //     for (int i = 0; i < longs.length; i++) {
  //       String markerId = "$i";
  //       if (i == 0) {
  //         markers.add(
  //           Marker(
  //             markerId: MarkerId("50"),
  //             position: LatLng(
  //                 userLocation.getLatitude(), userLocation.getLongitude()),
  //             infoWindow: InfoWindow(title: "Users location"),
  //             onTap: () {
  //               alertDialog(
  //                   "The number of Dengue Cases", numberOfCases[i].toString());
  //             },
  //           ),
  //         );
  //       }
  //       markers.add(
  //         Marker(
  //           markerId: MarkerId(markerId),
  //           position: LatLng(lats[i], longs[i]),
  //           infoWindow: InfoWindow(title: "Dengue Cluster"),
  //           onTap: () {
  //             alertDialog(
  //                 "The number of Dengue Cases", numberOfCases[i].toString());
  //           },
  //         ),
  //       );
  //     }
  //   });
  // }

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
        });
  }
}
