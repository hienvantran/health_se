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
import 'package:health_se/Controller/SuggestedExerciseController.dart';
import 'package:health_se/Controller/UserInfoController.dart';

void main() => runApp(DailyDietUI());

class DailyDietUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CalorieDisplay(),
    );
  }
}

class CalorieDisplay extends StatefulWidget {
  @override
  _CalorieDisplayState createState() => _CalorieDisplayState();
}

class _CalorieDisplayState extends State<CalorieDisplay> {
  String userName = "";
  int intakeCalorie = 0;
  int maintenanceCalorie = 0;
  UserProfile user;

  List<String> foodChoicesList;

  getFoodChoicesList() async {
    List<String> list = await DailyFoodController.getFoodChoicesNames();
    setState(() {
      foodChoicesList = list;
      print("list\n");
      print(foodChoicesList);
    });
  }

  @override
  void initState() {
    super.initState();
    getMaintenanceCal();
    getFoodChoicesList();
  }

  getMaintenanceCal() async {
    user = UserInfoController.user;
    userName = user.getUserID();
    // UserProfileHandler u = new UserProfileHandler();
    // UserProfile up = await u.getObject('/userprofile/' + userName);
    print("test\n");
    print(user.getUserID().toString());

    setState(() {
      maintenanceCalorie = user.getMaintenanceCal();
      intakeCalorie =
          DailyFoodController.calculateTotalCalorie(user.getFoodRecordsList());
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
                                        expensionTile(foodChoicesList,
                                            intakeCalorie, callback)));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              Text('Add'),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightGreen[300],
                          ),
                          onPressed: () async {
                            await DailyFoodController.resetRecord(userName);
                            setState(() {
                              intakeCalorie = 0;
//                              intakeCalorie =
//                                  DailyFoodController.calculateTotalCalorie(
//                                      user.getFoodRecordsList());
                            });
                          },
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              Text('Reset'),
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
              FutureBuilder(
                  future: SuggestedExerciseController.getSugExercise(
                      intakeCalorie, maintenanceCalorie),
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else
                      return Container(
                        padding: EdgeInsets.only(left: 40.0, top: 20.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Result: \n${snapshot.data}',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFF09216B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                  }),
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
  UserProfile user;

  Future<List<dynamic>> getFoodRecordList() async {
    user = UserInfoController.user;
    UserProfile up =
        await u.getObject('/userprofile/' + user.getUserID().toString());
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
