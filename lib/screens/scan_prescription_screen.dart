import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:med_tech_app/bloc/bloc/prescription_process_bloc.dart';
import 'package:med_tech_app/utils/colors_util.dart';
import 'package:med_tech_app/utils/show_snackbar.dart';
import 'package:med_tech_app/widget/prescription_image_picker.dart';

class ScanPrescriptionScreen extends StatefulWidget {
  const ScanPrescriptionScreen({super.key});

  @override
  State<ScanPrescriptionScreen> createState() => _ScanPrescriptionScreenState();
}

class _ScanPrescriptionScreenState extends State<ScanPrescriptionScreen> {
  File? _pickedImage;
  // String? _extractedText;

  void _storePickedImg(File img) async{
    setState(() {
      _pickedImage = img;
    });

    // later i will store this prescription to firebase
  }

  void _savePrescriptionDB() async{
    if(_pickedImage != null){
      // final _userId = FirebaseAuth.instance.currentUser!.uid;

      // final _storageRef = FirebaseStorage.instance.ref().child("prescriptions").child(_userId).child("${DateTime.now().millisecondsSinceEpoch}.jpg");
      // await _storageRef.putFile(_pickedImage!);

      // final _downloadImgUrl = await _storageRef.getDownloadURL();
      // await FirebaseFirestore.instance.collection("user").doc(_userId).collection("Prescriptions")
      // .add({
      //   "prescriptionUrl" : _downloadImgUrl,
      //   "uploadAt" : Timestamp.now(),
      // });

      // showSnackbar(context, "Prescription uploaded successfully");

      showSnackbar(context, "Prescription image is successfully attached but save function will not work");
    }
  }

  void _recognizePrescriptionTextAndAskAI() {
    if(_pickedImage == null) {
      showSnackbar(context, "Please attach your prescription image");
      return;
    }

    context.read<PrescriptionProcessBloc>().add(PrescriptionProcessClicked(imageFile: _pickedImage!));

    // final textRecognizer = TextRecognizer();
    // final RecognizedText recognizedText = await textRecognizer.processImage(InputImage.fromFile(_pickedImage!));

    // textRecognizer.close();
    // setState(() {
    //   _extractedText = recognizedText.text;
    // });
    // print(_extractedText);
  }
  @override
  Widget build(BuildContext context) {
    return
      // appBar: AppBar(
      //   title: Text("Scan prescription"),
      //   centerTitle: true,
      // ),
      // backgroundColor: Colors.white54,
      ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: buttonColor2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Please take a photo of your prescription\nor pick it from your gallery.\n(Upload only your prescription image.)",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20,),
                PrescriptionImagePicker(onPickImage: _storePickedImg),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: _recognizePrescriptionTextAndAskAI, 
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor2,
              elevation: 20,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            ),
            child: Text("Ask AI", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),),
          ),
          const SizedBox(height: 15,),
          ElevatedButton(
            onPressed: _savePrescriptionDB,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              elevation: 20,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            ),
            child: Text("Save", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),),
          ),
          const SizedBox(height: 25,),
          BlocBuilder<PrescriptionProcessBloc, PrescriptionProcessState>(
            builder: (context, state){
              if(state is PrescriptionProcessLoading){
                return CircularProgressIndicator();
              } else if(state is PrescriptionProcessSuccessful){
                return Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueGrey[200],
                  ),
                  child: Text(
                    state.aiGeneratedResponse,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                );
              } else if(state is PrescriptionProcessError){
                return Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueGrey[200],
                  ),
                  child: Text(
                    state.errorText,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.redAccent),
                  ),
                );
              }
              return SizedBox.shrink();
            }
          ),
        ],
      );
  }
}