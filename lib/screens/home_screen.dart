import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_tech_app/utils/colors_util.dart';
import 'package:med_tech_app/utils/user_details.dart';
import 'package:med_tech_app/widget/display_card.dart';
import 'package:med_tech_app/widget/main_side_drawer.dart';

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
      drawer: MainSideDrawer(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                DisplayCard(cardColor: Colors.orangeAccent, cardText: "Medical Services"),
                DisplayCard(cardColor: Colors.green, cardText: "Health Assistant"),
              ],
            ),
          ),
        ],
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