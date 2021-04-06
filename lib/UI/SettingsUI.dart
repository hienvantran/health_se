import 'package:flutter/material.dart';

void main() => runApp(SettingsUI());

class SettingsUI extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              centerTitle: true,
              title: const Text(
                'SETTINGS',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // do something
                  },
                )
              ],
            ),
            body: SafeArea(
                child: new Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Notification Management',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
              ),
              Container(
                color: Colors.white60,
              )
            ]))));
  }
}
