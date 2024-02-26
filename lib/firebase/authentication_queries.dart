import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthenticationQueries {
  final FirebaseAuth auth = FirebaseAuth.instance;

  User? get user => auth.currentUser;

  Future<User?> signUpUser(
      {required String email, required String password}) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null) {
        debugPrint("Successfully created user.");
        return user.user;
      } else {
        debugPrint("Error creating user.");
        return null;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Error creating user $e");
      return null;
    }
  }

  Future<User?> signInUser(
      {required String email, required String password}) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null) {
        debugPrint("Successfully signed in.");
        return user.user;
      } else {
        debugPrint("Error signing in.");
        return null;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Error signing in $e");
      return null;
    }
  }

  Future signOut() async {
    await auth.signOut();
    debugPrint('successfully signed out');
  }
}
