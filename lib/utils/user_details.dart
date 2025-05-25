import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> getUserName() async{
  final user = FirebaseAuth.instance.currentUser;
  final userId = user?.uid;

  if(userId == null) return "";

  final doc = await FirebaseFirestore.instance.collection("user").doc(userId).get();

  if(doc.exists){
    return doc.data()!['username'] ?? "";
  } else{
    return "";
  }
}
String getUserImage() {
  final user = FirebaseAuth.instance.currentUser;
  return user?.photoURL ?? "";
}
String getUserEmail() {
  final user = FirebaseAuth.instance.currentUser;
  return user?.email ?? "";
}