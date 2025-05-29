import 'package:flutter/material.dart';

class ServiceContainer extends StatelessWidget {
  final Color bgColor;
  final String img;
  final String underlineTxt;
  const ServiceContainer({super.key, required this.bgColor, required this.img, required this.underlineTxt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: 100,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.only(right: 15),
      child: Center(
        child: Column(
          children: [
            Image.asset(img, fit: BoxFit.contain,),
            Text(underlineTxt, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}