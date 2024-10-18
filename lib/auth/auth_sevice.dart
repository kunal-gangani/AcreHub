import 'dart:developer';

import 'package:acrehub/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthSevice {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIng = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);
  Future<void> signout(context) async {
    try {
      await _googleSignIng.signOut();
      await _auth.signOut();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const Wrapper()),
          (route) => false);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

//google login
  Future<UserCredential?> loginWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      return await _auth.signInWithCredential(cred);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  //Email verification
  Future<void> sendEmailVerificationLink() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
  }

  //Forgot Password
  Future<void> sendPasswordResetLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  //signin auth code
  Future<User?> createUserWithWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      ExceptionHandler(e.code);
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  //login auth code
  Future<User?> loginUserWithWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      ExceptionHandler(e.code);
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  // //signout auth code
  // Future<void> signout() async {
  //   try {
  //     await _auth.signOut();
  //   } catch (e) {}
  // }
}

//error handler
ExceptionHandler(String code) {
  switch (code) {
    case "invalid-credential":
      log("Your login crednetials are invalid");
    case "weak-password":
      log("Your Password Must be 6 Characters!!");
    case "email-already-in-use":
      log("User Already exists");
    default:
      log("Something Wemt wrong");
  }
}
