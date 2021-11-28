import 'package:flutter/material.dart';
import 'package:readingbook/constants/colors.dart';
import 'package:readingbook/pages/auth/auth.repo.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: ColorConstant.primaryBG,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              Spacer(),
              Text(
                'venlo',
                style: TextStyle(color: ColorConstant.white, fontSize: 50),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  width: double.infinity,
                  child: Image(
                    image: AssetImage('assets/login/bg.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => AuthRepo.gsignin(context),
                child: Container(
                  width: double.infinity,
                  child: Image(
                    image: AssetImage('assets/login/googleBtn.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Divider(
                  thickness: 1,
                  height: 1,
                  color: ColorConstant.grey,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'By continuing you agree to',
                style: TextStyle(color: ColorConstant.grey, fontSize: 12),
              ),
              SizedBox(height: 2),
              Text(
                'Terms & Conditions - Privacy Policy',
                style: TextStyle(color: ColorConstant.white, fontSize: 14),
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
