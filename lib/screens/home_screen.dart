import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_tech_app/utils/colors_util.dart';
import 'package:med_tech_app/utils/user_details.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedScreen = 0;
  String username ="";
  fetchUserName() async{
    String uname = await getUserName();
    setState(() {
      username = uname;
    });
  }
  @override
  void initState() {
    super.initState();
    fetchUserName();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeScreenBg,
      appBar: AppBar(
        title: Text(
          "Hello!\n$username",
          style: TextStyle(color: buttonColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: homeScreenBg,
        elevation: 2,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _selectedScreen = value;
          });
        },
        currentIndex: _selectedScreen,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
        ],
        backgroundColor: homeScreenBg,
      ),
    );
  }
}