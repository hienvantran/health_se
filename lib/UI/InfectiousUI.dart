import 'dart:async';
import 'package:flutter/material.dart';
import 'package:health_se/Controller/InfectiousMapController.dart';
import 'package:health_se/Controller/RiskController.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:health_se/Controller/FilterController.dart';
import 'package:health_se/Controller/UserInfoController.dart';
import 'package:health_se/Entity/InfectiousDiseaseMap.dart';
import 'package:health_se/UI/FilterUI.dart';
import 'package:geolocator/geolocator.dart';
import 'package:health_se/Entity/PointSchema.dart';
import 'package:geocoder/geocoder.dart';
import 'package:health_se/Entity/InfectiousDisease.dart';
import 'package:health_se/UI/mainUI.dart';

class InfectiousUI extends StatefulWidget {
  double userLongitude;
  double userLatitude;
  InfectiousUI({Key key, this.userLongitude, this.userLatitude})
      : super(key: key);
  @override
  _InfectiousUIState createState() => _InfectiousUIState();
}

class _InfectiousUIState extends State<InfectiousUI> {
  final inputLocation = TextEditingController();
  Address location = Address();
  Position locationFromInput = new Position(latitude: 0, longitude: 0);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Infectious diseases"),
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
          actions: <Widget>[
            PopupMenuButton(
                itemBuilder: (BuildContext bc) => [
                      PopupMenuItem(
                          child: Text("Change password"), value: "/cp"),
                      PopupMenuItem(
                          child: Text("Notification management"),
                          value: "/notif"),
                      PopupMenuItem(child: Text("Log Out"), value: "/log-out"),
                    ],
                onSelected: (String route) {
                  if (route == "/cp") {}
                  if (route == "/notif") {}
                  if (route == "/log-out") {}
                  // Note You must create respective pages for navigation
                  Navigator.pushNamed(context, route);
                })
          ],
        ),
        body: SafeArea(
          child: Container(
            //height: 600,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      color: Colors.grey[200],
                      height: size.height * 0.05,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text("Filter cases"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FilterUI(
                                            latitude: widget.userLatitude,
                                            longitude: widget.userLongitude)));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF479055), // background
                                onPrimary: Colors.white, // foreground
                              ),
                              icon: Icon(
                                Icons.filter_alt_rounded,
                                size: 20,
                              ),
                              label: Text("Filter"),
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      color: Colors.grey[200],
                      height: size.height * 0.05,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text("Displaying Dengue cases on map"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      child: map(
                          userLongitude: widget.userLongitude,
                          userLatitude: widget.userLatitude),
                      height: size.height * 0.8,
                    ),
                  ),
                  Container(
                    child: riskReport(
                        userLongitude: widget.userLongitude,
                        userLatitude: widget.userLatitude),
                    height: 500.0,
                  ),
                ],
              ),
            ),
          ),
        ));
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
  List<InfectiousDisease> allDiseases = <InfectiousDisease>[];
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = <Marker>[];

  getLocation() async {
    final location = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _location = location;
    });
  }

  generateRiskReport() async {
    var dis = await RiskController()
        .getAllRisk(_location.latitude, _location.longitude);
    setState(() {
      allDiseases = dis;
      UserInfoController.infectiousDiseases = allDiseases;
    });
  }

  @override
  void initState() {
    super.initState();
    Position loc = new Position(
        longitude: widget.userLongitude, latitude: widget.userLatitude);
    searchDefault(loc);
  }

// 2
  static final CameraPosition _myLocation =
      CameraPosition(target: LatLng(1.34621, 103.68022), zoom: 8.5);

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
        padding: const EdgeInsets.only(bottom: 520.0, left: 80.0),
        child: FloatingActionButton.extended(
          onPressed: () async {
            await getLocation();
            searchDefault(_location);
          },
          backgroundColor: Color(0xFF479055),
          label: Text('Search Nearby'), // 3
          icon: Icon(Icons.place), // 4
        ),
      ),
    );
  }

  void searchDefault(Position loc) async {
    PointSchema userLocation = PointSchema();
    userLocation.setLongitude(loc.longitude);
    userLocation.setLatitude(loc.latitude);
    List<double> longs = [];
    List<double> lats = [];
    List<int> numberOfCases = [];
    print(userLocation.getLatitude());
    print(userLocation.getLongitude());
    InfectiousDiseaseMap mapNeeded =
        await InfectiousMapController.loadFilteredMap(userLocation);
    for (int i = 0; i < mapNeeded.cluster.clusterList.length; i++) {
      //only need display midpoint for each cluster
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
        String markerId = "$i";
        if (i == 0) {
          markers.add(
            Marker(
              markerId: MarkerId("50"),
              position: LatLng(
                  userLocation.getLatitude(), userLocation.getLongitude()),
              infoWindow: InfoWindow(title: "Users location"),
              onTap: () {
                alertDialog("User Location", "");
              },
            ),
          );
        }
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

class riskReport extends StatefulWidget {
  double userLongitude;
  double userLatitude;
  riskReport({Key key, this.userLongitude, this.userLatitude})
      : super(key: key);
  @override
  _riskReportState createState() => _riskReportState();
}

class _riskReportState extends State<riskReport> {
  @override
  void initState() {
    super.initState();
    initDiseases();
  }

  List<InfectiousDisease> infectiousDiseases = <InfectiousDisease>[];
  List<Color> colors = <Color>[Colors.green, Colors.green];
  List<String> sugs = <String>[];

  void initDiseases() async {
    RiskController rc = new RiskController();
    List<InfectiousDisease> x =
        await rc.getAllRisk(widget.userLatitude, widget.userLongitude);
    setState(() {
      infectiousDiseases = x;
      print(infectiousDiseases[0].suggestions.slist.length);
      for (int j = 0; j < 2; j++) {
        String suggestions = "\n";
        for (int i = 0;
            i < infectiousDiseases[j].suggestions.slist.length;
            i++) {
          String test = infectiousDiseases[j].suggestions.slist[i].suggestion;
          int k = i + 1;
          suggestions = suggestions + "\n$k." + test + '\n';
        }
        sugs.add(suggestions);
      }

      print(infectiousDiseases[0].getRisk());
      for (int i = 0; i < infectiousDiseases.length; i++) {
        if (infectiousDiseases[i].getDiseaseName() == "Zika")
          colors[i] = Colors.lightGreen;
        else
          colors[i] = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: infectiousDiseases.length,
        itemBuilder: (_, int position) {
          final item = infectiousDiseases[position];
          //get your item data here ...
          return Card(
            color: colors[position],
            child: ExpansionTile(
              title: Text("Disease Name: " + item.getDiseaseName()),
              initiallyExpanded: false,
              maintainState: false,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.ltr,
                    children: [
                      Text("\nSuggestions: " + sugs[position] + '\n'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
