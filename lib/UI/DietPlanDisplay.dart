import 'package:flutter/material.dart';
import 'package:health_se/Controller/UserProfileController.dart';
import 'package:health_se/Controller/UserInfoController.dart';
import 'package:health_se/Controller/SuggestedDietController.dart';
import 'package:health_se/Entity/UserProfile.dart';

class DietPlanDisplay extends StatefulWidget {
  int maintenanceCal;
  DietPlanDisplay(this.maintenanceCal);
  @override
  _DietPlanDisplayState createState() => _DietPlanDisplayState();
}

class _DietPlanDisplayState extends State<DietPlanDisplay> {
  String imgPath;
  List<String> compositions = [
    'High Carbohydrates',
    'Moderate Carbohydrates',
    'Low Carbohydrates'
  ];
  List<int> nutritionList;
  int selected = 1; //attention
  int initialTap = 1;
  double bmi = 22;
  UserProfile user;

  @override
  void initState() {
    super.initState();
    getBmi();
  }

  getBmi() async {
    UserProfile user = UserInfoController.user;
    print(user.getUserID());
    setState(() {
      bmi = user.getBmi();
    });
  }

  int getDefaultIndex() {
    print(bmi);
    if (bmi <= 18.5) {
      initialTap = 2;
    } else if (bmi >= 25) {
      initialTap = 0;
    }
    return initialTap;
  }

  loadNutritionFact(String plan, String composition, int calorie) async {
    List<int> list =
        await SuggestedDietController.getSugDiet(plan, composition, calorie);

    nutritionList = list;
  }

  Future<String> formatNutritionFact(
      String plan, String composition, int calorie, bool selected) async {
    if (selected) {
      print(plan + " " + composition + ":\n");
      print('before\n');
      print(nutritionList);
      await loadNutritionFact(plan, composition, calorie);
      print('after\n');
      print(nutritionList);
    }
    String txt = plan + ": \n";
    String protein = "Protein: " + nutritionList[0].toString() + "g \n";
    String carb = "Carb: " + nutritionList[1].toString() + "g \n";
    String fat = "Fat: " + nutritionList[2].toString() + "g \n";
    return txt + protein + carb + fat;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      child: DefaultTabController(
          length: 3, // length of tabs
          initialIndex: getDefaultIndex(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                  Widget>[
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
                height: 270, //height of TabBarView
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.5))),
                child: TabBarView(children: <Widget>[
                  Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          ListView.builder(
                            key: Key(
                                'builder ${selected.toString()}'), //attention

                            padding: EdgeInsets.only(
                                left: 13.0, right: 13.0, bottom: 25.0),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return FutureBuilder(
                                  future: formatNutritionFact(
                                      'Cutting',
                                      compositions[index],
                                      widget.maintenanceCal - 500,
                                      index == selected),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData)
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    else
                                      return ExpansionTile(
                                          key: Key(index.toString()),
                                          //attention
                                          initiallyExpanded: index == selected,
                                          //attention

                                          title: Text('${compositions[index]}',
                                              style: TextStyle(
                                                  color: Color(0xFF09216B),
                                                  fontWeight: FontWeight.bold)),
                                          children: <Widget>[
                                            Container(
                                              child: Container(
                                                child: Text(
                                                  '${snapshot.data}',
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                    color: Color(0xFF09216B),
                                                  ),
                                                ),
                                                alignment: Alignment(1.0, 1.0),
                                              ),
                                              height: 210,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.blue,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        SuggestedDietController
                                                            .returnImagePath(
                                                                index)),
                                                    fit: BoxFit.fill),
                                              ),
                                            ),
                                          ],
                                          onExpansionChanged: ((newState) {
                                            if (newState)
                                              setState(() {
                                                Duration(seconds: 20000);
                                                selected = index;
                                              });
                                            else
                                              setState(() {
                                                selected = -1;
                                              });
                                          }));
                                  });
                            },
                          )
                        ]),
                      )),
                  Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        ListView.builder(
                          key:
                              Key('builder ${selected.toString()}'), //attention

                          padding: EdgeInsets.only(
                              left: 13.0, right: 13.0, bottom: 25.0),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                                future: formatNutritionFact(
                                    'Maintenance',
                                    compositions[index],
                                    widget.maintenanceCal,
                                    index == selected),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError)
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  else
                                    return ExpansionTile(
                                        key: Key(index.toString()),
                                        //attention
                                        initiallyExpanded: index == selected,
                                        //attention

                                        title: Text('${compositions[index]}',
                                            style: TextStyle(
                                                color: Color(0xFF09216B),
                                                fontWeight: FontWeight.bold)),
                                        children: <Widget>[
                                          Container(
                                            child: Container(
                                              child: Text(
                                                '${snapshot.data}',
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Color(0xFF09216B),
                                                ),
                                              ),
                                              alignment: Alignment(1.0, 1.0),
                                            ),
                                            height: 210,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.blue,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      SuggestedDietController
                                                          .returnImagePath(
                                                              index)),
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                        ],
                                        onExpansionChanged: ((newState) {
                                          if (newState)
                                            setState(() {
                                              Duration(seconds: 20000);
                                              selected = index;
                                            });
                                          else
                                            setState(() {
                                              selected = -1;
                                            });
                                        }));
                                });
                          },
                        )
                      ]),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        ListView.builder(
                          key:
                              Key('builder ${selected.toString()}'), //attention

                          padding: EdgeInsets.only(
                              left: 13.0, right: 13.0, bottom: 25.0),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                                future: formatNutritionFact(
                                    'Bulking',
                                    compositions[index],
                                    widget.maintenanceCal + 500,
                                    index == selected),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError)
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  else
                                    return ExpansionTile(
                                        key: Key(index.toString()),
                                        //attention
                                        initiallyExpanded: index == selected,
                                        //attention

                                        title: Text('${compositions[index]}',
                                            style: TextStyle(
                                                color: Color(0xFF09216B),
                                                fontWeight: FontWeight.bold)),
                                        children: <Widget>[
                                          Container(
                                            child: Container(
                                              child: Text(
                                                '${snapshot.data}',
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Color(0xFF09216B),
                                                ),
                                              ),
                                              alignment: Alignment(1.0, 1.0),
                                            ),
                                            height: 210,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.blue,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      SuggestedDietController
                                                          .returnImagePath(
                                                              index)),
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                        ],
                                        onExpansionChanged: ((newState) {
                                          if (newState)
                                            setState(() {
                                              Duration(seconds: 20000);
                                              selected = index;
                                            });
                                          else
                                            setState(() {
                                              selected = -1;
                                            });
                                        }));
                                });
                          },
                        )
                      ]),
                    ),
                  ),
                ]))
          ])),
    );
  }
}
