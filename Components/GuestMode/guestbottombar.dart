import 'package:icall/Components/BottomNavigationScreens/addcase.dart';
import 'package:flutter/material.dart';
import 'package:icall/Components/GuestMode/gusethomepage.dart';
import 'package:icall/Components/MapsComponent/map_home_screen.dart';

class GuestBottomBar extends StatefulWidget {
  @override
  _GuestBottomBarState createState() => _GuestBottomBarState();
}

class _GuestBottomBarState extends State<GuestBottomBar> {
  int _currentIndex = 0;
  List<Widget> _children = [
    GuestHomePage(),
    MapHomeScreen(),
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
              Icons.route,
              // color: Colors.grey.shade400,
            ),
            label: "Safe Routes",
          ),
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}
