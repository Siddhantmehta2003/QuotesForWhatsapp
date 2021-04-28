import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class HomePage extends StatefulWidget {
  var data;

  HomePage({@required this.data});
  @override
  _HomePageState createState() => _HomePageState(data);
}

class _HomePageState extends State<HomePage> {
  _HomePageState(this.data);
  var data;
  List<Widget> pages = [];
  bool isloading = true;

  getJsondata() {
    for (int i = 0; i < 5; i++) {
      pages.add(Image.network(data[i]["url"]));
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getJsondata();
  }

  @override
  Widget build(BuildContext context) {
    print(data);
    return Scaffold(
      backgroundColor: Color(0xffbdbdbd),
      body: isloading
          ? CircularProgressIndicator()
          : Builder(builder: (context) => LiquidSwipe(pages: pages)),
    );
  }
}
