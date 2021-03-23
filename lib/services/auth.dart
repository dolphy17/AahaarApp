import 'package:aahaar/models/user.dart';
import 'package:aahaar/screens/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  var isGoogle = false;
 User currentUser;
  AuthMethods({this.currentUser});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Users _userfirebse(User user) {
    if (user == null) {
      return null;
    } else {
      currentUser = user;
      return Users(user: user);
    }
  }

  Future signUpwithEmail(String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => _userfirebse(value.user));
      //return _userfirebse(result.user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signInwithEmail({String email, String password}) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => _userfirebse(value.user));
    } catch (e) {
      print(e.toString());
    }
  }

  Future signInwithGoogle(BuildContext ctx) async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      await _auth.signInWithCredential(credential).then((value) {
        isGoogle = true;
        _userfirebse(value.user);
        Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => HomeScreen()));
      });
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Future signout() async {
    try {
      if (isGoogle) {
        return await googleSignIn.signOut();
      } else
        return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  // ignore: missing_return
  Future resetPassword({String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
