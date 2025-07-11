import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:med_tech_app/cubit/user_auth_cubit.dart';
import 'package:med_tech_app/cubit/user_auth_state.dart';
import 'package:med_tech_app/repository/firebase/firebase_google_signin.dart';
import 'package:med_tech_app/screens/home_screen.dart';
import 'package:med_tech_app/utils/colors_util.dart';
import 'package:med_tech_app/utils/show_snackbar.dart';

class AuthScreen extends StatefulWidget{
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late bool isSingUp;
  String _enteredName = "";  //"Please enter valid username (atleast 3 characters)";
  String _enteredEmail = ""; //"Please enter valid email id"
  String _enteredPassword = "";

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    isSingUp = true;
  }
  void authButtonClicked() async{
    final _firebaseAuthInstance = FirebaseAuth.instance;

    final authQubit = BlocProvider.of<UserAuthCubit>(context);
    authQubit.startAuthenticationProcess();

    final _formValid = _formKey.currentState!.validate();
    if(!_formValid) return;

    _formKey.currentState!.save();  // save the current form state
    
    if(isSingUp) {
      // means user is now currently creating an account 
      try{
        final _userCred = await _firebaseAuthInstance.createUserWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);
        authQubit.endAuthenticationProcess();

        // authentication process successful
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        showSnackbar(context, "User Signed In successfully");

        final _userId = _userCred.user!.uid;
        await FirebaseFirestore.instance.collection("user").doc(_userId)
        .set({
          "userId": _userId,
          "username" : _enteredName,
          "userEmailId" : _enteredEmail,
        });

      }on FirebaseAuthException catch(e){
        print(e.toString());
        showSnackbar(context, "There is an issue with SignIn process");
      }
    } else {
      try{
        await _firebaseAuthInstance.signInWithEmailAndPassword(email: _enteredEmail,password: _enteredPassword);
        authQubit.endAuthenticationProcess();

        // authentication process successful
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        showSnackbar(context, "User Signed In successfully");
      }on FirebaseAuthException catch(e){
        print(e.toString());
        showSnackbar(context, "There is an issue with SignIn process");
      }
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 193, 243, 233),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 193, 243, 233),
        title: Text("MedWise AI", style: TextStyle(fontWeight: FontWeight.bold, color: buttonColor),),
        elevation: 10,
        centerTitle: true,
      ),
      body: BlocConsumer<UserAuthCubit, UserAuthState>(
        builder: (context, state) {
          if(state.authOnProcess) {
            // means auth process starts
            return const Center(child: CircularProgressIndicator(),);
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isSingUp ? Text("Create Your Account", style: TextStyle(fontWeight: FontWeight.bold, color: buttonColor, fontSize: 25),) 
                : Text("Welcome Back", style: TextStyle(fontWeight: FontWeight.bold, color: buttonColor, fontSize: 25),),
                isSingUp ? Text("Please enter your details to Sign Up", style: TextStyle(fontWeight: FontWeight.bold, color: buttonColor, fontSize: 15),) 
                : Text("Please enter your details to Login", style: TextStyle(fontWeight: FontWeight.bold, color: buttonColor, fontSize: 15),),
                const SizedBox(height: 10,),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha:  0.25),
                        blurRadius: 60.0,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "assets/images/medical-app.png",
                  ),
                ),
                const SizedBox(height: 30,),
                Expanded(
                  child: SingleChildScrollView(
                    // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(  // email
                              decoration: InputDecoration(
                                hintText: "Enter your Email id",
                                hintStyle: TextStyle(color: buttonColor),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: buttonColor,
                                ), 
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                  if(value == null || value.trim().isEmpty || !value.contains('@')){
                                    return "Please enter valid email id";
                                  }
                                  return null;
                              },
                              onSaved: (newValue) {
                                _enteredEmail = newValue!;
                              },
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter your password",
                                hintStyle: TextStyle(fontWeight: FontWeight.bold, color: buttonColor),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: buttonColor,
                                ), 
                              ),
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                  if(value == null || value.trim().isEmpty || value.trim().length < 6){
                                    return "password must be atleast in the size of 6";
                                  }
                                  return null;
                              },
                              onSaved: (newValue) {
                                _enteredPassword = newValue!;
                              },
                          ),
                          const SizedBox(height: 10,),
                          if(isSingUp)
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter your username",
                                hintStyle: TextStyle(fontWeight: FontWeight.bold, color: buttonColor),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                prefixIcon: Icon(
                                  Icons.supervised_user_circle_rounded,
                                  color: buttonColor,
                                ), 
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                  if(value == null || value.trim().isEmpty || value.trim().length < 3){
                                    return "Please enter valid username (atleast 3 characters)";
                                  }
                                  return null;
                              },
                              onSaved: (newValue) {
                                _enteredName = newValue!;
                              },
                          ),
                          const SizedBox(height: 20,),
                          ElevatedButton(
                            onPressed: (){
                              authButtonClicked();
                            }, 
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.lightBlue,
                              backgroundColor: buttonColor,
                              padding: EdgeInsets.symmetric(horizontal: 60,),
                            ),
                            child: Text(
                              isSingUp ? "Sign Up" : "Log In",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isSingUp ? Text("Already have an account?", style: TextStyle(color: buttonColor, fontWeight: FontWeight.bold),) 
                              : Text("Don't have an account?", style: TextStyle(color: buttonColor, fontWeight: FontWeight.bold)),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isSingUp = !isSingUp;
                                  });
                                }, 
                                child: isSingUp ? Text("SignIn") : Text("Create an account"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Text("Or", style: TextStyle(color: buttonColor, fontWeight: FontWeight.bold, fontSize: 15),),
                          const SizedBox(height: 10,),
                          InkWell(
                            onTap: (){
                              // _firebaseGoogleSignin.signInWithGoogle(context);
                              googleSignInMethod();
                            }, 
                            child: Image.asset("assets/images/search.png", width: 30, height: 30,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                
              ],
            ),
          );
        },
        listener: (context, state) {
          // still not required
        }
      ),
    );    
  }
  
  void googleSignInMethod() async{
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if(googleUser == null) {
        // canceled google sign in
        showSnackbar(context, "Google sign-in cancelled");
        return;
      }
      final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;
        
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCred = await _firebaseAuth.signInWithCredential(credential);
      print(userCred.user!.displayName);

      showSnackbar(context, "Successfully User sign in using Google Account...");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));

      final _userId = userCred.user!.uid;
      await FirebaseFirestore.instance.collection("user").doc(_userId)
        .set({
          "userId": _userId,
          "username" : userCred.user!.displayName,
          "userEmailId" : userCred.user!.email,
        });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      showSnackbar(context, "Failed to Sign in using Google Account...");
    }
  }
}