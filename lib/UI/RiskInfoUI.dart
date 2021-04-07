import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:health_se/UI/FilterUI.dart';

void main() => runApp(RiskInfoUI());

class RiskInfoUI extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Risk information"),
          leading: FlatButton.icon(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FilterUI()));
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: 20,
            ),
            label: Text(""),
            textColor: Colors.white,
          ),
          // Icon(
          //   Icons.arrow_back_ios_rounded,
          // ),
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
        body: Container(
          child: test(),
        ),
      ),
    );
  }
}

class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  Position _location = Position(latitude: 0.0, longitude: 0.0);

  void _displayCurrentLocation() async {
    final location = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _location = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${_location.latitude}, ${_location.longitude}"),
            FlatButton(
              child: Text("Find Current Location",
                  style: TextStyle(color: Colors.white)),
              color: Colors.green,
              onPressed: () {
                _displayCurrentLocation();
              },
            )
          ]),
    ));
  }
}
