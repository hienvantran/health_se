import 'package:flutter/material.dart';
import 'package:health_se/Controller/UserInfoController.dart';
import 'package:health_se/Controller/UserProfileController.dart';
import 'package:health_se/UI/UserProfileUI.dart';
import 'package:health_se/Entity/UserProfile.dart';
import 'LoginUI.dart';

const PrimaryColor = const Color(0xFF41AA46);
void main() => runApp(EditProfileUI());
//typedef void UserCallback(UserProfile val);

class EditProfileUI extends StatefulWidget {
  Function(UserProfile) callback;

  EditProfileUI({this.callback});
  @override
  _EditProfileUIState createState() => _EditProfileUIState();
}

class _EditProfileUIState extends State<EditProfileUI> {
  getItemAndNavigate(BuildContext context) {
//    Navigator.push(
//      context,
////      MaterialPageRoute(builder: (context) => UserProfileUI()),
////        Navigator.of(context).pop();
//    );

    Navigator.of(context).pop();
  }

  void onSubmit() async {
    setState(() {
      name.text.isEmpty ? _validatename = true : _validatename = false;
      age.text.isEmpty ? _validateage = true : _validateage = false;
      weight.text.isEmpty ? _validateweight = true : _validateweight = false;
      height.text.isEmpty ? _validateheight = true : _validateheight = false;
      waist.text.isEmpty ? _validatewaist = true : _validatewaist = false;
      gender.text.isEmpty ? _validategender = true : _validategender = false;
    });
    Map<String, String> editedInfo = {
      'name': name.text,
      'gender': gender.text,
      'age': age.text,
      'weight': weight.text,
      'height': height.text,
      'waist': waist.text
    };

    await UserProfileController.editProfile(editedInfo);
    setState(() {
      widget.callback(UserInfoController.user);
    });
    getItemAndNavigate(context);
  }

//  UserProfile user = UserInfoController.user;
  bool _validatename = false;
  bool _validateage = false;
  bool _validategender = false;
  bool _validateweight = false;
  bool _validateheight = false;
  bool _validatewaist = false;

  final name = TextEditingController(text: UserInfoController.user.getName());
  final age = TextEditingController(text: UserInfoController.user.getAge());
  final weight = TextEditingController(
      text: UserInfoController.user.getWeight().toString());
  final height = TextEditingController(
      text: UserInfoController.user.getHeight().toString());
  final waist = TextEditingController(
      text: UserInfoController.user.getWaist().toString());
  final gender =
      TextEditingController(text: UserInfoController.user.getGender());

  void setUser() {
    UserProfile user = new UserProfile();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        home: Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Edit Profile'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              SizedBox(height: 20.0),
              Container(
                  margin: const EdgeInsets.all(6.0),
                  child: Column(children: <Widget>[
                    Text('Edit Information',
                        style: TextStyle(
                            fontFamily: 'FjallaOne',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10.0),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: new TextFormField(
                        controller: name,
                        decoration: new InputDecoration(
                          errorText:
                              _validatename ? 'Value Can\'t Be Empty' : null,
                          border: InputBorder.none,
                          hintText: 'Enter your name',
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
                      leading: const Icon(Icons.format_list_numbered_sharp),
                      title: new TextFormField(
                        controller: age,
                        decoration: new InputDecoration(
                          errorText:
                              _validateage ? 'Value Can\'t Be Empty' : null,
                          border: InputBorder.none,
                          hintText: 'Enter your age',
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
                      leading: const Icon(Icons.line_weight),
                      title: new TextFormField(
                        controller: weight,
                        decoration: new InputDecoration(
                          errorText:
                              _validateweight ? 'Value Can\'t Be Empty' : null,
                          border: InputBorder.none,
                          hintText: 'Enter your weight',
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
                      leading: const Icon(Icons.trending_up_sharp),
                      title: new TextFormField(
                        controller: height,
                        decoration: new InputDecoration(
                          errorText:
                              _validateheight ? 'Value Can\'t Be Empty' : null,
                          border: InputBorder.none,
                          hintText: 'Enter your height',
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
                      leading: const Icon(Icons.person_pin),
                      title: new TextFormField(
                        controller: gender,
                        decoration: new InputDecoration(
                          errorText:
                              _validategender ? 'Value Can\'t Be Empty' : null,
                          border: InputBorder.none,
                          hintText: 'Enter your gender',
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
                      leading: const Icon(Icons.accessibility_new),
                      title: new TextFormField(
                        controller: waist,
                        decoration: new InputDecoration(
                          errorText:
                              _validatewaist ? 'Value Can\'t Be Empty' : null,
                          border: InputBorder.none,
                          hintText: 'Enter your waist circumference',
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
                        child: Text('Update Particulars')),
                  ])),
            ]),
          ),
        ),
      ),
    ));
  }
}
