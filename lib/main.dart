import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:readingbook/pages/auth/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      theme: ThemeData(
        primaryColor: Color.fromRGBO(44, 51, 59, 1),
        fontFamily: 'Poppins',
      ),
      home: SplashScreen(),
    );
  }
}
