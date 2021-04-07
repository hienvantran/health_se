import 'package:flutter/material.dart';
import 'package:health_se/Controller/HealthProfileController.dart';
import '../Controller/HealthProfileHandler.dart';
import '../Controller/UserInfoController.dart';
import '../components/expansionTile.dart';
import '../Entity/UserProfile.dart';
import '../Entity/HealthDiseases.dart';

class HealthProfileUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            child: UserInfo(),
            height: 500.0,
          ),
          Container(
            child: HealthDiseases(),
            height: 500.0,
          ),
        ],
      ),
    );
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
  HealthDiseaseHandler h = new HealthDiseaseHandler();
  List<HealthDisease> userDiseases = <HealthDisease>[];

  @override
  void initState() {
    super.initState();
    initUserDiseases();
  }

  initUserDiseases() async {
    print(UserInfoController.user.getName());
    await HealthProfileController.getHealthDiseases();
    userDiseases = UserInfoController.healthDiseases;
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
                Text("Disease type: " + item.getDiseaseType()),
                Text("Recommended diet: " + item.getRecommendedDiet())
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
  String userName = "0";

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    UserProfile user = UserInfoController.user;
    print(user.getUserID());
    setState(() {
      userName = user.getName();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Text(userName),
    ));
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
