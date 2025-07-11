import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:med_tech_app/model/dr_model.dart';

class AppointmentBookingService {
  static final userId = FirebaseAuth.instance.currentUser!.uid;

  static Future<bool> bookDrAppointment(DrModel bookedDr, String appointmentDate) async{
    

    final appointmentsCollection = FirebaseFirestore.instance.collection("appointments").doc(userId)
    .collection(userId);

    final queryStatus = await appointmentsCollection.where(
      "drName", isEqualTo: bookedDr.doctorName
    ).get();

    if(queryStatus.docs.isNotEmpty){
      // means booking for this dr is already present
      return false;
    }

    // otherwise create booking for this dr
    await appointmentsCollection.doc(bookedDr.doctorName).set(
      {
        "drImage" : bookedDr.doctorImage,
        "drName" : bookedDr.doctorName,
        "drSpecialization" : bookedDr.doctorSpecialization,
        "drFees" : bookedDr.doctorFees,
        "appointmentDate" : appointmentDate,
      }
    );
    return true;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> bookedDrsSnapshotList() {
    return FirebaseFirestore.instance.collection("appointments")
    .doc(userId).collection(userId).snapshots();
  }
}
