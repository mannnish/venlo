import 'package:flutter/material.dart';

class Book extends StatefulWidget {
  List details;
  Book({this.details});
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  double w, h;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
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
                    image: AssetImage(widget.details[2]),
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
                        widget.details[0],
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Container(
                      width: w * 0.35,
                      padding: EdgeInsets.only(top: h * 0.02),
                      child: Text(
                        "By ${widget.details[1]}",
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
                            Icons.bookmark,
                            color: Color.fromRGBO(44, 51, 59, 1),
                          ),
                        ),
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
                        "+${widget.details[3]} more people Reading",
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
