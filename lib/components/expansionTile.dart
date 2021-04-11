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
                                                if (amount >= 50) amount -= 50;
                                              });
                                            }),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        RoundIconButton(
                                          icon: Icons.add,
                                          onPressed: () {
                                            setState(() {
                                              amount += 50;
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
                                              Navigator.of(context).pop();
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
