import 'package:flutter/material.dart';
import 'book.dart';

class CategoryType extends StatefulWidget {
  final List details;
  CategoryType({this.details});
  @override
  _CategoryTypeState createState() => _CategoryTypeState();
}

class _CategoryTypeState extends State<CategoryType> {
  double leftpadding = 0.075;
  double w, h;

  Widget singleBookShowcase(int index) {
    return Container();
    // return InkWell(
    //   onTap: () {
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => Book(
    //                   details: widget.details[index],
    //                 )));
    //   },
    //   child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //     Container(
    //       width: w * 0.2,
    //       height: (w * 0.2) * 1.5,
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(5.0),
    //           image: DecorationImage(
    //             image: AssetImage(widget.details[index][2]),
    //             fit: BoxFit.cover,
    //           )),
    //     ),
    //     Container(
    //         width: w * 0.2,
    //         padding: EdgeInsets.only(top: 10),
    //         child: Text(
    //           widget.details[index][0],
    //           style: TextStyle(color: Colors.white, fontSize: 13),
    //         )),
    //     Text(
    //       widget.details[index][1],
    //       style: TextStyle(color: Colors.grey, fontSize: 9),
    //     )
    //   ]),
    // );
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: (w * leftpadding) + 10, right: (w * leftpadding) + 10, top: 40, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Book Hot List',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    'view all   >',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Popular 3 books ------
            Padding(
              padding:
                  EdgeInsets.only(left: (w * leftpadding) + 10, right: (w * leftpadding) + 10, top: 40, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  singleBookShowcase(0),
                  singleBookShowcase(1),
                  singleBookShowcase(2),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * leftpadding),
              child: Divider(
                height: 1,
                color: Colors.grey,
              ),
            ),

            // Title - Popular Books -------------------
            Padding(
              padding: EdgeInsets.only(left: (w * leftpadding) + 10, right: (w * leftpadding) + 10, top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Books',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    'view all   >',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: (w * leftpadding) + 10, right: (w * leftpadding) + 10, top: 40, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  singleBookShowcase(3),
                  singleBookShowcase(4),
                  singleBookShowcase(5),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: (w * leftpadding) + 10, right: (w * leftpadding) + 10, top: 30, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  singleBookShowcase(6),
                  singleBookShowcase(7),
                  singleBookShowcase(8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// change