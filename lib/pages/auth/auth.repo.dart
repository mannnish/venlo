import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:readingbook/constants/loading.popup.dart';
import 'package:readingbook/constants/string.dart';
import 'package:readingbook/constants/toast.dart';
import 'package:readingbook/models/book.model.dart';
import 'package:readingbook/models/user.model.dart';
import 'package:readingbook/pages/auth/register.dart';
import 'package:readingbook/pages/auth/splash.dart';
import 'package:readingbook/pages/root_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  static void logout(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(StringConstants.token);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SplashScreen()));
  }

  static void gsignin(context) async {
    LoadingPopupGenerator.def(text: 'Fetching Account', context: context);
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    } catch (e) {}
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      final User user = (await _firebaseAuth.signInWithCredential(credential)).user;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(StringConstants.token, user.uid);

      bool isRegistered = await AuthRepo.checkExist(user.uid);
      Navigator.pop(context);
      if (!isRegistered) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Register()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RootPage()));
      }
    } catch (e) {
      Navigator.pop(context);
      ToastPreset.err(context: context, str: 'Error $e');
      print(e);
    }
  }

  static Future<bool> checkExist(String docID) async {
    bool exists = false;
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection(StringConstants.userCollection).doc(docID).get();
    exists = ds.exists;
    return exists;
  }

  static Future<UserModel> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(StringConstants.token);

    CollectionReference dataCollection = FirebaseFirestore.instance.collection(StringConstants.userCollection);
    DocumentSnapshot userData = await dataCollection.doc(token).get();
    UserModel userModel = UserModel(
      id: token,
      name: userData.get('name') ?? "",
      phone: userData.get('phone') ?? "",
      email: userData.get('email') ?? "",
      area: userData.get('area') ?? "",
      college: userData.get('college') ?? "",
      photo: userData.get('photo') ?? "",
      posts: userData.data().toString().contains('posts') ? userData.get('posts') ?? [] : [],
      bookmarked: userData.data().toString().contains('bookmarked') ? userData.get('bookmarked') ?? [] : [],
    );
    return userModel;
  }

  static Future<List<BookModel>> allBooks() async {
    CollectionReference dataCollection = FirebaseFirestore.instance.collection(StringConstants.bookCollection);
    List<BookModel> bookModels = [];
    QuerySnapshot s = await dataCollection.get();
    for (QueryDocumentSnapshot bookData in s.docs) {
      try {
        BookModel bookModel = BookModel.fromJson(bookData.data(), bookData.id);
        bookModels.add(bookModel);
      } catch (e) {}
    }
    return bookModels;
  }

  static Future<List<BookModel>> getPostsUser(List ids) async {
    CollectionReference dataCollection = FirebaseFirestore.instance.collection(StringConstants.bookCollection);
    DocumentSnapshot bookData;
    List<BookModel> bookModels = [];
    for (var id in ids) {
      bookData = await dataCollection.doc(id).get();
      try {
        BookModel bookModel = BookModel.fromJson(bookData.data(), id);
        // BookModel bookModel = BookModel(
        //   title: bookData.get('title') ?? "",
        //   publication: bookData.get('publication') ?? "",
        //   author: bookData.get('author') ?? "",
        //   ownerId: bookData.get('owner_id') ?? "",
        //   ownerName: bookData.get('owner_name') ?? "",
        //   ownerPhone: bookData.get('owner_phone') ?? "",
        //   createdAt: DateTime.now(),
        //   // createdAt: DateTime.parse(bookData.get('created_at')) ?? DateTime.now(),
        //   views: bookData.get('views') ?? 0,
        //   sold: bookData.get('sold') ?? false,
        //   photoUrl: bookData.get('photo_url') ?? [],
        //   categories: bookData.get('categories') ?? [],
        // );
        bookModels.add(bookModel);
      } catch (e) {
        print("ERRROR $e");
      }
    }
    return bookModels;
  }

  static Future<List<BookModel>> getBookmarked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(StringConstants.token);

    CollectionReference dataCollection = FirebaseFirestore.instance.collection(StringConstants.userCollection);
    DocumentSnapshot userData = await dataCollection.doc(token).get();
    List ids = userData.get('bookmarked') ?? [];
    print(ids);
    // get book by ids;
    List<BookModel> models = [];
    return models;
  }
}
