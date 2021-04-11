import 'package:flutter/material.dart';
import 'package:health_se/Controller/HealthProfileController.dart';
import 'package:health_se/Controller/UserProfileController.dart';
import 'package:health_se/Controller/UserInfoController.dart';
import 'package:health_se/Entity/UserProfile.dart';
import 'package:health_se/Entity/HealthDiseases.dart';

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
                  height: 220.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 30.0, top: 20.0),
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
    Size size = MediaQuery.of(context).size;
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
          height: 600,
          decoration: BoxDecoration(
              color: Color(0xFF479055),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Image(
                  image: AssetImage(imgPath),
                  height: 50.0,
                  width: 50.0,
                ),
              ),
              SizedBox(width: 20.0),
              Container(
                height: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        'Weight: ${weight} kg',
                        style: TextStyle(
                            fontSize: 20.0,
                            //   fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        'Height: ${height} cm',
                        style: TextStyle(
                            fontSize: 20.0,
                            //  fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        'BMI: ${BMI}',
                        style: TextStyle(
                            fontSize: 20.0,
                            //  fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        'Body fat: ${bodyfat}%',
                        style: TextStyle(
                            fontSize: 20.0,
                            //    fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        'Ideal Weight: ${ideal} kg',
                        style: TextStyle(
                            fontSize: 20.0,
                            //   fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        'Calories: ${cal} kcal',
                        style: TextStyle(
                            fontSize: 20.0,
                            //  fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
