import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:readingbook/constants/loading.popup.dart';
import 'package:readingbook/constants/string.dart';
import 'package:readingbook/constants/toast.dart';
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
    return UserModel(
      id: token,
      name: userData.get('name') ?? "",
      phone: userData.get('phone') ?? "",
      email: userData.get('email') ?? "",
      area: userData.get('area') ?? "",
      college: userData.get('college') ?? "",
      photo: userData.get('photo') ?? "",
      posts: userData.get('posts') ?? [],
    );
  }
}
