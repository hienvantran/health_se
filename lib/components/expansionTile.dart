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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Food Record'),
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
                              style: TextStyle(fontSize: 18.0),
                            ),
                            children: <Widget>[
                              ReusableCard(
                                cardChild: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Text(amount.toString() + " gram",
                                          style: TextStyle(fontSize: 18)),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        RoundIconButton(
                                            icon: Icons.remove,
                                            onPressed: () {
                                              setState(() {
                                                if (amount >= 50) amount -= 50;
                                              });
                                            }),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        RoundIconButton(
                                          icon: Icons.add,
                                          onPressed: () {
                                            setState(() {
                                              amount += 50;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF479055),
                                          ),
                                          onPressed: () async {
                                            await showAlertDialog(
                                                    context,
                                                    widget
                                                        .foodChoicesList[index],
                                                    amount,
                                                    widget.foodChoicesList,
                                                    index)
                                                .then((valueFromDialog) {
                                              // use the value as you wish
                                              widget.intakeCal =
                                                  valueFromDialog;
                                            });
                                            if (widget.intakeCal != null) {
                                              setState(() {
                                                widget
                                                    .callback(widget.intakeCal);
                                                Navigator.of(context).pop();
                                              });
                                            }
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
          ],
        ),
      ),
    );
  }
}

//
showAlertDialog(BuildContext context, String name, int amount,
    List<String> foodChoicesList, int index) {
  return showDialog(
    context: context,
    builder: (context) {
      String contentText = "Content of Dialog";
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("Confirm add record"),
            content:
                Text("You are adding:\n$name : " + amount.toString() + ' gram'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
//                  int calorie = Cal;
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              FlatButton(
                onPressed: () async {
                  UserProfile user = UserInfoController.user;

                  int calorie = await DailyFoodController.addRecord(
                      user.getUserID(), amount, foodChoicesList[index]);

                  Navigator.pop(context, calorie);
                },
                child: Text(
                  "Add",
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
