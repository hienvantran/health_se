import 'package:flutter/material.dart';
import 'LoginUI.dart';
import 'UserProfileUI.dart';

void main() => runApp(CreateProfileUI());

class CreateProfileUI extends StatefulWidget {
  @override
  _CreateProfileUIState createState() => _CreateProfileUIState();
}

class _CreateProfileUIState extends State<CreateProfileUI> {
  final username = TextEditingController();
  final name = TextEditingController();
  final password = TextEditingController();
  final reconpassword = TextEditingController();

  bool _validate = false;

  bool _validatep = false;
  bool _validater = false;

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
          backgroundColor: Color(0xFF3F7867),
          body: SingleChildScrollView(
            reverse: true,
            child: Center(
              child: new Column(
                children: <Widget>[
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 25.0),
                      Image(
                        image: AssetImage('images/logo_size_invert.jpg'),
                      ),
                      SizedBox(height: 30.0),
                      Text('healthSEcure',
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
                            controller: password,
                            obscureText: true,
                            decoration: InputDecoration(
                              errorText:
                                  _validatep ? 'Value Can\'t Be Empty' : null,
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: reconpassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              errorText:
                                  _validater ? 'Value Can\'t Be Empty' : null,
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              hintText: 'Re-confirm your password',
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
                      // ignore: deprecated_member_use
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            username.text.isEmpty
                                ? _validate = true
                                : _validate = false;
                            password.text.isEmpty
                                ? _validatep = true
                                : _validatep = false;
                            if ((_validate == false) &&
                                (_validatep == false) &&
                                (password.text == reconpassword.text))
                              getItemAndNavigate(context);
                          });
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text('Create Profile',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0)),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginUI()),
                          );
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
