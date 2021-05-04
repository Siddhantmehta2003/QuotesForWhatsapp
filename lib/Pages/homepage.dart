import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    appBar:
    AppBar(
      title: Text('Esys Share Plugin Sample'),
    );
    body:
    Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            MaterialButton(
              child: Text('Share text'),
              onPressed: () async => await _shareText(),
            ),
            MaterialButton(
              child: Text('Share image'),
              onPressed: () async => await _shareImage(),
            ),
            MaterialButton(
              child: Text('Share images'),
              onPressed: () async => await _shareImages(),
            ),
            MaterialButton(
              child: Text('Share CSV'),
              onPressed: () async => await _shareCSV(),
            ),
            MaterialButton(
              child: Text('Share mixed'),
              onPressed: () async => await _shareMixed(),
            ),
            MaterialButton(
              child: Text('Share image from url'),
              onPressed: () async => await _shareImageFromUrl(),
            ),
          ],
        ));
  }

  Future<void> _shareText() async {
    try {
      Share.text('my text title',
          'This is my text to share with other applications.', 'text/plain');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> _shareImage() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/image1.png');
      await Share.file(
          'esys image', 'esys.png', bytes.buffer.asUint8List(), 'image/png',
          text: 'My optional text.');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> _shareImages() async {
    try {
      final ByteData bytes1 = await rootBundle.load('assets/image1.png');
      final ByteData bytes2 = await rootBundle.load('assets/image2.png');

      await Share.files(
          'esys images',
          {
            'esys.png': bytes1.buffer.asUint8List(),
            'bluedan.png': bytes2.buffer.asUint8List(),
          },
          'image/png');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> _shareCSV() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/addresses.csv');
      await Share.file(
          'addresses', 'addresses.csv', bytes.buffer.asUint8List(), 'text/csv');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> _shareMixed() async {
    try {
      final ByteData bytes1 = await rootBundle.load('assets/image1.png');
      final ByteData bytes2 = await rootBundle.load('assets/image2.png');
      final ByteData bytes3 = await rootBundle.load('assets/addresses.csv');

      await Share.files(
          'esys images',
          {
            'esys.png': bytes1.buffer.asUint8List(),
            'bluedan.png': bytes2.buffer.asUint8List(),
            'addresses.csv': bytes3.buffer.asUint8List(),
          },
          '*/*',
          text: 'My optional text.');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> _shareImageFromUrl() async {
    try {
      var request = await HttpClient().getUrl(Uri.parse(
          'https://shop.esys.eu/media/image/6f/8f/af/amlog_transport-berwachung.jpg'));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg');
    } catch (e) {
      print('error: $e');
    }
  }
}
