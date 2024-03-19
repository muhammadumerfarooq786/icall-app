import 'package:icall/Components/BottomNavigationScreens/addcase.dart';
// import 'package:icall/Components/BottomNavigationScreens/heart.dart';
import 'package:icall/Components/BottomNavigationScreens/search.dart';
import 'package:flutter/material.dart';
import 'package:icall/Components/BottomNavigationScreens/userstats.dart';
import 'package:icall/Components/MapsComponent/map_home_screen.dart';
import 'package:icall/Components/TopNavigationBar/navigation.dart';
// import 'package:line_awesome_icons/line_awesome_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _children = [
    Navigation(),
    AddCase(),
    MapHomeScreen(),
    UserStats(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent.shade100,
        elevation: 0,
        iconSize: 32,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              // color: Colors.grey.shade400,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              // color: Colors.grey.shade400,
            ),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.route,
              // color: Colors.grey.shade400,
            ),
            label: "Safe Routes",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_chart_rounded,
            ),
            label: "Profile",
          ),
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}
