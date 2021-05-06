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
        // height: MediaQuery.of(context).size.height - 20,// HELLOOOOOOOOOOOOOOOOOOO

        width: MediaQuery.of(context).size.width,
        color: ranc[rng.nextInt(6)],
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(data[i]["url"]),
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
        ),
      ));
    }
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
          : RefreshIndicator(
              onRefresh: _pullRefresh,
              // child: ListView(),
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      color: ranc[rng.nextInt(6)],
                      height: MediaQuery.of(context).size.height - 30,
                      child: Builder(
                          builder: (context) => LiquidSwipe(
                                pages: pages,
                                onPageChangeCallback: (activePageIndex) {
                                  if (activePageIndex == 4) {
//idhar pe toast ka code daalmere ko nahi pata
                                    Fluttertoast.showToast(
                                        msg:
                                            'Refresh karne ke liye pull karte hai gadhe', //vysor daal
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        // timeInSecForIos: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.yellow);
                                  }
                                },
                              )),
                    ),
                  ),
                ],
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
