import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {
  DocumentSnapshot snapshot;

  DetailsPage({this.snapshot});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: Colors.green,
      ),
      body: Card(
        elevation: 0.0,
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Text(
                      widget.snapshot.data["title"][0],
                      style: TextStyle(fontSize: 20.0),
                    ),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    widget.snapshot.data["content"][0],
                    style: TextStyle(fontSize: 20.0, color: Colors.red),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
