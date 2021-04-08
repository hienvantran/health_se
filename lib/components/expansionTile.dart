import 'package:flutter/material.dart';
import 'package:health_se/Controller/DailyFoodController.dart';
import 'package:health_se/components/reuseable_card.dart';
import 'package:health_se/components/RoundIconButton.dart';
import 'package:health_se/Controller/UserProfileController.dart';
import 'package:health_se/Controller/UserInfoController.dart';
import 'package:health_se/Entity/UserProfile.dart';
import 'package:health_se/Controller/SuggestedExerciseController.dart';

class expensionTile extends StatefulWidget {
  List<String> foodChoicesList;
  int intakeCal;
  Function(int) callback;

  expensionTile(this.foodChoicesList, this.intakeCal, this.callback);
  @override
  _expensionTileState createState() => _expensionTileState();
}

class _expensionTileState extends State<expensionTile> {
  int amount = 0;
  int selected = 0;
  String exerciseInfo;
//  List<String> foodChoicesList;
//
//  getFoodChoicesList() async {
//    List<String> list = await DailyFoodController.getFoodChoicesNames();
//    setState(() {
//      foodChoicesList = list;
//    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    getFoodChoicesList();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Expansion Tile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: <Widget>[
            Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(children: [
                    ListView.builder(
                      key: Key('builder ${selected.toString()}'), //attention

                      padding: EdgeInsets.only(
                          left: 13.0, right: 13.0, bottom: 25.0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.foodChoicesList.length,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                            key: Key(index.toString()),
                            //attention
                            initiallyExpanded: index == selected,
                            //attention

                            title: Text(
                              '${widget.foodChoicesList[index]}',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            children: <Widget>[
                              ReusableCard(
                                colour: Colors.lightGreen,
                                cardChild: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      amount.toString() + " gram",
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        RoundIconButton(
                                            icon: Icons.remove,
                                            onPressed: () {
                                              setState(() {
                                                if (amount >= 10) amount -= 10;
                                              });
                                            }),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        RoundIconButton(
                                          icon: Icons.add,
                                          onPressed: () {
                                            setState(() {
                                              amount += 10;
                                            });
                                          },
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.lightGreen[300],
                                          ),
                                          onPressed: () async {
                                            showAlertDialog(
                                                context,
                                                widget.foodChoicesList[index],
                                                amount);
                                            UserProfile user =
                                                UserInfoController.user;

                                            widget.intakeCal =
                                                await DailyFoodController
                                                    .addRecord(
                                                        user.getUserID(),
                                                        amount,
                                                        widget.foodChoicesList[
                                                            index]);
                                            setState(() {
                                              widget.callback(widget.intakeCal);
                                            });
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
                                  ],
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
                      },
                    )
                  ]),
                )),
//            ExpansionTile(
//              title: Text(
//                'rice',
//                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//              ),
//              children: <Widget>[
//                ReusableCard(
//                  colour: Colors.lightGreen,
//                  cardChild: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Text(
//                        amount.toString() + " gram",
//                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          RoundIconButton(
//                              icon: Icons.remove,
//                              onPressed: () {
//                                setState(() {
//                                  amount -= 10;
//                                });
//                              }),
//                          SizedBox(
//                            width: 10.0,
//                          ),
//                          RoundIconButton(
//                            icon: Icons.add,
//                            onPressed: () {
//                              setState(() {
//                                amount += 10;
//                              });
//                            },
//                          ),
//                          ElevatedButton(
//                            style: ElevatedButton.styleFrom(
//                              primary: Colors.lightGreen[300],
//                            ),
//                            onPressed: () {
//                              setState(() async {
//                                widget.intakeCal =
//                                    await DailyFoodController.addRecord(
//                                        UserProfileController.user.getUserID(),
//                                        amount,
//                                        'rice');
//                                widget.callback(widget.intakeCal);
//                              });
//                            },
//                            child: Row(
//                              children: [
//                                Icon(Icons.add),
//                                Text('Add'),
//                              ],
//                            ),
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//                ListTile(
//                  title: Text('data'),
//                )
//              ],
//            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, String name, int amount) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirm add record"),
    content: Text("You have added:\n$name : " + amount.toString() + 'gram'),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//class Future_FoodItem extends StatefulWidget {
//  @override
//  _Future_FoodItemState createState() => _Future_FoodItemState();
//}
//
//class _Future_FoodItemState extends State<Future> {
//  DailyDietController u = new DailyDietController();
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: 300,
//      width: 200,
//      child: FutureBuilder<List>(
//        future: u.getListOfObjects('/dailyDiet/food'),
//        //initialData: [],
//        builder: (context, snapshot) {
//          return snapshot.hasData
//              ? ListView.builder(
//                  itemCount: snapshot.data.length,
//                  itemBuilder: (_, int position) {
//                    final item = snapshot.data[position];
//                    //get your item data here ...
//                    return Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Container(
//                          margin: EdgeInsets.only(left: 40.0),
//                          child: Row(
//                            children: <Widget>[
//                              ElevatedButton(
//                                style: ElevatedButton.styleFrom(
//                                  primary: Colors.lightGreen[300],
//                                ),
//                                onPressed: () {
//                                  Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (BuildContext context) =>
//                                              expansionTile()));
//                                },
//                                child: Row(
//                                  children: [
//                                    Icon(Icons.add),
//                                    Text('Add'),
//                                  ],
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ],
//                    ),
//                  },
//                )
//              : Center(
//                  child: CircularProgressIndicator(),
//                );
//        },
//      ),
//    );
//  }
//}
