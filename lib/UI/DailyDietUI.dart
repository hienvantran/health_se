import 'package:flutter/material.dart';
import 'package:health_se/components/expansionTile.dart';
import 'package:health_se/UI/GymUI.dart';
import 'package:health_se/Controller/UserProfileHandler.dart';
import 'package:health_se/Controller/DailyFoodController.dart';
import 'package:health_se/Entity/UserProfile.dart';
import 'package:health_se/UI/DietPlanDisplay.dart';
import 'package:health_se/Controller/SuggestedExerciseController.dart';
import 'package:health_se/Controller/UserInfoController.dart';

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
    });
  }

  @override
  void initState() {
    super.initState();
    getCal();
    getFoodChoicesList();
  }

  getCal() async {
    user = UserInfoController.user;
    userName = user.getUserID();
    print(user.getUserID().toString());

    setState(() {
      maintenanceCalorie = user.getMaintenanceCal();
      intakeCalorie =
          DailyFoodController.calculateTotalCalorie(user.getTodayRecords());
    });
  }

  callback(newIntakeCal) {
    setState(() {
      intakeCalorie = newIntakeCal;
    });
  }

  refreshRecords() async {
    UserProfileHandler u = new UserProfileHandler();
    UserProfile up =
        await u.getObject('/userprofile/' + user.getUserID().toString());
    setState(() {
      intakeCalorie =
          DailyFoodController.calculateTotalCalorie(up.getTodayRecords());
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
                color: Color(0xFF479055),
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            'INTAKE',
                            style: TextStyle(
                              fontFamily: 'FjallaOne',
                              fontSize: 25.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            intakeCalorie.toString(),
                            style: TextStyle(
                              fontFamily: 'FjallaOne',
                              fontSize: 25.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Text(
                            'TARGET',
                            style: TextStyle(
                              fontFamily: 'FjallaOne',
                              fontSize: 25.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          maintenanceCalorie.toString(),
                          style: TextStyle(
                            fontFamily: 'FjallaOne',
                            fontSize: 25.0,
                            color: Colors.white,
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
              SizedBox(height: 20),
              Future_FoodItem(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 60.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF479055),
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
                            primary: Color(0xFF479055),
                          ),
                          onPressed: () async {
                            showAlertDialog(context, userName)
                                .then((value) => refreshRecords());
                          },
                          child: Row(
                            children: [
                              Icon(Icons.delete_forever),
                              Text('Reset'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 12),
              DietPlanDisplay(maintenanceCalorie),
              SizedBox(height: 20),
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
                          '${snapshot.data}',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
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
                            primary: Color(0xFF479055)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => map()));
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.map),
                            Text('View Gyms'),
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

showAlertDialog(BuildContext context, String userName) {
  return showDialog(
    context: context,
    builder: (context) {
      String contentText = "Content of Dialog";
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("Reset"),
            content: Text('Your food records will be reseted'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              FlatButton(
                onPressed: () async {
                  await DailyFoodController.resetRecord(userName);
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text(
                  "Reset",
                ),
              ),
            ],
          );
        },
      );
    },
  );
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
    List<dynamic> list = up.getTodayRecords();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
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
                            item['foodAmount'].toString() +
                            " kcal"),
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
