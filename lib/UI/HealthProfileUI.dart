import 'package:flutter/material.dart';
import '../Controller/HealthProfileController.dart';
import '../Controller/UserProfileController.dart';
import '../components/expansionTile.dart';

class HealthProfileUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            child: UserProfile(),
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

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  UserProfileHandler u = new UserProfileHandler();
  //Future<dynamic> user =UserProfileHandler().getObject('/userProfile/:604fd4812630973608ce2e35');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: u.getListOfObjects('/userProfile'),
        //initialData: [],
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, int position) {
                    final item = snapshot.data[position];
                    //get your item data here ...
                    return Card(
                      child: ListTile(
                        title: Text("Username: " + item.getUsername()),
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
