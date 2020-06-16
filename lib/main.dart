import 'package:flutter/material.dart';
import 'package:mynewsapp/ui/Home.dart';

void main() {
  runApp(MaterialApp(
    title: 'News application Demo',
    theme: ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: Colors.green,
    ),
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}
