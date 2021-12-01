import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readingbook/constants/colors.dart';
import 'package:readingbook/constants/string.dart';
import 'package:readingbook/models/user.model.dart';
import 'package:readingbook/pages/root_page.dart';
import 'login_page.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String phone;
  String college;
  String area;
  final TextStyle titleStyle = TextStyle(fontSize: 12);
  final TextStyle inputStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

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
        if (phone == null || phone.length < 10) {
          showError('Enter Valid Phone');
          return;
        }
        if (college == null || college.isEmpty) {
          showError('Enter Area');
          return;
        }
        if (area == null || area.isEmpty) {
          showError('Enter Area');
          return;
        }
        User user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          Navigator.pop(context);
          showError('Please log in again');
          await Future.delayed(new Duration(milliseconds: 700));
          Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
        }
        UserModel model = UserModel(
          name: user.displayName,
          email: user.email,
          photo: user.photoURL,
          posts: [],
          phone: phone,
          area: area,
          college: college,
          bookmarked: [],
        );
        final CollectionReference dataCollection =
            FirebaseFirestore.instance.collection(StringConstants.userCollection);
        await dataCollection.doc(user.uid).set(model.toJson());
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RootPage()));
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
          appBar: AppBar(
            elevation: 0,
            title: Text('Add Post'),
            automaticallyImplyLeading: false,
            leading: Icon(Icons.app_registration_outlined),
            backgroundColor: ColorConstant.purple,
          ),
          body: Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.symmetric(horizontal: 13),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  textInput(
                    title: 'Your Phone',
                    hintText: 'Enter Your Phone',
                    change: (val) {
                      setState(() => phone = val);
                    },
                    initialValue: null,
                    icon: Icons.phone,
                  ),
                  textInput(
                    title: 'Area, State',
                    hintText: 'Enter your area, state',
                    change: (val) {
                      setState(() => area = val);
                    },
                    initialValue: null,
                    icon: Icons.location_city,
                  ),
                  textInput(
                    title: 'College',
                    hintText: 'Enter college name',
                    change: (val) {
                      setState(() => college = val);
                    },
                    initialValue: null,
                    icon: Icons.work,
                  ),
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
