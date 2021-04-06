import 'package:flutter/material.dart';
import '../Controller/HealthProfileHandler.dart';
import '../Controller/UserProfileController.dart';
import '../components/expansionTile.dart';
import '../Entity/UserProfile.dart';

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

class _HealthDiseasesState extends State<HealthDiseases> {
  HealthDiseaseHandler h = new HealthDiseaseHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
        future: h.getListOfObjects('/healthDisease'),
        initialData: [],
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, int position) {
                    final item = snapshot.data[position];
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
                )
              : Center(
                  child: CircularProgressIndicator(),
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
  UserProfile user = UserProfileController.user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Text(user.getUserID()),
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
