import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  const TextFormFieldWidget({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
                          decoration: InputDecoration(
                            hintText: hintText,
                            hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(strokeAlign: BorderSide.strokeAlignCenter),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                            ), 
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          onSaved: (newValue) {
                            
                          },
                        );
  }
}