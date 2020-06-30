import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readingbook/rootPage.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RootPage(),
      theme: ThemeData(
          primaryColor: Color.fromRGBO(44, 51, 59, 1), fontFamily: 'Poppins'),
    );
  }
}
