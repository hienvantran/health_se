import 'package:flutter/material.dart';
import 'package:health_se/Controller/DailyFoodController.dart';
import 'package:health_se/components/reuseable_card.dart';
import 'package:health_se/components/RoundIconButton.dart';
import 'package:health_se/Controller/UserProfileController.dart';

class expensionTile extends StatefulWidget {
  @override
  _expensionTileState createState() => _expensionTileState();
}

class _expensionTileState extends State<expensionTile> {
  int amount = 0;

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
            SizedBox(height: 20.0),
            ExpansionTile(
              title: Text(
                'rice',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundIconButton(
                              icon: Icons.exposure_minus_1,
                              onPressed: () {
                                setState(() {
                                  amount -= 10;
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
                            onPressed: () {
                              setState(() {
                                DailyFoodController.addRecord(
                                    '604fd4b12630973608ce2e36', amount, 'rice');
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
                ListTile(
                  title: Text('data'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
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
