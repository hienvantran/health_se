import 'dart:ui';

import 'package:flutter/material.dart';
import '/UI/PageOne.dart';
import '/UI/PageTwo.dart';
import '/UI/HealthProfileUI.dart';
import '/UI/UserProfileUI.dart';
import '/UI/InfectiousUI.dart';
import '/UI/DailyDietUI.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.lightGreen,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserProfileUI user_profile;
  InfectiousUI infectious_page;
  DailyDietUI daily_diet;
  HealthProfileUI health_profile;

  List<Widget> pages;
  List<String> titles;
  Widget currentPage;
  int currentTab = 0;

  @override
  void initState() {
    user_profile = UserProfileUI(nameHolder: "Aks");
    health_profile = HealthProfileUI();
    infectious_page = InfectiousUI();
    daily_diet = DailyDietUI();
    pages = [health_profile, daily_diet, infectious_page, user_profile];
    titles = [
      'Health Profile',
      'Daily Diet',
      'Infectious Diseases',
      'User Profile'
    ];
    currentPage = health_profile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentTab]),
        leading: Icon(
          Icons.arrow_back_ios_rounded,
        ),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
              itemBuilder: (BuildContext bc) => [
                    PopupMenuItem(child: Text("Change password"), value: "/cp"),
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
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTab,
        onTap: (int index) {
          setState(() {
            currentTab = index;
            currentPage = pages[index];
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: "Health profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu_rounded),
            label: "Daily diet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.coronavirus_outlined),
            label: "Infectious",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: "User Profile",
          ),
        ],
      ),
    );
  }
}
