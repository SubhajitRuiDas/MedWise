import 'package:flutter/material.dart';
import 'package:med_tech_app/utils/colors_util.dart';

class DisplayCard extends StatelessWidget {
  final Color cardColor;
  final String cardText;
  const DisplayCard({super.key, required this.cardColor, required this.cardText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            cardColor,
            bgColor2
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Get the best\n$cardText",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "We provide best quality\n$cardText in our platform.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5,),
          Expanded(
            flex: 1,
            child: Image.asset(
              "assets/images/doctor-with-his-arms-crossed-white-background.png",
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}