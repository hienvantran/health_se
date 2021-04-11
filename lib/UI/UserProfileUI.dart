import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_se/Controller/UserInfoController.dart';
import 'package:health_se/Controller/UserProfileController.dart';
import 'package:health_se/Entity/UserProfile.dart';
import 'package:health_se/UI/EditProfileUI.dart';

const PrimaryColor = const Color(0xFF4CAF50);

class UserProfileUI extends StatefulWidget {
  @override
  _UserProfileUIState createState() => _UserProfileUIState();
}

class _UserProfileUIState extends State<UserProfileUI> {
  String gender;
  String name;
  String username;
  int weight, height, waist;
  int age = 18;
  String imgPath = "";
  UserProfile user;
  List<String> test = [];
  List<String> attributes = <String>[
    'Name:',
    'Gender:',
    'Age:',
    'Weight:',
    'Height:',
    'Waist Size:'
  ];
  @override
  void initState() {
    super.initState();
    initData();
  }

  callback(updatedUser) {
    setState(() {
      user = updatedUser;
      gender = user.getGender();
      name = user.getName();
      username = user.getUsername();
      weight = user.getWeight();
      height = user.getHeight();
      waist = user.getWaist();
      age = int.parse(user.getAge());
      test = [];
      test.add(name);
      test.add(gender);
      test.add(age.toString());
      test.add(weight.toString());
      test.add(height.toString());
      test.add(waist.toString());
    });
  }

  initData() {
    user = UserInfoController.user;
    gender = user.getGender();
    name = user.getName();
    username = user.getUsername();
    weight = user.getWeight();
    height = user.getHeight();
    waist = user.getWaist();
    age = int.parse(user.getAge());
    imgPath = UserProfileController.returnImagePath(gender);
    test.add(name);
    test.add(gender);
    test.add(age.toString());
    test.add(weight.toString());
    test.add(height.toString());
    test.add(waist.toString());
  }

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
          height: size.height * 0.1,

          margin: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: Color(0xFF479055),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          // height: size.height / 8,
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image(
                image: AssetImage(imgPath),
                height: size.height * 0.08,
                width: size.width * 0.19,
              ),
              Text(name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white)),
//              SizedBox(width: 70.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfileUI()),
                  );
                },
                child: Icon(
                  Icons.edit_sharp,
                  size: 35.0,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 50.0),
        Container(
          height: 420,
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: attributes.length,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFF479055),
                  ),
                  child: Center(
                      child: Text('${attributes[i]} ${test[i]}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              fontFamily: 'FjallaOne',
                              color: Colors.white))));
            },
            separatorBuilder: (BuildContext context, int i) => const Divider(),
          ),
        )
      ]),
    )));
  }
}
