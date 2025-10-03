import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
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

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));

    /* Navigator.push(
        context,
        (MaterialPageRoute(
            builder: (BuildContext context) => HomePage(
                  data: data,
                ))));*/

    /* Timer _timer = Timer(Duration(seconds: 5), () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(
                data: data,
              )));
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      body: Center(
        child: Text(
          "MIRAGE",
          style: TextStyle(color: Colors.red, fontSize: 40),
        ),
      ),
    );
  }
}
