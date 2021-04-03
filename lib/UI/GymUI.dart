import 'package:flutter/material.dart';

class ExpansionGymMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Gyme Map'),
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
