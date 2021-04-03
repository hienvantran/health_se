import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(RiskInfoUI());

class RiskInfoUI extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(
            title: const Text('Risk Information'),
            centerTitle: true,
            backgroundColor: Colors.green,
          ),
        ),
        body: Container(
          child: Text("RiskInfoUI"),
        ),
      ),
    );
  }
}
