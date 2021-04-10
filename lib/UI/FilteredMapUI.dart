import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:health_se/Controller/FilterController.dart';
import 'package:health_se/Controller/MapHandler.dart';
import 'package:health_se/Entity/InfectiousDiseaseMap.dart';
import 'package:health_se/Entity/PointSchema.dart';
import 'package:health_se/UI/mainUI.dart';

import 'FilterUI.dart';

void main() => runApp(FilteredMapUI());

class FilteredMapUI extends StatefulWidget {
  final Data data;

  FilteredMapUI({this.data});

  @override
  _FilteredMapUIState createState() => _FilteredMapUIState();
}

class _FilteredMapUIState extends State<FilteredMapUI> {
  @override
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    //
    // print(x);
    // print(widget.data.dateTime);
    // print(widget.data.disease);
    // print(temp);
  }

  static final CameraPosition _myLocation = CameraPosition(
    target: LatLng(1.32941051118544, 103.887581360714),
    zoom: 7,
  );
  List<Marker> markers = <Marker>[];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filtered map"),
        leading: FlatButton.icon(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyApp(tab: 2)));
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
          ),
          label: Text(""),
          textColor: Colors.white,
        ),
        centerTitle: true,
      ),
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
          var x = widget.data.distance;
          PointSchema temp = new PointSchema();

          print("WRONG WRONG WRONG");
          temp.setLongitude(double.parse(widget.data.longitude));
          print("RIGHT RIGHT RIGHT");
          temp.setLatitude(double.parse(widget.data.latitude));
          searchFiltered(
              x * 1000, widget.data.dateTime, widget.data.disease, temp);
          print(temp.getLongitude());
          print(temp.getLatitude());

          // searchNearby(0, 0); // 2
          // var x = int.parse(widget.data.distance);
          // searchFiltered(x, widget.data.dateTime, widget.data.disease);
        },
        label: Text('Places Nearby'), // 3
        icon: Icon(Icons.place), // 4
      ),
    );
  }

  void searchFiltered(double dist, String date, String diseaseName,
      PointSchema location) async {
    List<double> longs = [];
    List<double> lats = [];
    int distance = dist.toInt();
    print("wrong wrong wrong :D");
    InfectiousDiseaseMap mapNeeded = await FilterController.getFilteredCases(
        diseaseName, location, date, distance);
    print(mapNeeded.numberOfClusters);
    print("if it comes here it's correct");
    for (int i = 0; i < mapNeeded.cluster.clusterList.length; i++) {
      //only need display midpoint for each cluster
      if (mapNeeded.cluster.clusterList[i] == null) {
        print(
            "The cluster is too far away, so it has been set to default null");
        continue;
      }
      lats.add(mapNeeded.cluster.clusterList[i].midPoint.getLatitude());
      longs.add(mapNeeded.cluster.clusterList[i].midPoint.getLongitude());
    }
    print("REACHES HERE");

    setState(() {
      markers.clear();
    });
    setState(() {
      for (int i = 0; i < longs.length; i++) {
        // 4
        String markerId = "$i";
        markers.add(
          Marker(
            markerId: MarkerId(markerId),
            position: LatLng(lats[i], longs[i]),
            infoWindow: InfoWindow(title: "test"),
            onTap: () {
              // alertDialog(title[i], description[i]);
            },
          ),
        );
      }
      print("DOESNT REACH HERE");
    });
  }
}
