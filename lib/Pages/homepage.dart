import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  var data;

  HomePage({@required this.data});
  @override
  _HomePageState createState() => _HomePageState(data);
}

class _HomePageState extends State<HomePage> {
  var data;
  _HomePageState(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffbdbdbd),
      body: Center(
        child: Image.network(data[0]["url"]),
      ),
    );
  }
}
