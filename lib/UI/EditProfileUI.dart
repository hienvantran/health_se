import 'package:flutter/material.dart';
import 'package:health_se/Controller/UserProfileController.dart';
import 'package:health_se/UI/UserProfileUI.dart';
import 'LoginUI.dart';

const PrimaryColor = const Color(0xFF41AA46);
void main() => runApp(EditProfileUI());

class EditProfileUI extends StatefulWidget {
  @override
  _EditProfileUIState createState() => _EditProfileUIState();
}

class _EditProfileUIState extends State<EditProfileUI> {
  bool _validatename = false;

  bool _validateage = false;

  bool _validategender = false;

  bool _validateweight = false;

  bool _validateheight = false;

  bool _validatewaist = false;
  final name = TextEditingController();
  final age = TextEditingController();
  final weight = TextEditingController();
  final height = TextEditingController();
  final waist = TextEditingController();
  final gender = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        home: Builder(
      builder: (context) => Scaffold(
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
                    SizedBox(width: size.width * 0.1),
                    Text('Sanath',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0)),
                  ],
                ),
              ),
              SizedBox(height: 50.0),
              Container(
                  margin: const EdgeInsets.all(6.0),
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(children: <Widget>[
                    Text('Edit Information'),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: name,
                      autocorrect: true,
                      decoration: new InputDecoration(
                        errorText:
                            _validatename ? 'Value Can\'t Be Empty' : null,
                        border: InputBorder.none,
                        hintText: 'Edit your name',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
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
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: age,
                      autocorrect: true,
                      decoration: new InputDecoration(
                        errorText:
                            _validateage ? 'Value Can\'t Be Empty' : null,
                        border: InputBorder.none,
                        hintText: 'Edit your age',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
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
                    TextFormField(
                      controller: gender,
                      autocorrect: true,
                      decoration: new InputDecoration(
                        errorText:
                            _validategender ? 'Value Can\'t Be Empty' : null,
                        border: InputBorder.none,
                        hintText: 'Edit your gender',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
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
                    TextFormField(
                      controller: weight,
                      autocorrect: true,
                      decoration: new InputDecoration(
                        errorText:
                            _validateweight ? 'Value Can\'t Be Empty' : null,
                        border: InputBorder.none,
                        hintText: 'Edit your weight',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
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
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: height,
                      autocorrect: true,
                      decoration: new InputDecoration(
                        errorText:
                            _validateheight ? 'Value Can\'t Be Empty' : null,
                        border: InputBorder.none,
                        hintText: 'Edit your height',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
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
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: waist,
                      autocorrect: true,
                      decoration: new InputDecoration(
                        errorText:
                            _validatewaist ? 'Value Can\'t Be Empty' : null,
                        border: InputBorder.none,
                        hintText: 'Edit your waist circumference',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
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
                    RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfileUI()),
                          );
                        },
                        color: Colors.lightBlue,
                        textColor: Colors.white,
                        child: Text('Go Back To Previous Screen')),
                  ])),
            ]),
          ),
        ),
      ),
    ));
  }
}
