import 'package:flutter/material.dart';
import 'package:med_tech_app/utils/colors_util.dart';
import 'package:med_tech_app/utils/user_details.dart';

class MainSideDrawer extends StatelessWidget {
  const MainSideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final _userImage = getUserImage();
    final _userEmail = getUserEmail();
    return Drawer(
      backgroundColor: homeScreenBg,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  homeScreenBg,
                  bgColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: _userImage.isNotEmpty ? NetworkImage(_userImage) 
                  : AssetImage("assets/images/blue-circle-with-white-user.png") as ImageProvider,
                ),
                const SizedBox(width: 10,),
                Text(_userEmail, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black, fontSize: 18),),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle_sharp, color: bgColor2,),
            title: Text("Profile", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
            onTap: () {
              
            },
          ),
          ListTile(
            leading: Icon(Icons.edit_document, color: bgColor2,),
            title: Text("Prescriptions", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
            onTap: () {
              
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: bgColor2,),
            title: Text("Settings", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
            onTap: () {
              
            },
          ),
          ElevatedButton(
              onPressed: (){}, 
              style: ElevatedButton.styleFrom(
                backgroundColor: bgColor2,
                elevation: 6,
              ),
              child: Text(
                "Log Out",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          
        ],
      ),
    );
  }
}