import 'package:flutter/material.dart';
import 'package:icall/home.dart';
import 'package:icall/services/shared_service.dart';
import 'package:lottie/lottie.dart';

import 'Components/BordingComponent/onbording.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //set time to load the new page
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Onbording()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 300,
                width: 300,
                child: Lottie.asset('assets/splashback.json')),
            SizedBox(height: 20),
            Text(
              "Crime Alert",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(143, 148, 251, 1)),
            ),
            SizedBox(height: 10),
            Text(
              "Public Awareness Platform.",
              style:
                  TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }
}
