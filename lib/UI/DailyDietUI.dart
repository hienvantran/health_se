import 'package:flutter/material.dart';
import '../components/expansionTile.dart';
import 'GymUI.dart';
import 'package:health_se/Controller/UserProfileHandler.dart';
import 'package:health_se/components/expansionTile.dart';
import 'package:health_se/Controller/DailyFoodController.dart';
import 'package:health_se/Entity/FoodRecord.dart';
import 'package:health_se/Entity/UserProfile.dart';
import 'package:health_se/UI/DietPlanDisplay.dart';
import 'package:health_se/Controller/UserProfileController.dart';

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

class CalorieDisplay extends StatefulWidget {
  @override
  _CalorieDisplayState createState() => _CalorieDisplayState();
}

class _CalorieDisplayState extends State<CalorieDisplay> {
  String userName = UserProfileController.user.getUserID();
  int intakeCalorie = 0;
  int maintenanceCalorie = 0;

  @override
  void initState() {
    super.initState();
    getMaintenanceCal();
  }

  getMaintenanceCal() async {
    UserProfileHandler u = new UserProfileHandler();
    UserProfile up = await u.getObject('/userprofile/' + userName);
    print("test\n");
    print(UserProfileController.user.getUserID().toString());

    setState(() {
      maintenanceCalorie = up.getMaintenanceCal();
      intakeCalorie =
          DailyFoodController.calculateTotalCalorie(up.getFoodRecordsList());
    });
  }

  callback(newIntakeCal) {
    setState(() {
      intakeCalorie = newIntakeCal;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                color: Colors.lightGreen,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
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
              Future_FoodItem(),
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
                                        expensionTile(
                                            intakeCalorie, callback)));
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
              DietPlanDisplay(maintenanceCalorie),
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
//              Future(),
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
//              Future(),
            ],
          ),
        ),
      );
    });
    ;
  }
}

class Future_FoodItem extends StatefulWidget {
  @override
  _Future_FoodItemState createState() => _Future_FoodItemState();
}

class _Future_FoodItemState extends State<Future_FoodItem> {
  UserProfileHandler u = new UserProfileHandler();

  Future<List<dynamic>> getFoodRecordList() async {
    UserProfile up = await u
        .getObject('/userprofile/' + UserProfileController.user.getUserID());
    List<dynamic> list = up.getFoodRecordsList();
    print(list);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 200,
      child: FutureBuilder<List>(
        future: getFoodRecordList(),
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
                        title: Text(item['foodCategory'] +
                            ": " +
                            item['foodAmount'].toString()),
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
