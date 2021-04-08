import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_se/Controller/UserInfoController.dart';
import 'package:health_se/Controller/UserProfileController.dart';
import 'package:health_se/Entity/UserProfile.dart';
import 'EditProfileUI.dart';
import 'LoginUI.dart';

const PrimaryColor = const Color(0xFF4CAF50);

String gender = 'M';
String name = 'Sanath';
double weight = 85, height = 185, waist = 36;
int age = 19;

class UserProfileUI extends StatefulWidget {
  @override
  _UserProfileUIState createState() => _UserProfileUIState();
//  static MyStatefulWidgetState of(BuildContext context) =>
//      context.findAncestorStateOfType<MyStatefulWidgetState>();
//}
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
      print("TESTING\n");
      print(test);
    });
  }

//  set updateUser(UserProfile userProfile) => setState(() => user = userProfile);

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
    print(test.length);
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
          // height: size.height / 8,
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
              SizedBox(width: 150.0),
              GestureDetector(
                onTap: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (BuildContext context) =>
//                              expensionTile(foodChoicesList,
//                                  intakeCalorie, callback)));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileUI(
                              callback: callback,
                            )),
                  );
                },
                child: Icon(
                  Icons.edit_sharp,
                  size: 35.0,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 50.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 8,
            ),
            gradient: LinearGradient(colors: [Colors.blueAccent, Colors.black]),
          ),
          height: 420,
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: attributes.length,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.green,
                  ),
                  child: Center(
                      child: Text('${attributes[i]} ${test[i]}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            fontFamily: 'FjallaOne',
                          ))));
            },
            separatorBuilder: (BuildContext context, int i) => const Divider(),
          ),
        )
        // DataTable(
        //   columns: const <DataColumn>[
        //     DataColumn(
        //       label: Text(
        //         'Particulars',
        //         style: TextStyle(fontStyle: FontStyle.italic),
        //       ),
        //     ),
        //     DataColumn(
        //       label: Text(
        //         'Values',
        //         style: TextStyle(fontStyle: FontStyle.italic),
        //       ),
        //     ),
        //   ],
        //   rows: const <DataRow>[
        //     DataRow(
        //       cells: <DataCell>[
        //         DataCell(Text('Name')),
        //         DataCell(Text('Sanath')),
        //       ],
        //     ),
        //     DataRow(
        //       cells: <DataCell>[
        //         DataCell(Text('Age')),
        //         DataCell(Text('43')),
        //       ],
        //     ),
        //     DataRow(
        //       cells: <DataCell>[
        //         DataCell(Text('Gender')),
        //         DataCell(Text('27')),
        //       ],
        //     ),
        //     DataRow(
        //       cells: <DataCell>[
        //         DataCell(Text('Weight')),
        //         DataCell(Text('27')),
        //       ],
        //     ),
        //     DataRow(
        //       cells: <DataCell>[
        //         DataCell(Text('Height')),
        //         DataCell(Text('27')),
        //       ],
        //     ),
        //     DataRow(
        //       cells: <DataCell>[
        //         DataCell(Text('Waist Circumference')),
        //         DataCell(Text('27')),
        //       ],
        //     ),
        //   ],
        // ),
      ]),
    )));
  }
}
