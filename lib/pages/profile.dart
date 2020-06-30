import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double w, h;
  double leftpadding;

  _ProfileState(){
    leftpadding = 0.15;
  }

  Widget detTemplate(String title, String ans){
    return Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: w*leftpadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(color: Colors.white),),
                Text(ans, style: TextStyle(color: Colors.grey),)
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(44, 51, 59, 1),
      body: Column(
        children: [
          Center(
            child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: w * leftpadding, vertical: h * 0.05),
              height: h * 0.2,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: Colors.yellow,
                image: DecorationImage(
                    image: AssetImage('images/profileDP.jpeg'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: w * leftpadding),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Lily Doe",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  "Minnesota, US",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                Text(
                  "lilydoe@gnb.com",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: w*leftpadding, right: w*leftpadding, top : h*0.05),
              child: Divider(
                height: 1,
                color: Colors.grey,
              ),
            ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: w*leftpadding, vertical: h*0.02),
            child: Text('Details', style: TextStyle(fontSize: 25, color: Colors.white),),
          ),
          detTemplate('Books Read', '15'),
          detTemplate('Books Reviewed', '9'),
          detTemplate('Liked', '6'),
        ],
      ),
    );
  }
}
