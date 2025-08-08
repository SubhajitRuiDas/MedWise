import 'package:flutter/material.dart';
import 'package:med_tech_app/screens/tracking_stats_screen.dart';
import 'package:med_tech_app/utils/colors_util.dart';

class HealthTrackingServiceCard extends StatelessWidget {
  final Color cardColor;
  final int identity;
  final String healthAttribute;
  final String attributeImage;
  const HealthTrackingServiceCard(
    { super.key, 
      required this.cardColor, 
      required this.identity,
      required this.healthAttribute, 
      required this.attributeImage
    }
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 400,
      child: Card(
        margin: EdgeInsets.only(bottom: 10.0),
        color: cardColor,
        elevation: 2.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(attributeImage, fit: BoxFit.fitHeight,),
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      healthAttribute,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.grey.shade300
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (builder)=> TrackingStatsScreen(attributeIdentity: identity,)));
                      }, 
                      child: Text(
                        "Track Now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: bgColor2
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}