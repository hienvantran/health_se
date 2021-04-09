import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_se/Entity/PointSchema.dart';

import 'InfectiousUI.dart';

class InputLocationUI extends StatefulWidget {
  @override
  _InputLocationState createState() => _InputLocationState();
}

class _InputLocationState extends State<InputLocationUI> {
  double lat;
  double longi;
  var latitude = TextEditingController();
  var longitude = TextEditingController();

  void onSubmit() async {
    setState(() {
      longi = double.parse(longitude.text);
      lat = double.parse(latitude.text);
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                InfectiousUI(userLongitude: longi, userLatitude: lat)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: latitude,
                autocorrect: true,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your latitude',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white),
                    borderRadius: new BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white),
                    borderRadius: new BorderRadius.circular(25.7),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: longitude,
                autocorrect: true,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your longitude',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white),
                    borderRadius: new BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white),
                    borderRadius: new BorderRadius.circular(25.7),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed: (onSubmit),
              color: Colors.green,
              textColor: Colors.white,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                'Get Risk Report',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
