import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_tech_app/repository/firebase/appointment_booking_service.dart';
import 'package:med_tech_app/utils/colors_util.dart';

class BookedAppointmentsScreen extends StatelessWidget {
  const BookedAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointments"),
        backgroundColor: homeScreenBg,
        elevation: 5,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: AppointmentBookingService.bookedDrsSnapshotList(), 
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
            return Center(child: Text("No appointments booked"),);
          }

          final appointmentList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: appointmentList.length,
            itemBuilder: (context, index) {
              final currData = appointmentList[index].data();
              return Card(
                elevation: 2,
                color: const Color.fromARGB(255, 201, 232, 247),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: CircleAvatar(
                    backgroundColor: Colors.lightBlueAccent,
                    radius: 30.0,
                    child: Image.asset("assets/images/doctor-with-his-arms-crossed-white-background.png"),
                  ),
                  title: Text(currData["drName"], style: Theme.of(context).textTheme.titleMedium,),
                  subtitle: Text("${currData["drSpecialization"]}\n${currData["appointmentDate"]}", style: Theme.of(context).textTheme.labelLarge,),
                  trailing: Chip(
                    label: Text(currData["drFees"].toString()),
                    labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                    backgroundColor: Colors.lightBlueAccent,
                    padding: EdgeInsets.all(10),
                    side: BorderSide(color: Colors.black54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  isThreeLine: true,
                ),
              );
            });
        },
      ),
    );
  }
}



/*
"drImage" : bookedDr.doctorImage,
        "drName" : bookedDr.doctorName,
        "drSpecialization" : bookedDr.doctorSpecialization,
        "drFees" : bookedDr.doctorFees,
        "appointmentDate" : appointmentDate,
*/