import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var rng = new Random();
  List<Color> ranc = [
    Colors.red,
    Colors.blueAccent,
    Colors.black,
    Colors.pink,
    Colors.lightGreen,
    Colors.blue,
    Colors.teal
  ];
  List<Widget> pages = [];
  bool isloading = true;
  var data;
  getJsonData() async {
    setState(() {
      isloading = true;
    });
    var response = await http.get(
        Uri.encodeFull("https://meme-api.herokuapp.com/gimme/QuotesPorn/5"),
        headers: {"Accept": "application/json"});

    setState(() {
      var convertDataToJson = json.decode(response.body);

      data = convertDataToJson['memes'];
    });
    convertJsondata();
  }

  convertJsondata() {
    pages = [];
    for (int i = 0; i < 5; i++) {
      pages.add(Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        height: double.infinity,
        color: ranc[rng.nextInt(6)],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInImage(
                // fit: BoxFit.scaleDown,
                placeholder: NetworkImage(
                    "https://via.placeholder.com/500x500.png?text=Internet+seems+slow"),
                image: NetworkImage((data[i]["url"]))),
            MaterialButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, //
                children: [
                  Text(
                    'Share',
                    style: TextStyle(color: Colors.yellow, fontSize: 30),
                  ),
                  Icon(Icons.send)
                ],
              ),
              onPressed: () async => await _shareImageFromUrl(data[i]["url"]),
            ),
          ],
        ),
      ));
    }
    pages.add(Text("Refreshing"));
    setState(() {
      isloading = false;
    });
  }

  Future<void> _pullRefresh() async {
    getJsonData();
  }

  @override
  void initState() {
    super.initState();
    getJsonData();
  }

  @override
  Widget build(BuildContext context) {
    print(data);
    return Scaffold(
      backgroundColor: Color(0xffbdbdbd),
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : Builder(
              builder: (context) => LiquidSwipe(
                pages: pages,
                enableLoop: false,
                onPageChangeCallback: (activePageIndex) {
                  if (activePageIndex == 5) {
                    _pullRefresh();
                  }
                },
              ),
            ),
    );
  }

  Future<void> _shareImageFromUrl(String url) async {
    try {
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('Quotes', 'quotes.jpg', bytes, 'image/jpg');
    } catch (e) {
      print('error: $e');
    }
  }
}
