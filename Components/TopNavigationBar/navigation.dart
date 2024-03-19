import 'package:flutter/material.dart';
import 'package:icall/Components/TopNavigationBar/HomeScreen.dart';
import 'package:icall/Components/TopNavigationBar/NewsScreen.dart';
import 'package:icall/Components/TopNavigationBar/ProfileScreen.dart';
import 'package:icall/services/shared_service.dart';

class Navigation extends StatefulWidget {
  Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation>
    with SingleTickerProviderStateMixin {
  // ! Declaration variable
  var index = 0;
  var color = Colors.blueAccent.shade100;
  late TabController myControler;
  var like = Colors.black;
  var like2 = Colors.black;
  var likeComent = Colors.black;
  var likenumber = 45;
  var likenumber2 = 117;
  var likeGroups = 22;
  late var size, width, height;

  @override
  void initState() {
    myControler = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(120.0), // here the desired height
          child: Container(
            padding: EdgeInsets.only(top: 10),
            width: width,
            child: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    SharedService.logout(context);
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
              bottom: TabBar(
                controller: myControler,
                //isScrollable: true,
                labelColor: Colors.blue,
                onTap: (i) {
                  setState(() {
                    index = i;
                  });

                  print(i);
                },
                tabs: [
                  Tab(
                      icon: index == 0
                          ? Icon(
                              Icons.home_outlined,
                              color: color,
                            )
                          : Icon(
                              Icons.home_outlined,
                              color: Colors.black,
                            )),
                  Tab(
                      icon: index == 1
                          ? Icon(
                              Icons.newspaper_outlined,
                              color: color,
                            )
                          : Icon(
                              Icons.newspaper_outlined,
                              color: Colors.black,
                            )),
                  Tab(
                      icon: index == 2
                          ? Icon(
                              Icons.person_outline,
                              color: color,
                            )
                          : Icon(
                              Icons.person_outline,
                              color: Colors.black,
                            )),
                ],
              ),
              title: Text(
                "Crime Alert - Public Awareness",
                style: TextStyle(
                  color: Colors.blue[300],
                  fontSize: 18,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
          )),
      body: Container(
        child: TabBarView(controller: myControler, children: [
          HomeScreen(),
          NewsScreen(),
          ProfileScreen(),
        ]),
      ),
    );
  }
}
