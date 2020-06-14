import 'package:flutter/material.dart';
import 'package:flutterfirebasecrud/ui/Home.dart';

void main() {
  runApp(MaterialApp(
    title: 'News application Demo',
    theme: ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}
