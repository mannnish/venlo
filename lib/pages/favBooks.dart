import 'package:flutter/material.dart';
import 'package:readingbook/pages/book.dart';

class FavBook extends StatefulWidget {
  @override
  _FavBookState createState() => _FavBookState();
}

class _FavBookState extends State<FavBook> {
  double w, h;
  double leftpadding;

  List favBookMatrix;

  _FavBookState() {
    leftpadding = 0.075;
    favBookMatrix = [
      ["Ikigai", "Hector & Francsec", 'images/bookCover/ikigai.jpg', "56"],
      ["The Subtle Art of not giving a F*ck", "Mark Manson", 'images/bookCover/subtleart.jpg', "97"],
      ["Da Vinci Code", "Dan Brown", 'images/bookCover/vincicode.jpg', "527"],
      ["All this has", "Monica Sabolo", 'images/bookCover/allthishas.jpg', "36"],
    ];
  }

  Widget singleBookShowcase(int index) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Book(
                        details: favBookMatrix[index],
                      )));
        },
        child: Container(
          width: w * 0.30,
          height: (w * 0.30) * 1.5,
          decoration: BoxDecoration(
            // color: Colors.white,
            image: DecorationImage(
              image: AssetImage(favBookMatrix[index][2]),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      Container(
          width: w * 0.25,
          padding: EdgeInsets.only(top: 10),
          child: Text(
            favBookMatrix[index][0],
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 13),
          )),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite'),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(44, 51, 59, 1),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: w * 0.65,
              padding: EdgeInsets.only(top: h * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' Liked Books',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    'view all   >',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: w * 0.65,
                padding: EdgeInsets.only(top: h * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    singleBookShowcase(0),
                    singleBookShowcase(1),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                width: w * 0.65,
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    singleBookShowcase(2),
                    singleBookShowcase(3),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                width: w * 0.65,
                padding: EdgeInsets.only(top: h * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    singleBookShowcase(0),
                    singleBookShowcase(1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
