import 'package:flutter/material.dart';
import 'package:readingbook/constants/colors.dart';
import 'package:readingbook/constants/string.dart';
import 'package:readingbook/pages/root_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    startup();
  }

  startup() async {
    await Future.delayed(Duration(milliseconds: 300));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(StringConstants.token);
    if (token != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RootPage()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: ColorConstant.primaryBG);
  }
}
