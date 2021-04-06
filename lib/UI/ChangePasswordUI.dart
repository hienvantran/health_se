import 'package:flutter/material.dart';

void main() => runApp(ChangePasswordUI());

class ChangePasswordUI extends StatefulWidget {
  @override
  _ChangePasswordUIState createState() => _ChangePasswordUIState();
}

class _ChangePasswordUIState extends State<ChangePasswordUI> {
  final currentp = TextEditingController();

  final newpass = TextEditingController();

  final newpass_c = TextEditingController();

  bool _validatep = false;

  bool _validatec = false;
  bool _validatem = false;

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Change Password'),
            centerTitle: true,
            backgroundColor: Color(0xFF1F5543),
          ),
          body: new Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: currentp,
                    obscureText: true,
                    decoration: InputDecoration(
                      errorText: _validatep ? 'Value Can\'t Be Empty' : null,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: newpass,
                    obscureText: true,
                    decoration: InputDecoration(
                      errorText: _validatep ? 'Value Can\'t Be Empty' : null,
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: 'Enter new password',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: newpass_c,
                    obscureText: true,
                    decoration: InputDecoration(
                      errorText: _validatem ? 'Value Can\'t Be Empty' : null,
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
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () {
                  currentp.text.isEmpty
                      ? _validatep = true
                      : _validatep = false;
                  newpass.text.isEmpty ? _validatec = true : _validatec = false;
                  newpass_c.text.isEmpty
                      ? _validatem = true
                      : _validatem = false;
                  if ((_validatep == false) &&
                      (_validatec == false) &&
                      (_validatem == false) &&
                      (newpass_c.text == newpass.text))
                    showAlertDialog(context);
                },
                color: Colors.green,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text('Reset Password',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              ),
            ],
          )),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    // ignore: deprecated_member_use
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
