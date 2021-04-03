import 'package:flutter/material.dart';
import 'UserProfileUI.dart';

void main() => runApp(LoginUI());

class LoginUI extends StatefulWidget {
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final username = TextEditingController();
  bool _validate = false;

  getItemAndNavigate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserProfileUI(
                  nameHolder: username.text,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
      builder: (context) => Scaffold(
          backgroundColor: Colors.lightGreenAccent,
          body: SingleChildScrollView(
            reverse: true,
            child: Center(
              child: new Column(
                children: <Widget>[
                  SizedBox(height: 120.0),
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/logo.png'),
                        height: 150.0,
                        width: 150.0,
                      ),
                      SizedBox(height: 30.0),
                      Text('HealthSE',
                          style: TextStyle(
                              fontFamily: 'FjallaOne',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: username,
                          autocorrect: true,
                          decoration: new InputDecoration(
                            errorText:
                                _validate ? 'Value Can\'t Be Empty' : null,
                            border: InputBorder.none,
                            hintText: 'Enter your username',
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
                      ),
                      SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              hintText: 'Enter your password',
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
                            )),
                      ),
                      SizedBox(height: 30.0),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            username.text.isEmpty
                                ? _validate = true
                                : _validate = false;
                            if (_validate == false) getItemAndNavigate(context);
                          });
                        },
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text('Login'),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          )),
    ));
  }
}
