import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readingbook/constants/colors.dart';
import 'package:readingbook/constants/string.dart';
import 'package:readingbook/constants/textstyles.dart';
import 'package:readingbook/constants/toast.dart';
import 'package:readingbook/models/book.model.dart';
import 'package:readingbook/pages/auth/auth.repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pdp.dart';

class BookSearch extends SearchDelegate<String> {
  TextStyle textStyle = new TextStyle(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            FocusScope.of(context).unfocus();
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  Future<String> loadAsset(str) async {
    return await rootBundle.loadString(str);
  }

  Future<List<dynamic>> funcOnChange() async {
    List temp = [];
    List<BookModel> models = await AuthRepo.allBooks();
    for (BookModel model in models) {
      if (model.doesContain(query)) temp.add(model);
    }

    return temp;
  }

  Widget results() {
    if (query != null && query.length > 1) {
      return FutureBuilder(
          future: funcOnChange(),
          builder: (ctx, value) {
            if (value.hasData) {
              if (value.data.length == 0) {
                return Text('no data');
              }
              return ListView.builder(
                itemCount: value.data.length,
                itemBuilder: (context, index) {
                  return singleBookShowcase(value.data[index], context);
                },
              );
            } else {
              return SizedBox();
            }
          });
    } else {
      return SizedBox();
    }
  }

  @override
  Widget buildResults(BuildContext context) {
    return results();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return results();
  }

  Widget singleBookShowcase(BookModel bookModel, context) {
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => PDP(model: bookModel)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        height: w * 0.25 * 1.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: !bookModel.sold ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.3),
        ),
        child: Row(
          children: [
            Container(
              width: w * 0.25,
              height: w * 0.25 * 1.3,
              decoration: bookModel.photoUrl.isNotEmpty
                  ? BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      image: DecorationImage(
                        image: MemoryImage(base64Decode(bookModel.photoUrl.first)),
                        fit: BoxFit.cover,
                      ),
                    )
                  : BoxDecoration(
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
                        onTap: () async {
                          try {
                            SharedPreferences pref = await SharedPreferences.getInstance();
                            String token = pref.getString(StringConstants.token);
                            final CollectionReference userCollection =
                                FirebaseFirestore.instance.collection(StringConstants.userCollection);
                            DocumentSnapshot snapshot = await userCollection.doc(token).get();

                            List bookmarked =
                                snapshot.data().toString().contains('bookmarked') ? snapshot.get('bookmarked') : [];
                            if (!bookmarked.contains(bookModel.id))
                              bookmarked.add(bookModel.id);
                            else {
                              ToastPreset.err(str: 'Already Added', context: context);
                              return;
                            }
                            await userCollection.doc(token).set({
                              'bookmarked': bookmarked,
                            }, SetOptions(merge: true));
                            ToastPreset.successful(str: 'Bookmarked', context: context);
                          } catch (e) {
                            ToastPreset.err(str: e.toString(), context: context);
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.bookmark_add_outlined,
                              size: 15,
                              color: ColorConstant.highlighterPink,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Bookmark",
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
            SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
