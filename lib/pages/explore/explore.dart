import 'package:flutter/material.dart';
import 'package:readingbook/constants/colors.dart';
import 'package:readingbook/constants/textstyles.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  double w, h;
  // String _text = "";
  int selectedTab;
  double leftpadding = 0.075;

  List ecobookDetails = [
    // BookModel(
    //   author: 'Hector',
    //   createdAt: '',
    //   ownerId: '4c34f',
    //   ownerName: 'Manish',
    //   ownerPhone: '9958774243',
    //   photoUrl: 'https://avatars1.githubusercontent.com/u/60895972?s=460&v=4',
    //   publication: 'Quantam Publication Ltd.',
    //   sold: false,
    //   title: 'Web Tech Quantam',
    //   views: 12,
    // ),
    // ["Da Vinci Code", "Dan Brown", 'images/bookCover/vincicode.jpg', "527"],
    // ["All this has", "Monica Sabolo", 'images/bookCover/allthishas.jpg', "36"],
    // ["Ikigai", "Hector & Francsec", 'images/bookCover/ikigai.jpg', "56"],
    // [
    //   "The Subtle Art of not giving a F*ck",
    //   "Mark Manson",
    //   'images/bookCover/subtleart.jpg',
    //   "97"
    // ],
    // ["Enchantm-", "Guy Kawasaki", 'images/bookCover/guy.jpg', "527"],
    // [
    //   "The Color Purple",
    //   "Alice Walker",
    //   'images/bookCover/thecolorpurple.jpg',
    //   "36"
    // ],
    // ["Da Vinci Code", "Dan Brown", 'images/bookCover/vincicode.jpg', "527"],
    // ["All this has", "Monica Sabolo", 'images/bookCover/allthishas.jpg', "36"],
    // ["Ikigai", "Hector & Francsec", 'images/bookCover/ikigai.jpg', "56"],
  ];

  List artbookDetails = [
    // [
    //   "The Subtle Art of not giving a F*ck",
    //   "Mark Manson",
    //   'images/bookCover/subtleart.jpg',
    //   "97"
    // ],
    // ["Enchantm-", "Guy Kawasaki", 'images/bookCover/guy.jpg', "527"],
    // [
    //   "The Color Purple",
    //   "Alice Walker",
    //   'images/bookCover/thecolorpurple.jpg',
    //   "36"
    // ],
    // ["Da Vinci Code", "Dan Brown", 'images/bookCover/vincicode.jpg', "527"],
    // ["All this has", "Monica Sabolo", 'images/bookCover/allthishas.jpg', "36"],
    // ["Ikigai", "Hector & Francsec", 'images/bookCover/ikigai.jpg', "56"],
    // [
    //   "The Subtle Art of not giving a F*ck",
    //   "Mark Manson",
    //   'images/bookCover/subtleart.jpg',
    //   "97"
    // ],
    // ["Enchant..", "Guy Kawasaki", 'images/bookCover/guy.jpg', "527"],
    // [
    //   "The Color Purple",
    //   "Alice Walker",
    //   'images/bookCover/thecolorpurple.jpg',
    //   "36"
    // ],
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
                    bottom: BorderSide(width: 2, color: Color.fromRGBO(44, 51, 59, 1)),
                  )
                : Border(
                    bottom: BorderSide(width: 2, color: Color.fromRGBO(167, 117, 139, 1)),
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
      backgroundColor: ColorConstant.primaryBG,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: ColorConstant.purple,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: kToolbarHeight),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Explore",
                  style: TextStyles.pageHeading,
                ),
                isThreeLine: true,
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Search and browse through all the used books available",
                      style: TextStyles.subText,
                    ),
                  ],
                ),
              ),
              Text('Recently Added', style: TextStyles.actionTitleBlack),
              SizedBox(height: 12),
              // for(int)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < 10; i++)
                      Container(
                        margin: EdgeInsets.only(right: 13),
                        child: Column(
                          children: [
                            Container(
                              width: w * 0.25,
                              height: w * 0.25 * 1.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(7)),
                                color: ColorConstant.purple,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: w * 0.25,
                              child: Text(
                                'Title of the book is hee and all ',
                                style: TextStyles.subText,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // Center(
              //   child: Container(
              //     margin: EdgeInsets.only(top: 10),
              //     decoration: BoxDecoration(
              //       color: Color.fromRGBO(52, 55, 62, 1),
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     padding: EdgeInsets.symmetric(vertical: 5),
              //     width: w * (1 - (2 * leftpadding)),
              //     child: TextField(
              //       keyboardType: TextInputType.text,
              //       decoration: InputDecoration(
              //         border: InputBorder.none,
              //         prefixIcon: Icon(
              //           Icons.search,
              //           color: Colors.white,
              //         ),
              //         hintText: _text == "" ? " Search..." : _text,
              //         hintStyle: TextStyle(color: Colors.white54),
              //       ),
              //       onChanged: (val) {
              //         setState(() {
              //           _text = val;
              //         });
              //       },
              //     ),
              //   ),
              // ),
              // //Custom Tab Controller --------------------
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   padding: EdgeInsets.only(top: 20, left: w * leftpadding),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       tabs("Economics", 1),
              //       tabs("Military", 2),
              //       tabs("Art", 3),
              //       tabs("Movement", 4),
              //       tabs("Design", 5),
              //       tabs("Science", 6),
              //       tabs("Biography", 7),
              //       tabs("Comics", 8)
              //     ],
              //   ),
              // ),
              // // Category Wise Books Diplay Area -----------
              // selectedTab == 1
              //     ? CategoryType(details: ecobookDetails)
              //     : selectedTab == 2
              //         ? CategoryType(details: ecobookDetails)
              //         : selectedTab == 3
              //             ? CategoryType(details: artbookDetails)
              //             : selectedTab == 4
              //                 ? CategoryType(details: artbookDetails)
              //                 : selectedTab == 5
              //                     ? CategoryType(details: ecobookDetails)
              //                     : selectedTab == 6
              //                         ? CategoryType(details: ecobookDetails)
              //                         : selectedTab == 7
              //                             ? CategoryType(details: artbookDetails)
              //                             : selectedTab == 8
              //                                 ? CategoryType(details: artbookDetails)
              //                                 : null,
            ],
          ),
        ),
      ),
    );
  }
}
