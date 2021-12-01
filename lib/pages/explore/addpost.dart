import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readingbook/constants/colors.dart';
import 'package:readingbook/constants/string.dart';
import 'package:readingbook/constants/toast.dart';
import 'package:readingbook/models/book.model.dart';
import 'package:readingbook/models/user.model.dart';
import 'package:readingbook/pages/auth/auth.repo.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  String title;
  String publication;
  String author;
  UserModel userModel;
  List<String> categories = [];
  List<String> photoUrl = [];
  final TextStyle titleStyle = TextStyle(fontSize: 12);
  final TextStyle inputStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    userModel = await AuthRepo.getUser();
    if (userModel == null) {
      ToastPreset.err(str: 'some error while getting user', context: context);
    }
  }

  showError(str) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(str),
        duration: new Duration(milliseconds: 400),
      ),
    );
  }

  Widget saveButton() {
    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).unfocus();
        if (title == null || title.isEmpty) {
          showError('Enter Valid Title');
          return;
        }
        if (publication == null || publication.isEmpty) {
          showError('Enter Publication');
          return;
        }
        BookModel model = BookModel(
          author: author,
          categories: [],
          createdAt: DateTime.now(),
          ownerId: userModel.id,
          ownerName: userModel.name,
          ownerPhone: userModel.phone,
          photoUrl: photoUrl,
          publication: publication,
          sold: false,
          title: title,
          views: 0,
        );
        final CollectionReference dataCollection =
            FirebaseFirestore.instance.collection(StringConstants.bookCollection);
        await dataCollection.doc().set(model.toJson());
      },
      child: Container(
        alignment: Alignment.centerRight,
        child: Text(
          'Save',
          style: TextStyle(
            fontSize: 16,
            color: ColorConstant.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget textInput({
    title,
    initialValue,
    Function change,
    hintText,
    IconData icon,
    bool noInput = false,
  }) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            Icon(
              icon,
              color: Colors.grey,
              size: 23,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                    ),
                  ),
                  SizedBox(height: 3),
                  textForm(initialValue, hintText, change),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        noInput
            ? SizedBox()
            : Divider(
                color: Colors.red.withOpacity(0.5),
              ),
      ],
    );
  }

  TextFormField textForm(initialValue, hintText, Function change) {
    return TextFormField(
      maxLength: 200,
      style: inputStyle,
      keyboardType: TextInputType.text,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintStyle: inputStyle..copyWith(fontWeight: FontWeight.normal),
        isDense: true,
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(bottom: 0),
        counterText: "",
        hintText: hintText,
      ),
      onChanged: change,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future<bool>.value(false);
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.symmetric(horizontal: 13),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 90),
                  // TODO : Form here
                  // textInput(
                  //   title: 'Your Phone',
                  //   hintText: 'Enter Your Phone',
                  //   change: (val) {
                  //     setState(() => phone = val);
                  //   },
                  //   initialValue: null,
                  //   icon: Icons.phone,
                  // ),
                  // textInput(
                  //   title: 'Area, State',
                  //   hintText: 'Enter your area, state',
                  //   change: (val) {
                  //     setState(() => area = val);
                  //   },
                  //   initialValue: null,
                  //   icon: Icons.location_city,
                  // ),
                  // textInput(
                  //   title: 'College',
                  //   hintText: 'Enter college name',
                  //   change: (val) {
                  //     setState(() => college = val);
                  //   },
                  //   initialValue: null,
                  //   icon: Icons.work,
                  // ),
                  SizedBox(height: 30),
                  saveButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
