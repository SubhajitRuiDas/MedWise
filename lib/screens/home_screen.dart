import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_tech_app/model/dr_model.dart';
import 'package:med_tech_app/screens/chat_with_model_screen.dart';
import 'package:med_tech_app/screens/dr_appointment_booking_screen.dart';
import 'package:med_tech_app/screens/scan_prescription_screen.dart';
import 'package:med_tech_app/utils/colors_util.dart';
import 'package:med_tech_app/utils/dr_data_list.dart';
import 'package:med_tech_app/utils/user_details.dart';
import 'package:med_tech_app/widget/display_card.dart';
import 'package:med_tech_app/widget/main_side_drawer.dart';
import 'package:med_tech_app/widget/service_container.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedScreen = 0;
  String username ="";

  String selectedFilter = "";
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

  Widget _selectCurrentScreenBasedOnBottomNavbar(){
    if(_selectedScreen == 0){
      return _homeScreenContent();
    } else if(_selectedScreen == 1){
      return const ChatWithModelScreen();
    } else {
      return const ScanPrescriptionScreen();
    }
  }

  Widget _homeScreenContent(){
    return ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.vertical,
        children: [
          Text("Services", textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35, color: bgColor2),),
          const SizedBox(height: 10,),
          SizedBox(
            height: 120,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              children: [
                ServiceContainer(img: "assets/images/health-monitor.png", underlineTxt: "Health Checkup"),
                SizedBox(width: 16,),
                ServiceContainer(img: "assets/images/online-appointment.png", underlineTxt: "Dr. Appoinment"),
                SizedBox(width: 16,),
                ServiceContainer(img: "assets/images/medical-app.png", underlineTxt: "Health Assistant"),
                SizedBox(width: 16,),
                ServiceContainer(img: "assets/images/doctor-with-his-arms-crossed-white-background.png", underlineTxt: "AI Assistant"),
              ],
            ),
          ),
          const SizedBox(height: 20,),
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
          Text("Categories", textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35, color: bgColor2),),
          SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: doctors_specialization_category.length,
                itemBuilder: (context, index) {
                  final filter = doctors_specialization_category[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                      child: Chip(
                        label: Text(filter),
                        labelStyle: const TextStyle(
                          fontSize: 16,
                        ),
                        backgroundColor: selectedFilter == filter ? buttonColor2
                        : const Color.fromARGB(255, 227, 234, 241),
                        side: const BorderSide(
                          color: Color.fromRGBO(245, 247, 249, 1),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              height: 400,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: doctors_list_data.length,
                itemBuilder: (context, index) {
                  final doctor = doctors_list_data[index];
                  return Card(
                    elevation: 3,
                    color: Color.fromARGB(255, 232, 237, 242),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/doctor-with-his-arms-crossed-white-background.png"),
                      ),
                      title: Text(doctor["doctorName"]),
                      subtitle: Text("${doctor["doctorSpecialization"]}\n⭐${doctor["doctorRatings"]}"),
                      trailing: TextButton(
                        onPressed: (){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => DrAppointmentBookingScreen(
                              currDr: DrModel(
                                doctorImage: doctor["doctorImage"] as String, 
                                doctorRatings: doctor["doctorRatings"] as double, 
                                doctorName: doctor["doctorName"] as String, 
                                doctorSpecialization: doctor["doctorSpecialization"] as String,
                                doctorFees: doctor["doctorFees"] as int),
                              ),
                            ),
                          );
                        }, 
                        child: Text("View Details"),
                      ),
                    ),
                  );
                }),
            ),
        ],
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Hello!\n$username",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: homeScreenBg,
        elevation: 2,
      ),
      drawer: MainSideDrawer(),
      body: _selectCurrentScreenBasedOnBottomNavbar(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _selectedScreen = value;
          });
        },
        selectedItemColor: bgColor2,
        currentIndex: _selectedScreen,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.document_scanner), label: "Scan"),
        ],
        backgroundColor: homeScreenBg,
      ),
    );
  }
}