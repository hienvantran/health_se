import 'package:flutter/material.dart';
import 'package:health_se/Controller/HealthProfileController.dart';
import 'package:health_se/Controller/UserProfileController.dart';
import '../Controller/HealthProfileHandler.dart';
import '../Controller/UserInfoController.dart';
import '../components/expansionTile.dart';
import '../Entity/UserProfile.dart';
import '../Entity/HealthDiseases.dart';

class HealthProfileUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: UserInfo(),
                  height: 175.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 40.0, top: 20.0),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'You are prone to the following diseases:',
                    style: TextStyle(
                      fontFamily: 'FjallaOne',
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  child: HealthDiseases(),
                  height: 355.0,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class HealthDiseases extends StatefulWidget {
  @override
  _HealthDiseasesState createState() => _HealthDiseasesState();
}

// class _HealthDiseasesState extends State<HealthDiseases> {
//   HealthDiseaseHandler h = new HealthDiseaseHandler();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List>(
//         future: h.getListOfObjects('/healthDisease'),
//         initialData: [],
//         builder: (context, snapshot) {
//           return snapshot.hasData
//               ? ListView.builder(
//                   itemCount: snapshot.data.length,
//                   itemBuilder: (_, int position) {
//                     final item = snapshot.data[position];
//                     //get your item data here ...
//                     return Card(
//                       child: ExpansionTile(
//                         title: Text("Disease Name: " + item.getDiseaseName()),
//                         initiallyExpanded: false,
//                         maintainState: false,
//                         children: <Widget>[
//                           Text("Disease type: " + item.getDiseaseType()),
//                           Text("Recommended diet: " + item.getRecommendedDiet())
//                         ],
//                       ),
//                     );
//                   },
//                 )
//               : Center(
//                   child: CircularProgressIndicator(),
//                 );
//         },
//       ),
//     );
//   }
// }

class _HealthDiseasesState extends State<HealthDiseases> {
  List<HealthDisease> userDiseases = <HealthDisease>[];

  @override
  void initState() {
    super.initState();
    initUserDiseases();
  }

  initUserDiseases() async {
    print(UserInfoController.user.getName());
    await HealthProfileController.getHealthDiseases();
    setState(() {
      userDiseases = UserInfoController.healthDiseases;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: userDiseases.length,
        itemBuilder: (_, int position) {
          final item = userDiseases[position];
          //get your item data here ...
          return Card(
            child: ExpansionTile(
              title: Text("Disease Name: " + item.getDiseaseName()),
              initiallyExpanded: false,
              maintainState: false,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.ltr,
                    children: [
                      Text("Disease type: " + item.getDiseaseType() + '\n'),
                      Text("Recommended diet: " +
                          item.getRecommendedDiet() +
                          '\n'),
                      Text("Suggestions: " + item.getSuggestion()),
                      Text("Prevention Measures: " + item.getMeasures())
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  UserProfile currUser = null;
  UserProfile user;
  String imgPath = '';
  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    UserProfile user = UserInfoController.user;
    print(user.getUserID());
    setState(() {
      currUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    String weight = currUser.getWeight().toString();
    String height = currUser.getHeight().toString();
    String gender = currUser.getGender();
    String BMI = currUser.getBmi().toStringAsFixed(2).toString();

    String bodyfat =
        currUser.getBodyFatPercentage().toStringAsFixed(2).toString();
    String ideal = currUser.getIdeal();
    String cal = currUser.getMaintenanceCal().toString();
    imgPath = UserProfileController.returnImagePath(gender);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 500.0,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              color: Color(0xFF479055),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage(imgPath),
                height: 50.0,
                width: 50.0,
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'WEIGHT: ${weight}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'HEIGHT: ${height}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'BMI: ${BMI}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'BODY FAT PERCENTAGE: ${bodyfat}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Ideal Weight Range: ${ideal}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Calories: ${cal}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// FutureBuilder<UserProfile>(
// future: user,
// //initialData: [],
// builder: (context, snapshot) {
// return snapshot.hasData
// ? ListView.builder(
// itemCount: snapshot.data.length,
// itemBuilder: (_, int position) {
// final item = snapshot.data[position];
// //get your item data here ...
// return Card(
// child: ListTile(
// title: Text("Username: " + item.getName()),
// ),
// );
// },
// )
//     : Center(
// child: CircularProgressIndicator(),
// );
// },
// ),
