import 'package:flutter/material.dart';

class DietPlanDisplay extends StatefulWidget {
  int maintenanceCal;
  DietPlanDisplay(this.maintenanceCal);
  @override
  _DietPlanDisplayState createState() => _DietPlanDisplayState();
}

class _DietPlanDisplayState extends State<DietPlanDisplay> {
  List<String> compositions = ['High Carb', 'Moderate Carb', 'Low Carb'];
  int selected = 2; //attention

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      child: DefaultTabController(
          length: 3, // length of tabs
          initialIndex: 1,
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
                    height: 300, //height of TabBarView
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
                                  return Column(children: <Widget>[
                                    ExpansionTile(
                                        key: Key(index.toString()), //attention
                                        initiallyExpanded:
                                            index == selected, //attention

                                        title: Text('${compositions[index]}',
                                            style: TextStyle(
                                                color: Color(0xFF09216B),
                                                fontWeight: FontWeight.bold)),
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(25.0),
                                            child: Text(
                                                "display cutting ${widget.maintenanceCal - 500}"),
                                          )
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
                                        })),
                                  ]);
                                },
                              )
                            ]),
                          )),
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
                                return Column(children: <Widget>[
                                  ExpansionTile(
                                      key: Key(index.toString()), //attention
                                      initiallyExpanded:
                                          index == selected, //attention

                                      title: Text('${compositions[index]}',
                                          style: TextStyle(
                                              color: Color(0xFF09216B),
                                              fontWeight: FontWeight.bold)),
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(25.0),
                                          child: Text(
                                              "display Maintenance ${widget.maintenanceCal}"),
                                        )
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
                                      })),
                                ]);
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
                              key: Key(
                                  'builder ${selected.toString()}'), //attention

                              padding: EdgeInsets.only(
                                  left: 13.0, right: 13.0, bottom: 25.0),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Column(children: <Widget>[
                                  ExpansionTile(
                                      key: Key(index.toString()), //attention
                                      initiallyExpanded:
                                          index == selected, //attention

                                      title: Text('${compositions[index]}',
                                          style: TextStyle(
                                              color: Color(0xFF09216B),
                                              fontWeight: FontWeight.bold)),
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(25.0),
                                          child: Text(
                                              "display bulking ${widget.maintenanceCal + 500}"),
                                        )
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
                                      })),
                                ]);
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
