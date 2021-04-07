import 'package:flutter/material.dart';
import '../Controller/HealthProfileController.dart';
import '../Controller/UserProfileHandler.dart';
import '../Controller/InfectiousController.dart';
import 'GMap.dart';

class InfectiousUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
              height: size.height * 0.1,
              child: Row(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text("Filter cases"),
                ),
                // ElevatedButton(
                //   onPressed: (),
                //   style: ButtonStyle(
                //
                //   ),
                //   padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                //   child: Text(
                //     'Login',
                //     style:
                //         TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                //   ),
                // ),
              ])),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              child: GMap(),
              height: size.height * 0.5,
            ),
          ),
          Container(
            child: InfectiousDisease(),
            height: 500.0,
          ),
        ],
      ),
    );
  }
}

class InfectiousDisease extends StatefulWidget {
  @override
  _InfectiousDiseaseState createState() => _InfectiousDiseaseState();
}

class _InfectiousDiseaseState extends State<InfectiousDisease> {
  InfectiousController h = new InfectiousController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
        future: h.getListOfObjects('/infectiousDisease'),
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
                          Text("Disease type: "),
                          Text("Recommended diet: ")
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Single user'),
        ),
        body: FutureBuilder(
          future: u.getObject('/userProfile/:604fd4812630973608ce2e35'),
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
                          title:
                              Text("User ID: " + item.getUserID().toString()),
                        ),
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
