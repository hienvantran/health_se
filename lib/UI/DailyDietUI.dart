import 'package:flutter/material.dart';
import '../components/expansionTile.dart';
import 'GymUI.dart';

void main() => runApp(DailyDietUI());

class DailyDietUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.lightGreen,
      //   title: const Text('Daily Diet'),
      //   leading: Icon(
      //     Icons.menu,
      //   ),
      //   actions: <Widget>[
      //     Padding(
      //       padding: EdgeInsets.only(right: 20.0),
      //       child: GestureDetector(
      //         onTap: () {},
      //         child: Icon(Icons.more_vert),
      //       ),
      //     )
      //   ],
      // ),
      body: CalorieDisplay(),
    );
  }
}

class CalorieDisplay extends StatelessWidget {
  int intakeCalorie = 1800;
  int maintenanceCalorie = 2100;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Card(
              color: Colors.lightGreen,
              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'INTAKE',
                        style: TextStyle(
                          fontFamily: 'FjallaOne',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        intakeCalorie.toString(),
                        style: TextStyle(
                          fontFamily: 'FjallaOne',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'TARGET',
                        style: TextStyle(
                          fontFamily: 'FjallaOne',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        maintenanceCalorie.toString(),
                        style: TextStyle(
                          fontFamily: 'FjallaOne',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 40.0, top: 20.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                'Food Intake Today',
                style: TextStyle(
                  fontFamily: 'FjallaOne',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 40.0),
                  child: Row(
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen[300],
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      expansionTile()));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.add),
                            Text('Add'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 40.0, top: 20.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                'Suggested Diet',
                style: TextStyle(
                  fontFamily: 'FjallaOne',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.0),
              child: DefaultTabController(
                  length: 3, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: TabBar(
                            labelColor: Colors.green,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Tab(text: 'Cutting'),
                              Tab(text: 'Maintenance'),
                              Tab(text: 'Bulking'),
                            ],
                          ),
                        ),
                        Container(
                            height: 100, //height of TabBarView
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey, width: 0.5))),
                            child: TabBarView(children: <Widget>[
                              Container(
                                child: Center(
                                  child: Text('Display Cutting',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: Text('Display Maintenance',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: Text('Display Bulking',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ]))
                      ])),
            ),
            Container(
              padding: EdgeInsets.only(left: 40.0, top: 20.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                'Suggested Exercise',
                style: TextStyle(
                  fontFamily: 'FjallaOne',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              height: 100,
              child: Center(
                child: Text('Display Exericse',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen[300]),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ExpansionGymMap()));
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.map),
                          Text('View Nearby Gyms'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
