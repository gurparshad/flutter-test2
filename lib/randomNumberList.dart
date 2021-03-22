import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NumberList extends StatefulWidget {
  @override
  _NumberList createState() => _NumberList();
}

class _NumberList extends State<NumberList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Random Numbers"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection("randomNumbers").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Text("loading data.. Please wait..");
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text('Loading...');
                default:
                  return new ListView(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 0,
                          color: Color(0x11ffffff),
                          child: new ListTile(
                            title: new Text(
                              document['number'],
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            subtitle: new Text(document['timestamp'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      );
                    }).toList(),
                  );
              }
            }));
  }
}
