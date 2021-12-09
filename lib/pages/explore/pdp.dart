import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readingbook/constants/colors.dart';
import 'package:readingbook/constants/string.dart';
import 'package:readingbook/constants/toast.dart';
import 'package:readingbook/models/book.model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class PDP extends StatefulWidget {
  final BookModel model;
  PDP({@required this.model});
  @override
  _PDPState createState() => _PDPState();
}

class _PDPState extends State<PDP> {
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
          Container(
            width: w * 0.45,
            height: w * 0.45 * 1.5,
            decoration: widget.model.photoUrl.isNotEmpty
                ? BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    image: DecorationImage(
                      image: MemoryImage(base64Decode(widget.model.photoUrl.first)),
                      fit: BoxFit.cover,
                    ),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: ColorConstant.purple,
                  ),
          ),
          SizedBox(height: 10),
          Container(
            width: w * 0.45,
            child: Text(
              widget.model.title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          SizedBox(height: 3),
          Container(
            width: w * 0.35,
            child: Text(
              "By ${widget.model.author}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
          Container(
            width: w * 0.80,
            child: Text(
              "Published By : ${widget.model.publication}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
          Container(
            width: w * 0.80,
            child: Text(
              "Posted By : ${widget.model.ownerName}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
          Container(
            width: w * 0.80,
            child: Text(
              widget.model.sold ? "SOLD" : "",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    try {
                      launch("tel://${widget.model.ownerPhone}");
                    } catch (e) {
                      ToastPreset.err(str: 'Error : ${e.toString()}', context: context);
                    }
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
                      Icons.phone,
                      color: Color.fromRGBO(44, 51, 59, 1),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      String token = pref.getString(StringConstants.token);
                      final CollectionReference userCollection =
                          FirebaseFirestore.instance.collection(StringConstants.userCollection);
                      DocumentSnapshot snapshot = await userCollection.doc(token).get();

                      List bookmarked =
                          snapshot.data().toString().contains('bookmarked') ? snapshot.get('bookmarked') : [];
                      if (!bookmarked.contains(widget.model.id))
                        bookmarked.add(widget.model.id);
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
        ],
      ),
    );
  }
}
