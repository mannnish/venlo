import 'package:flutter/material.dart';
import 'categoryType.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  double w, h;
  String _text = "";
  int selectedTab;
  double leftpadding = 0.075;

  List ecobookDetails = [
    ["Da Vinci Code", "Dan Brown", 'images/bookCover/vincicode.jpg', "527"],
    ["All this has", "Monica Sabolo", 'images/bookCover/allthishas.jpg', "36"],
    ["Ikigai", "Hector & Francsec", 'images/bookCover/ikigai.jpg', "56"],
    [
      "The Subtle Art of not giving a F*ck",
      "Mark Manson",
      'images/bookCover/subtleart.jpg',
      "97"
    ],
    ["Enchantm-", "Guy Kawasaki", 'images/bookCover/guy.jpg', "527"],
    [
      "The Color Purple",
      "Alice Walker",
      'images/bookCover/thecolorpurple.jpg',
      "36"
    ],
    ["Da Vinci Code", "Dan Brown", 'images/bookCover/vincicode.jpg', "527"],
    ["All this has", "Monica Sabolo", 'images/bookCover/allthishas.jpg', "36"],
    ["Ikigai", "Hector & Francsec", 'images/bookCover/ikigai.jpg', "56"],
  ];

  List artbookDetails = [
    [
      "The Subtle Art of not giving a F*ck",
      "Mark Manson",
      'images/bookCover/subtleart.jpg',
      "97"
    ],
    ["Enchantm-", "Guy Kawasaki", 'images/bookCover/guy.jpg', "527"],
    [
      "The Color Purple",
      "Alice Walker",
      'images/bookCover/thecolorpurple.jpg',
      "36"
    ],
    ["Da Vinci Code", "Dan Brown", 'images/bookCover/vincicode.jpg', "527"],
    ["All this has", "Monica Sabolo", 'images/bookCover/allthishas.jpg', "36"],
    ["Ikigai", "Hector & Francsec", 'images/bookCover/ikigai.jpg', "56"],
    [
      "The Subtle Art of not giving a F*ck",
      "Mark Manson",
      'images/bookCover/subtleart.jpg',
      "97"
    ],
    ["Enchant..", "Guy Kawasaki", 'images/bookCover/guy.jpg', "527"],
    [
      "The Color Purple",
      "Alice Walker",
      'images/bookCover/thecolorpurple.jpg',
      "36"
    ],
  ];
  _ExploreState() {
    selectedTab = 1;
  }

  Widget tabs(String name, int index) {
    return InkWell(
        splashColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            border: index != selectedTab
                ? Border(
                    bottom: BorderSide(
                        width: 2, color: Color.fromRGBO(44, 51, 59, 1)),
                  )
                : Border(
                    bottom: BorderSide(
                        width: 2, color: Color.fromRGBO(167, 117, 139, 1)),
                  ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            name,
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(44, 51, 59, 1),
      body: Column(
        children: <Widget>[
          //Custom Search Widget --------------------
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Color.fromRGBO(52, 55, 62, 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 5),
              width: w * (1 - (2 * leftpadding)),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: _text == "" ? " Search..." : _text,
                  hintStyle: TextStyle(color: Colors.white54),
                ),
                onChanged: (val) {
                  setState(() {
                    _text = val;
                  });
                },
              ),
            ),
          ),
          //Custom Tab Controller --------------------
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(top: 20, left: w * leftpadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                tabs("Economics", 1),
                tabs("Military", 2),
                tabs("Art", 3),
                tabs("Movement", 4),
                tabs("Design", 5),
                tabs("Science", 6),
                tabs("Biography", 7),
                tabs("Comics", 8)
              ],
            ),
          ),
          // Category Wise Books Diplay Area -----------
          selectedTab == 1
              ? CategoryType(details: ecobookDetails)
              : selectedTab == 2
                  ? CategoryType(details: ecobookDetails)
                  : selectedTab == 3
                      ? CategoryType(details: artbookDetails)
                      : selectedTab == 4
                          ? CategoryType(details: artbookDetails)
                          : selectedTab == 5
                              ? CategoryType(details: ecobookDetails)
                              : selectedTab == 6
                                  ? CategoryType(details: ecobookDetails)
                                  : selectedTab == 7
                                      ? CategoryType(details: artbookDetails)
                                      : selectedTab == 8
                                          ? CategoryType(
                                              details: artbookDetails)
                                          : null,
        ],
      ),
    );
  }
}
