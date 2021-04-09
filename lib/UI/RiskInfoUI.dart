import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:health_se/Controller/UserInfoController.dart';
import 'package:health_se/Entity/InfectiousDisease.dart';
import 'package:health_se/UI/FilterUI.dart';

void main() => runApp(RiskInfoUI());

class RiskInfoUI extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Risk information"),
          leading: FlatButton.icon(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FilterUI()));
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: 20,
            ),
            label: Text(""),
            textColor: Colors.white,
          ),
          // Icon(
          //   Icons.arrow_back_ios_rounded,
          // ),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton(
                itemBuilder: (BuildContext bc) => [
                      PopupMenuItem(
                          child: Text("Change password"), value: "/cp"),
                      PopupMenuItem(
                          child: Text("Notification management"),
                          value: "/notif"),
                      PopupMenuItem(child: Text("Log Out"), value: "/log-out"),
                    ],
                onSelected: (String route) {
                  if (route == "/cp") {}
                  if (route == "/notif") {}
                  if (route == "/log-out") {}
                  // Note You must create respective pages for navigation
                  Navigator.pushNamed(context, route);
                })
          ],
        ),
        body: Container(
          child: riskReport(),
        ),
      ),
    );
  }
}

class riskReport extends StatefulWidget {
  riskReport({Key key, this.loadList}) : super(key: key);
  final loadList;
  @override
  _riskReportState createState() => _riskReportState();
}

class _riskReportState extends State<riskReport> {
  Widget w;

  @override
  void initState() {
    super.initState();
    if (widget.loadList == true)
      w = riskList();
    else
      w = noRisk();
  }

  @override
  Widget build(BuildContext context) {
    List<InfectiousDisease> infectiousDiseases =
        UserInfoController.infectiousDiseases;
    print("test");
    print(infectiousDiseases.length);
    return Scaffold(body: w);
  }
}

class noRisk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 100, child: Text("No location selected yet!"));
  }
}

class riskList extends StatefulWidget {
  @override
  _riskListState createState() => _riskListState();
}

class _riskListState extends State<riskList> {
  List<InfectiousDisease> infectiousDiseases =
      UserInfoController.infectiousDiseases;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: infectiousDiseases.length,
        itemBuilder: (_, int position) {
          final item = infectiousDiseases[position];
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
                      //Text("Suggestions: " + item.getSuggestions()[0] + '\n'),
                      Text("Prevention Measures: " +
                          item.getMeasures()[0] +
                          '\n'),
                      Text("Risk level: " + item.getRisk()),
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
