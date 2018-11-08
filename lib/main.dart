import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';

import 'package:sanne/pages/dashboard_page.dart';
import 'package:sanne/pages/scanning_page.dart';

void main() {
  //debugPaintSizeEnabled = true;
  //debugPaintBaselinesEnabled = true;
  //debugPaintPointersEnabled = true; // check for tapping
  runApp(new MyApp());
} 

class MyApp extends StatefulWidget{
  @override
    State<StatefulWidget> createState() {
      return _MyAppState();
    }  
}

class _MyAppState extends State<MyApp> {
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        routes: {
          '/': (BuildContext context) => DashboardPage(),
          '/scanning': (BuildContext context) => ScanningPage()
        },
      );
    }
}