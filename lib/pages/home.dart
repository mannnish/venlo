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
  String pplCount;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    title = "Enchantment : The art of changing Hearts";
    author = "Guy Kawasaki";
    imgurl = 'images/bookCover/guy.jpg';
    pplCount = "69";

    return Scaffold(
      appBar: AppBar(
        title: Text('Read'),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(44, 51, 59, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Expanded(
            flex: 4,
            child: AspectRatio(
              aspectRatio: 0.64,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imgurl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: w * 0.45,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Container(
                      width: w * 0.35,
                      padding: EdgeInsets.only(top: h * 0.02),
                      child: Text(
                        "By $author",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("read");
                        },
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
                      Text(
                        'Continue Reading',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('images/ppl_user64.jpg'),
                            radius: w * 0.05,
                          ),
                          SizedBox(width: 8),
                          CircleAvatar(
                            backgroundImage: AssetImage('images/ppl_user37.jpg'),
                            radius: w * 0.05,
                          ),
                          SizedBox(width: 8),
                          CircleAvatar(
                            backgroundImage: AssetImage('images/ppl_user60.jpg'),
                            radius: w * 0.05,
                          ),
                          SizedBox(width: 8),
                          CircleAvatar(
                            backgroundImage: AssetImage('images/ppl_user48.jpg'),
                            radius: w * 0.05,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "+$pplCount more people Reading",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
