import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';

import './pages/dashboard_page.dart';
import './pages/scanning_page.dart';
import './blocs/products_provider.dart';

void main() {
  //debugPaintSizeEnabled = true;
  //debugPaintBaselinesEnabled = true;
  //debugPaintPointersEnabled = true; // check for tapping
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ProductsProvider(
      child: MaterialApp(
        routes: {
          '/': (BuildContext context) => DashboardPage(),
          '/scanning': (BuildContext context) => ScanningPage()
        },
      ),
    );
  }
}
