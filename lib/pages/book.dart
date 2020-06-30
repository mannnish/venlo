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
                    image: AssetImage(widget.details[2]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              Container(
                  width: w * 0.45,
                  padding: EdgeInsets.only(top: h * 0.04),
                  child: Text(
                    widget.details[0],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
              Container(
                  width: w * 0.35,
                  padding: EdgeInsets.only(top: h * 0.02),
                  child: Text(
                    widget.details[1],
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
                          Icons.bookmark,
                          color: Color.fromRGBO(44, 51, 59, 1),
                        ),
                      ),
                    ),
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
                    "+${widget.details[3]} more people Reading",
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
