import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readingbook/constants/colors.dart';
import 'package:readingbook/constants/loading.popup.dart';
import 'package:readingbook/constants/string.dart';
import 'package:readingbook/constants/textstyles.dart';
import 'package:readingbook/models/book.model.dart';
import 'package:readingbook/pages/auth/auth.repo.dart';

class YourPosts extends StatefulWidget {
  final String userId;
  final List ids;
  YourPosts({Key key, @required this.userId, @required this.ids}) : super(key: key);

  @override
  _YourPostsState createState() => _YourPostsState();
}

class _YourPostsState extends State<YourPosts> {
  double w, h;
  List ids;
  List<BookModel> models;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    ids = widget.ids;
    getData();
  }

  getData() async {
    models = await AuthRepo.getPostsUser(ids);
    setState(() => loading = false);
  }

  remove(int index) async {
    LoadingPopupGenerator.def(text: 'Deleting Post', context: context);

    final CollectionReference bookCollection = FirebaseFirestore.instance.collection(StringConstants.bookCollection);
    await bookCollection.doc(ids[index]).delete();

    ids.remove(ids[index]);
    final CollectionReference userCollection = FirebaseFirestore.instance.collection(StringConstants.userCollection);
    await userCollection.doc(widget.userId).update({
      'posts': ids,
    });
    Navigator.pop(context);
    setState(() {
      models.removeAt(index);
    });
  }

  Widget singleBookShowcase(int index, BookModel bookModel) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      height: w * 0.25 * 1.3,
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
                      onTap: () => remove(index),
                      child: Row(
                        children: [
                          Icon(
                            Icons.cancel,
                            size: 15,
                            color: ColorConstant.highlighterPink,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Delete",
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
      appBar: AppBar(
        elevation: 0,
        title: Text('Your Posts'),
        backgroundColor: ColorConstant.purple,
      ),
      backgroundColor: ColorConstant.primaryBG,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: loading
              ? Text('Loading')
              : Column(
                  children: [
                    // SizedBox(height: 10),
                    for (int i = 0; i < models.length; i++) singleBookShowcase(i, models[i]),
                  ],
                ),
        ),
      ),
    );
  }
}
