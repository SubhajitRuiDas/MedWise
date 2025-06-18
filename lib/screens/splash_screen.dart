import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_tech_app/screens/auth_screen.dart';
import 'package:med_tech_app/screens/home_screen.dart';
import 'package:med_tech_app/utils/colors_util.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [buttonColor, bgColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kToolbarHeight,),
                  Text("Welcome",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: bgColor),),
                  // const SizedBox(height: 5,),
                  Text("To Your Medical App MediSync", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: bgColor),),
                  const SizedBox(height: 60,),
                  Text(
                    'Your all-in-one health companion.\n'
                    'Book doctor appointments, get instant AI-powered health advice, '
                    'track your wellness, and order medicines — all from one seamless platform.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white54,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 60,),
                  StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return CircularProgressIndicator();
                      } 
                      if(snapshot.hasData) {
                        return ElevatedButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                        }, 
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          backgroundColor: buttonColor,
                          shadowColor: buttonColor,
                        ),
                        child: Text("Get Started", style: TextStyle(color: Colors.white),),
                        );
                      }
                      return ElevatedButton(
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthScreen()));
                        }, 
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          backgroundColor: buttonColor,
                          shadowColor: buttonColor,
                        ),
                        child: Text("Get Started", style: TextStyle(color: Colors.white),), 
                      );
                    }
                  ),
                ],
              ),
            ),
            Image.asset("assets/images/doctor-with-his-arms-crossed-white-background.png",),
          ],
        ),
      ),
    );
  }
}