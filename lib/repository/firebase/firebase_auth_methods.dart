import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:med_tech_app/utils/show_snackbar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User get user => _firebaseAuth.currentUser!;

  // google sign in function 
  Future<bool> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if(googleUser == null) return false; // as user canceled the sign in 

      final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;
        
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCred = await _firebaseAuth.signInWithCredential(credential);
      print(userCred.user!.displayName);

      showSnackbar(context, "Successfully User sign in using Google Account...");
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      showSnackbar(context, "Failed to Sign in using Google Account...");
      return false;
    }
  }

  // create account using email and password
  Future<bool> createAccountWithEmailAndPassword(BuildContext context, String emailId, String password, String userName) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: emailId, password: password);
      showSnackbar(context, "Successfully account create using email-id and password");
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      showSnackbar(context, "Failed to sign in using email-id and password");
      return false;
    }
  }

  // sign in using email-id and password
  Future<bool> signInWithEmailAndPassword(BuildContext context, String emailId, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: emailId, password: password);
      showSnackbar(context, "Successfully sign in with email-id and password");
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      showSnackbar(context, "Failed to sign in using email-id and password");
      return false;
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e);
      showSnackbar(context, "Failed to Sign Out");
    }
  }
}