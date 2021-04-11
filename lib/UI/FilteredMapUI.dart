import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:health_se/Controller/FilterController.dart';
import 'package:health_se/Entity/InfectiousDiseaseMap.dart';
import 'package:health_se/Entity/PointSchema.dart';
import 'package:health_se/UI/mainUI.dart';
import 'package:health_se/UI/FilterUI.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(FilteredMapUI());

class FilteredMapUI extends StatefulWidget {
  final Data data;
  FilteredMapUI({this.data});

  @override
  _FilteredMapUIState createState() => _FilteredMapUIState();
}

class _FilteredMapUIState extends State<FilteredMapUI> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _myLocation = CameraPosition(
    target: LatLng(1.32941051118544, 103.887581360714),
    zoom: 8.5,
  );
  List<Marker> markers = <Marker>[];
  Position _location = new Position(latitude: 0, longitude: 0);

  @override
  void initState() {
    super.initState();
    var x = widget.data.distance;
    PointSchema temp = new PointSchema();
    temp.setLongitude(double.parse(widget.data.longitude));
    temp.setLatitude(double.parse(widget.data.latitude));
    searchFiltered(x * 1000, widget.data.dateTime, widget.data.disease, temp);
  }

  getLocation() async {
    final location = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _location = location;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF479055),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 200, bottom: 575),
        child: FloatingActionButton.extended(
          onPressed: () async {
            await getLocation();
            var x = widget.data.distance;
            PointSchema temp = new PointSchema();
            temp.setLongitude(_location.longitude);
            temp.setLatitude(_location.latitude);
            searchFiltered(
                x * 1000, widget.data.dateTime, widget.data.disease, temp);
          },
          backgroundColor: Color(0xFF479055),
          label: Text('Places Nearby'), // 3
          icon: Icon(Icons.place), // 4
        ),
      ),
    );
  }

  void searchFiltered(double dist, String date, String diseaseName,
      PointSchema location) async {
    List<double> longs = [];
    List<double> lats = [];
    List<int> numberOfCases = [];
    int distance = dist.toInt();
    InfectiousDiseaseMap mapNeeded = await FilterController.getFilteredCases(
        diseaseName, location, date, distance);
    for (int i = 0; i < mapNeeded.cluster.clusterList.length; i++) {
      if (mapNeeded.cluster.clusterList[i] == null) {
        continue;
      }
      lats.add(mapNeeded.cluster.clusterList[i].midPoint.getLatitude());
      longs.add(mapNeeded.cluster.clusterList[i].midPoint.getLongitude());
      numberOfCases.add(mapNeeded.cluster.clusterList[i].numberOfCases);
    }

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
            infoWindow: InfoWindow(title: "Dengue Cluster"),
            onTap: () {
              alertDialog(
                  "The number of Dengue Cases", numberOfCases[i].toString());
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
        });
  }
}
