import 'package:flutter/material.dart';
import 'package:med_tech_app/widget/health_tracking_service_card.dart';

class HealthAttributesTrackingScreen extends StatelessWidget{
  const HealthAttributesTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Track your ❤️\nhealth habits", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
          const SizedBox(height: 20,),
          Column(
            children: [
              HealthTrackingServiceCard(
                cardColor: Colors.deepPurple.shade300,
                identity: 1, 
                healthAttribute: "Footstep 🏃\nTrack your daily steps to stay active and reach your fitness goals.", 
                attributeImage: "assets/images/run.png",),
              const SizedBox(height: 10,),
              HealthTrackingServiceCard(
                cardColor: Colors.black38, 
                identity: 2,
                healthAttribute: "Heart Rate ❤️\nMonitor your heart rate regularly for a healthier lifestyle.", 
                attributeImage: "assets/images/pulse.png",),
              const SizedBox(height: 10,),
              HealthTrackingServiceCard(
                cardColor: Colors.blueGrey, 
                identity: 3,
                healthAttribute: "Hydration 💧Keep track of your daily water intake and stay hydrated.", 
                attributeImage: "assets/images/water.png",),
              const SizedBox(height: 10,),
            ],
          ),
        ],
      ),
    );
  }
}