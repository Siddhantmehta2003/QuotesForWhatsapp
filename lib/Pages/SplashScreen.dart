import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mirage/Pages/homepage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    //Currently simulating the background processes with a timer
    //TODO: Add backgroud processes here
    Timer _timer = Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffbdbdbd),
      body: Center(
        child: Text(
          "MIRAGE",
          style: TextStyle(color: Colors.red, fontSize: 40),
        ),
      ),
    );
  }
}
