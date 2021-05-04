import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

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
      pages.add(Column(
        children: [
          Image.network(data[i]["url"]),
          MaterialButton(
            child: Text('Share'),
            onPressed: () async => await _shareImageFromUrl(data[i]["url"]),
          ),
        ],
      ));
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

  Future<void> _shareImageFromUrl(String url) async {
    try {
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg');
    } catch (e) {
      print('error: $e');
    }
  }
}
