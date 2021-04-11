import 'package:flutter/material.dart';
import 'package:health_se/UI/LoginUI.dart';
import 'package:health_se/UI/EditProfileUI.dart';
import 'package:health_se/Controller/RegistrationController.dart';

class CreateProfileUI extends StatefulWidget {
  @override
  _CreateProfileUIState createState() => _CreateProfileUIState();
}

class _CreateProfileUIState extends State<CreateProfileUI> {
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final reconpassword = TextEditingController();

  bool _validateusername = false;
  bool _validatepassword = false;
  bool _validaterecon = false;
  bool _validateemail = false;

  getItemAndNavigate(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditProfileUI()));
  }

  passMismatchAlertDialog(BuildContext context) {
    Widget okButton = RaisedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text(
          "Re-entered password does not match original. Please re-enter your credentials!"),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  errorAlertDialog(BuildContext context) {
    Widget okButton = RaisedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text(
          "Your account could not be created. Please try re-entering your credentials!"),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void onSubmit() async {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email.text);
    bool res = false;
    if (emailValid)
      res = await RegistrationController.createProfile(
          email.text, username.text, password.text);
    else
      errorAlertDialog(context);
    setState(
      () {
        username.text.isEmpty
            ? _validateusername = true
            : _validateusername = false;
        password.text.isEmpty
            ? _validatepassword = true
            : _validatepassword = false;
        reconpassword.text.isEmpty
            ? _validaterecon = true
            : _validaterecon = false;
        email.text.isEmpty ? _validateemail = true : _validateemail = false;
        if ((_validateusername == false) &&
            (_validatepassword == false) &&
            (_validaterecon == false) &&
            (_validateemail == false) &&
            (emailValid == true) &&
            (password.text == reconpassword.text)) {
          if (res == true) {
            getItemAndNavigate(context);
          }
        }
      },
    );
    if (password.text != reconpassword.text)
      passMismatchAlertDialog(context);
    else if (res != true && emailValid) errorAlertDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
      builder: (context) => Scaffold(
          backgroundColor: Color(0xFF479055),
          body: SingleChildScrollView(
            reverse: true,
            child: Center(
              child: new Column(
                children: <Widget>[
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 75.0),
                      Image(
                        image: AssetImage('images/logo.png'),
                        height: 150,
                        width: 150,
                      ),
                      SizedBox(height: 20.0),
                      Text('healthSEcure',
                          style: TextStyle(
                              fontFamily: 'FjallaOne',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 40.0),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: new TextFormField(
                          controller: username,
                          autocorrect: true,
                          decoration: new InputDecoration(
                            errorText: _validateusername
                                ? 'Value Can\'t Be Empty'
                                : null,
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
                      ListTile(
                        leading: const Icon(Icons.mail),
                        title: new TextFormField(
                          controller: email,
                          autocorrect: true,
                          decoration: new InputDecoration(
                            errorText:
                                _validateemail ? 'Value Can\'t Be Empty' : null,
                            border: InputBorder.none,
                            hintText: 'Enter your email ID',
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
                      ListTile(
                        leading: const Icon(Icons.lock_outline_sharp),
                        title: new TextFormField(
                          controller: password,
                          autocorrect: true,
                          obscureText: true,
                          decoration: new InputDecoration(
                            errorText: _validatepassword
                                ? 'Value Can\'t Be Empty'
                                : null,
                            border: InputBorder.none,
                            hintText: 'Enter your password',
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
                      ListTile(
                        leading: const Icon(Icons.lock_outline_sharp),
                        title: new TextFormField(
                          controller: reconpassword,
                          obscureText: true,
                          autocorrect: true,
                          decoration: new InputDecoration(
                            errorText:
                                _validaterecon ? 'Value Can\'t Be Empty' : null,
                            border: InputBorder.none,
                            hintText: 'Re-confirm your password',
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
                      RaisedButton(
                        onPressed: (onSubmit),
                        color: Colors.green,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text('Create Profile',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0)),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginUI()),
                          );
                        },
                        color: Colors.transparent,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(10.0),
                        child: Text('Already a user? Login here',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0)),
                      )
                    ],
                  ))
                ],
              ),
            ),
          )),
    ));
  }
}
