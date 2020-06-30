import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double w, h;

  String title;
  String author;
  String imgurl;
  String ppl_count;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    title = "Enchantment : The art of changing Hearts";
    author = "Guy Kawasaki";
    imgurl = 'images/bookCover/guy.jpg';
    ppl_count = "69";

    return Scaffold(
      appBar: AppBar(
        title: Text('Read'),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(44, 51, 59, 1),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: h * 0.05),
                width: w * 0.45,
                height: (w * 0.45) * 1.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imgurl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              Container(
                  width: w * 0.45,
                  padding: EdgeInsets.only(top: h * 0.04),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
              Container(
                  width: w * 0.35,
                  padding: EdgeInsets.only(top: h * 0.02),
                  child: Text(
                    author,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  )),
              Container(
                padding: EdgeInsets.only(top: h * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        print("read");
                      },
                      splashColor: Colors.transparent,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.library_books,
                          color: Color.fromRGBO(44, 51, 59, 1),
                        ),
                      ),
                    ),
                    Text('Continue Reading',style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
              Container(
                width: w * 0.5,
                padding: EdgeInsets.only(top: h * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/ppl_user64.jpg'),
                      radius: w * 0.05,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('images/ppl_user37.jpg'),
                      radius: w * 0.05,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('images/ppl_user60.jpg'),
                      radius: w * 0.05,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('images/ppl_user48.jpg'),
                      radius: w * 0.05,
                    ),
                  ],
                ),
              ),
              Container(
                  width: w * 0.8,
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "+$ppl_count more people Reading",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
