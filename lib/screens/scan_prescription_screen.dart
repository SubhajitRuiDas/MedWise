import 'dart:io';

import 'package:flutter/material.dart';
import 'package:med_tech_app/utils/colors_util.dart';
import 'package:med_tech_app/widget/prescription_image_picker.dart';

class ScanPrescriptionScreen extends StatefulWidget {
  const ScanPrescriptionScreen({super.key});

  @override
  State<ScanPrescriptionScreen> createState() => _ScanPrescriptionScreenState();
}

class _ScanPrescriptionScreenState extends State<ScanPrescriptionScreen> {
  File? _pickedImage;
  String? _aiGeneratedText;

  void _storePickedImg(File img) async{
    setState(() {
      _pickedImage = img;
    });

    // later i will store this prescription to firebase
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
            onPressed: () {}, 
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor2,
              elevation: 20,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            ),
            child: Text("Ask AI", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),),
          ),
          const SizedBox(height: 15,),
          ElevatedButton(
            onPressed: () {}, 
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              elevation: 20,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            ),
            child: Text("Save", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),),
          ),
          const SizedBox(height: 30,),
          // if(_aiGeneratedText!.isNotEmpty)
          //   Text("AI generated text goes here", style: TextStyle(color: Colors.black),),
        ],
      );
  }
}