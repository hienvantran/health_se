import 'dart:async';
import 'package:flutter/material.dart';
import 'package:health_se/UI/loginUI.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginUI())));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        body: SizedBox.expand(
          child: Container(
              color: Color(0xFF479055),
              child: Image(
                image: AssetImage('images/logo.png'),
                height: 100.0,
                width: 100.0,
              )),
        ),
      ),
    );
  }
}
