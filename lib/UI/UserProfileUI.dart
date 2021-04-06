import 'package:flutter/material.dart';
import 'package:health_se/Controller/UserProfileController.dart';
import 'LoginUI.dart';

const PrimaryColor = const Color(0xFF4CAF50);

String gender = 'M';
String name = 'Sanath';
double weight = 85, height = 185, waist = 36;
int age = 19;

class UserProfileUI extends StatelessWidget {
  //final nameHolder;
  String imgPath = UserProfileController.returnImagePath(gender);

  //UserProfileUI({Key key, @required this.nameHolder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void goBack(BuildContext context) {
      Navigator.pop(context);
    }

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(children: <Widget>[
        Container(
          margin: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          height: size.height / 8,
          width: size.width * 0.97,
          child: Row(
            children: <Widget>[
              Image(
                image: AssetImage(imgPath),
                height: size.height * 0.1,
                width: size.width * 0.2,
              ),
              SizedBox(width: size.width * 0.1),
              Text(name,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
            ],
          ),
        ),
        SizedBox(height: 50.0),
        Container(
            margin: const EdgeInsets.all(6.0),
            height: MediaQuery.of(context).size.height / 2,
            child: Column(children: <Widget>[
              Text('INFORMATION'),
              SizedBox(height: 10.0),
              Text('Name:  ${name}'),
              SizedBox(height: 10.0),
              Text('Age: ${age}'),
              SizedBox(height: 10.0),
              Text('Gender: ${gender}'),
              SizedBox(height: 10.0),
              Text('Weight: ${weight} kg'),
              SizedBox(height: 10.0),
              Text('Height: ${height} cm'),
              SizedBox(height: 10.0),
              Text('Waist Measurement: ${waist} cm'),
              // ignore: deprecated_member_use
              RaisedButton(
                  onPressed: () => goBack(context),
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  child: Text('Go Back To Previous Screen')),
            ])),
      ]),
    )));
  }
}
