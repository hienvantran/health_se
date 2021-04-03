import 'dart:async';
import 'package:flutter/material.dart';
import 'package:health_se/UI/ChangePasswordUI.dart';
import 'package:health_se/UI/UserProfileUI.dart';
import 'UI/CreateProfileUI.dart';
import 'UI/loginUI.dart';

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
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => CreateProfileUI())));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        body: SizedBox.expand(
          child: Container(
              color: Color(0xFF2B6B54),
              child: Image(
                image: AssetImage('images/logo_size_invert.jpg'),
                height: 100.0,
                width: 100.0,
              )),
        ),
      ),
    );
  }
}
