import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_se/UI/FilteredMapUI.dart';
import 'package:health_se/UI/mainUI.dart';

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
  String prefix = "Current Date: ";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        prefix = "Selected Date: ";
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
        appBar: AppBar(
          title: const Text('Filter Cases'),
          centerTitle: true,
          backgroundColor: Color(0xFF479055),
          leading: FlatButton.icon(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyApp(tab: 2)));
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: 20,
            ),
            label: Text(""),
            textColor: Colors.white,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Card(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 26),
                            child: Text(
                              'Filter by distance (in km)',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Slider(
                        value: _currentSliderValue,
                        min: 3,
                        max: 30,
                        divisions: 10,
                        activeColor: Color(0xFF479055),
                        inactiveColor: Color(0xFF479055),
                        label: _currentSliderValue.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _currentSliderValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 35.0),
                            child: Text(
                              'Filter by time',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text('$prefix ${selectedDate.toString()}',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: RaisedButton(
                          onPressed: () => _selectDate(context),
                          color: Color(0xFF479055),
                          child: Text(
                            'Click here to enter date',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border(
                          //   left: BorderSide(
                          //     color: Colors.white,
                          //     width: 20,
                          //   ),
                          // ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              'Filter by disease',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DropdownButton<String>(
                        value: diseases,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
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
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF479055), // background
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FilteredMapUI(
                                    data: data,
                                  )));
                    },
                    label: Text(
                      'Apply filters',
                    ),
                    icon: Icon(Icons.filter_alt_rounded)),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
