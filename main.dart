import 'package:flutter/material.dart';
import 'package:icall/home.dart';
import 'package:icall/services/shared_service.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'splashscreen.dart';

Widget _defaultHome = SplashScreen();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = HomePage();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Icall -  Realtime Incident Reporting Application',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _defaultHome,
    );
  }
}
