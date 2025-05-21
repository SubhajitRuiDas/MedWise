// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:med_tech_app/screens/home_screen.dart';
// import 'package:med_tech_app/utils/show_snackbar.dart';

// class FirebaseGoogleSignin {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   User get user => _firebaseAuth.currentUser!;

//   Future<void> signInWithGoogle(BuildContext context) async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//       final GoogleSignInAuthentication? googleAuth =
//         await googleUser!.authentication;
        
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );

//       final userCred = await _firebaseAuth.signInWithCredential(credential);
//       print(userCred.user!.displayName);

//       showSnackbar(context, "Successfully User sign in using Google Account...");
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));

//       final _userId = userCred.user!.uid;
//       await FirebaseFirestore.instance.collection("user").doc(_userId)
//         .set({
//           "userId": _userId,
//           "username" : userCred.user!.displayName,
//           "userEmailId" : userCred.user!.email,
//         });
//     } on FirebaseAuthException catch (e) {
//       print(e.message);
//       showSnackbar(context, "Failed to Sign in using Google Account...");
//     }
//   }
// }