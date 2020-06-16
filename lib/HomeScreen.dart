import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mynewsapp/DetailsPage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription<QuerySnapshot> _streamSubscription;
  List<DocumentSnapshot> _documentSnapshot;
  CollectionReference _collectionReference =
      Firestore.instance.collection("Data");

  Color gradientStart = Colors.blue[800];
  Color gradientEnd = Colors.amber[200];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase crud'),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              debugPrint("search item tapped");
            },
            tooltip: 'Search item',
            splashColor: Colors.white,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              debugPrint("add item tapped");
            },
            tooltip: 'Add item',
            splashColor: Colors.blue,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text("Hello world"),
                accountEmail: Text("helloworld@test.com")),

            ListTile(
              title: Text("Home"),
              leading: Icon(
                Icons.home,
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text("About"),
              leading: Icon(
                Icons.info,
                color: Colors.green,
              ),
            ),

            //line separator
            Divider(
              height: 10.0,
              color: Colors.black,
            ),

            ListTile(
              title: Text("Close"),
              trailing: Icon(Icons.close),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      drawerScrimColor: Colors.green,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [gradientStart, gradientEnd],
                begin: const FractionalOffset(0.5, 0.0),
                end: const FractionalOffset(0.0, 0.5),
                stops: [0.0, 1.0])),
        child: ListView.builder(
          itemCount: _documentSnapshot.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: Card(
                elevation: 0.0,
                margin: EdgeInsets.all(10.0),
                color: Colors.transparent.withOpacity(0.1),

                //card container to contain circular text item name at position zero

                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        child: Text(
                          _documentSnapshot[index].data["title"][0],
                        ),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.black,
                      ),

                      //divider
                      SizedBox(
                        width: 8.0,
                      ),

                      //container for descriptions
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //event listener for title tapped
                            Text(
                              _documentSnapshot[index].data["title"],
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                              maxLines: 1,
                            ),

                            //spaces between two text
                            SizedBox(
                              height: 5.0,
                            ),

                            //text for displaying content
                            Text(
                              _documentSnapshot[index].data["content"],
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white70),
                              maxLines: 2,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              onTap: () {
                passDetails(_documentSnapshot[index]);

                //PASS data to details activity
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _streamSubscription = _collectionReference.snapshots().listen((event) {
      setState(() {
        _documentSnapshot = event.documents;
      });
    });
  }

  void passDetails(DocumentSnapshot snap) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailsPage(
              snapshot: snap,
            )));
  }
}
