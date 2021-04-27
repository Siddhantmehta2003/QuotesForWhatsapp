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
  var data;
  getJsonData() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://meme-api.herokuapp.com/gimme/ProgrammerHumor/10"),
        headers: {"Accept": "application/json"});
    var convertDataToJson = json.decode(response.body);
    data = convertDataToJson['memes'];
    print(response.body);
  }

  @override
  void initState() {
    super.initState();

    //Currently simulating the background processes with a timer
    getJsonData();
    Timer _timer = Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage(data: data)));
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
