import 'package:flutter/material.dart';
import 'RiskInfoUI.dart';
import 'mainUI.dart';

void main() => runApp(FilterUI());
enum SingingCharacter {
  three,
  five,
  ten,
  islandwide,
  fivedays,
  week,
  month,
  threemonth,
  covid,
  dengue,
  zika
}

class FilterUI extends StatefulWidget {
  @override
  _FilterUIState createState() => _FilterUIState();
}

class _FilterUIState extends State<FilterUI> {
  var _distance = SingingCharacter.three;
  var _time = SingingCharacter.fivedays;
  var _disease = SingingCharacter.covid;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
      builder: (context) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(
            leading: FlatButton.icon(
              onPressed: () {
                //TODO change the page navigated to on Back button click
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                size: 20,
              ),
              label: Text(""),
              textColor: Colors.white,
            ),
            title: const Text('Filter Cases'),
            centerTitle: true,
            backgroundColor: Colors.green,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                SizedBox(height: 6.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      left: BorderSide(
                        color: Colors.white,
                        width: 20,
                      ),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Filter by distance',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                RadioListTile<SingingCharacter>(
                  dense: true,
                  title: const Text('3 km'),
                  value: SingingCharacter.three,
                  groupValue: _distance,
                  onChanged: (SingingCharacter value) {
                    setState(() {
                      _distance = value;
                    });
                  },
                ),
                RadioListTile<SingingCharacter>(
                  dense: true,
                  title: const Text('5 km'),
                  value: SingingCharacter.five,
                  groupValue: _distance,
                  onChanged: (value) {
                    setState(() {
                      _distance = value;
                    });
                  },
                ),
                RadioListTile<SingingCharacter>(
                  dense: true,
                  title: const Text('10 km'),
                  value: SingingCharacter.ten,
                  groupValue: _distance,
                  onChanged: (value) {
                    setState(() {
                      _distance = value;
                    });
                  },
                ),
                RadioListTile<SingingCharacter>(
                  dense: true,
                  title: const Text('Island-wide'),
                  value: SingingCharacter.islandwide,
                  groupValue: _distance,
                  onChanged: (value) {
                    setState(() {
                      _distance = value;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      left: BorderSide(
                        color: Colors.white,
                        width: 20,
                      ),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Filter by time',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                RadioListTile<SingingCharacter>(
                  dense: true,
                  title: const Text('Five days'),
                  value: SingingCharacter.fivedays,
                  groupValue: _time,
                  onChanged: (value) {
                    setState(() {
                      _time = value;
                    });
                  },
                ),
                RadioListTile<SingingCharacter>(
                  dense: true,
                  title: const Text('Week'),
                  value: SingingCharacter.week,
                  groupValue: _time,
                  onChanged: (value) {
                    setState(() {
                      _time = value;
                    });
                  },
                ),
                RadioListTile<SingingCharacter>(
                  dense: true,
                  title: const Text('Month'),
                  value: SingingCharacter.month,
                  groupValue: _time,
                  onChanged: (value) {
                    setState(() {
                      _time = value;
                    });
                  },
                ),
                RadioListTile<SingingCharacter>(
                  dense: true,
                  title: const Text('Three month'),
                  value: SingingCharacter.threemonth,
                  groupValue: _time,
                  onChanged: (value) {
                    setState(() {
                      _time = value;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      left: BorderSide(
                        color: Colors.white,
                        width: 20,
                      ),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Filter by disease',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                RadioListTile<SingingCharacter>(
                  dense: true,
                  title: const Text('COVID-19'),
                  value: SingingCharacter.covid,
                  groupValue: _disease,
                  onChanged: (value) {
                    setState(() {
                      _disease = value;
                    });
                  },
                ),
                RadioListTile<SingingCharacter>(
                  dense: true,
                  title: const Text('Dengue'),
                  value: SingingCharacter.dengue,
                  groupValue: _disease,
                  onChanged: (value) {
                    setState(() {
                      _disease = value;
                    });
                  },
                ),
                RadioListTile<SingingCharacter>(
                  dense: true,
                  title: const Text('Zika'),
                  value: SingingCharacter.zika,
                  groupValue: _disease,
                  onChanged: (value) {
                    setState(() {
                      _disease = value;
                    });
                  },
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[800], // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RiskInfoUI()));
                    },
                    child: Text('Apply filters',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
