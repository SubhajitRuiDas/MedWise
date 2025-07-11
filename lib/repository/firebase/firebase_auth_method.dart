import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_tech_app/screens/splash_screen.dart';
import 'package:med_tech_app/utils/show_snackbar.dart';

class FirebaseAuthMethod {
  static Future<void> singOut(BuildContext context) async{
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    
    try {
      await _firebaseAuth.signOut();
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (context) => const SplashScreen()), 
        (route) => false,
      );
    } catch (e) {
      showSnackbar(context, "Error occured in log out process");
    }
  }
}