import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PrescriptionImagePicker extends StatefulWidget {
  final void Function(File userPickedImage) onPickImage;
  const PrescriptionImagePicker({super.key, required this.onPickImage});

  @override
  State<PrescriptionImagePicker> createState() => _PrescriptionImagePickerState();
}

class _PrescriptionImagePickerState extends State<PrescriptionImagePicker> {
  File? _pickedImage;
  void _pickImgFunc() async{
    final pickedImg = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 50);
    if(pickedImg == null){
      return;
    } 
    setState(() {
      _pickedImage = File(pickedImg.path);
    });

    widget.onPickImage(_pickedImage!);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                  onTap: _pickImgFunc,
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width - 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: _pickedImage != null ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        _pickedImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ) : Center(
                      child: Image.asset(
                        "assets/images/take-a-photo.png",
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
  }
}