import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'randomNumberList.dart';

Random random = new Random();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Test 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var randomNumber = "";
  getRandomNumber() async {
    setState(() {
      randomNumber = random.nextInt(1000).toString();
    });
    // randomNumber = random.nextInt(1000).toString();
    print(randomNumber);
    await Firestore.instance.collection("randomNumbers").document().setData(
        {'number': randomNumber, 'timestamp': DateTime.now().toString()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: RaisedButton(
                  onPressed: () {
                    getRandomNumber();
                  },
                  child: Text("Generate Random Number"),
                  color: Colors.redAccent),
            ),
            Container(
              child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NumberList()),
                    );
                  },
                  child: Text("Fetch all Random Numbers"),
                  color: Colors.blueAccent),
            ),
            Container(
              child: Text("New generated random number is - $randomNumber",
                  style: TextStyle(fontSize: 25)),
            )
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
