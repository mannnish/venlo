import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readingbook/constants/colors.dart';
import 'package:readingbook/constants/string.dart';
import 'package:readingbook/constants/textstyles.dart';
import 'package:readingbook/constants/toast.dart';
import 'package:readingbook/models/book.model.dart';
import 'package:readingbook/models/user.model.dart';
import 'package:readingbook/pages/auth/auth.repo.dart';

class Bookmarked extends StatefulWidget {
  @override
  _BookmarkedState createState() => _BookmarkedState();
}

class _BookmarkedState extends State<Bookmarked> {
  double w, h;
  List favBookMatrix;
  UserModel userModel;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loading = true;
    getData();
  }

  void getData() async {
    userModel = await AuthRepo.getUser();
    setState(() {
      loading = false;
    });
  }

  Widget singleBookShowcase(BookModel bookModel) {
    return Container(
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
                      onTap: () async {
                        try {
                          setState(() {
                            userModel.bookmarked.remove(bookModel.id);
                          });
                          final CollectionReference userCollection =
                              FirebaseFirestore.instance.collection(StringConstants.userCollection);
                          await userCollection.doc(userModel.id).update({
                            'bookmarked': userModel.bookmarked,
                          });
                          ToastPreset.successful(str: 'Changed', context: context);
                        } catch (e) {
                          ToastPreset.err(str: e.toString(), context: context);
                        }
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
                            "Un-Bookmark",
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
              loading
                  ? Text('Loading')
                  : StreamBuilder(
                      stream: FirebaseFirestore.instance.collection(StringConstants.bookCollection).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              QueryDocumentSnapshot mypost = snapshot.data.docs[index];
                              BookModel model = BookModel.fromJson(mypost.data(), mypost.id);
                              if (userModel.bookmarked.contains(model.id))
                                return singleBookShowcase(model);
                              else
                                return SizedBox();
                            },
                          );
                        } else {
                          return Text(
                            'No Posts yet',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          );
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
