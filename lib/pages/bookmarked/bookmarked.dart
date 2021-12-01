import 'package:flutter/material.dart';
import 'package:readingbook/constants/colors.dart';
import 'package:readingbook/constants/textstyles.dart';
import 'package:readingbook/models/book.model.dart';

class Bookmarked extends StatefulWidget {
  @override
  _BookmarkedState createState() => _BookmarkedState();
}

class _BookmarkedState extends State<Bookmarked> {
  double w, h;
  double leftpadding;

  List favBookMatrix;

  _BookmarkedState() {
    leftpadding = 0.075;
    favBookMatrix = [
      BookModel(
        author: 'Hector',
        createdAt: DateTime.now(),
        ownerId: '4c34f',
        ownerName: 'Manish',
        ownerPhone: '9958774243',
        photoUrl: ['https://avatars1.githubusercontent.com/u/60895972?s=460&v=4'],
        publication: 'Quantam Publication Ltd.',
        sold: false,
        title: 'Web Tech Quantam',
        views: 12,
        categories: [],
      ),
    ];
  }

  Widget singleBookShowcase(BookModel bookModel) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      height: w * 0.25 * 1.3,
      child: Row(
        children: [
          Container(
            width: w * 0.25,
            height: w * 0.25 * 1.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              color: ColorConstant.purple,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookModel.title,
                  style: TextStyles.highlighterTwo,
                ),
                Text(
                  bookModel.publication,
                  style: TextStyles.highlighterOne,
                ),
                Spacer(),
                Text(
                  "Posted by ${bookModel.ownerName}",
                  style: TextStyles.highlighterOne,
                ),
                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: () {
                        //
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.cancel,
                            size: 15,
                            color: ColorConstant.highlighterPink,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Remove",
                            style: TextStyles.subTextRed,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorConstant.primaryBG,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: kToolbarHeight),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Bookmarked",
                  style: TextStyles.pageHeading,
                ),
                isThreeLine: true,
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "All the books that you marked",
                      style: TextStyles.subText,
                    ),
                  ],
                ),
              ),
              for (BookModel book in favBookMatrix) singleBookShowcase(book),
            ],
          ),
        ),
      ),
    );
  }
}
