import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'FilteredMapUI.dart';
import 'RiskInfoUI.dart';
import 'mainUI.dart';

void main() => runApp(FilterUI());

class FilterUI extends StatefulWidget {
  FilterUI({Key key, this.latitude, this.longitude}) : super(key: key);

  final latitude;
  final longitude;

  @override
  _FilterUIState createState() => _FilterUIState();
}

class Data {
  double distance;
  String disease;
  String dateTime;
  String longitude;
  String latitude;

  Data(
      {this.distance,
      this.disease,
      this.dateTime,
      this.longitude,
      this.latitude});
}

class _FilterUIState extends State<FilterUI> {
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        selectedDate = pickedDate;
      });
  }

  double _currentSliderValue = 20;
  String diseases = 'Dengue';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
      builder: (context) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(
            title: const Text('Filter Cases'),
            centerTitle: true,
            backgroundColor: Colors.green,
            leading: FlatButton.icon(
              onPressed: () {
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
                      'Filter by distance (in km)',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: 30,
                  divisions: 5,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Filter by time',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text('Current Date and Time: ${selectedDate.toString()}',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                RaisedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Click here to enter date'),
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
                DropdownButton<String>(
                  value: diseases,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      diseases = newValue;
                    });
                  },
                  items: <String>['Dengue', 'Zika']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                // DropdownButton<String>(
                //     items: <String>['Dengue', 'Zika'].map((String diseases) {
                //       return new DropdownMenuItem<String>(
                //         value: diseases,
                //         child: new Text(diseases),
                //       );
                //     }).toList(),
                //     onChanged: (String? value) {
                //       setState(() {
                //         diseases = value;
                //       });
                //     }),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[800], // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    final data = Data(
                      distance: _currentSliderValue,
                      dateTime: selectedDate.toIso8601String(),
                      disease: diseases.toString(),
                      latitude: widget.latitude.toString(),
                      longitude: widget.longitude.toString(),
                    );
                    print(_currentSliderValue);
                    print(selectedDate.toIso8601String());
                    print(diseases.toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FilteredMapUI(
                                  data: data,
                                )));
                  },
                  child: Text(
                    'Apply filters',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
