import 'package:flutter/material.dart';
import 'package:med_tech_app/repository/firebase/firebase_auth_method.dart';
import 'package:med_tech_app/screens/booked_appointments_screen.dart';
import 'package:med_tech_app/utils/colors_util.dart';
import 'package:med_tech_app/utils/show_snackbar.dart';
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
            leading: Icon(Icons.app_registration_outlined, color: bgColor2,),
            title: Text("Appointments", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const BookedAppointmentsScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: bgColor2,),
            title: Text("Settings", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
            onTap: () {
              
            },
          ),
          ElevatedButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                    title: const Text("Log out", textAlign: TextAlign.center,),
                    elevation: 10.0,
                    content: const Text("Do you want to log out?", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: (){
                              showSnackbar(context, "Log out process starts");
                              FirebaseAuthMethod.singOut(context);
                            }, 
                            child: Text("Yes", style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            }, 
                            child: Text("No", style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                    ],
                  );
                  },
                );
              }, 
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