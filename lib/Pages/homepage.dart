import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffbdbdbd),
      body: Center(
        child: Text(
          "Homepage",
          style: TextStyle(color: Colors.red, fontSize: 40),
        ),
      ),
    );
  }
}
