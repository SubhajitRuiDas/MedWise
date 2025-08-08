import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:med_tech_app/widget/fl_chart_line_graph.dart';

class TrackingStatsScreen extends StatefulWidget{
  final int attributeIdentity;
  const TrackingStatsScreen({super.key, required this.attributeIdentity});

  @override
  State<TrackingStatsScreen> createState() => _TrackingStatsScreenState();
}

class _TrackingStatsScreenState extends State<TrackingStatsScreen> {
  late final String attributeText;
  late final String imagePath;
  String _selectedView = "Week"; // by default selected
  @override
  void initState() {
    super.initState();
    switch (widget.attributeIdentity) {
      case 1:
        attributeText = "Footstep 🏃";
        imagePath = "assets/images/run-icon.png";
        break;
      case 2:
        attributeText = "Heart Rate ❤️";
        imagePath = "assets/images/heartbeat.png";
        break;
      case 3:
        attributeText = "Hydration 💧";
        imagePath = "assets/images/water-bottle.png";
        break;
      default: 
        attributeText = "Health tracking";
        imagePath = "";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          attributeText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Image.asset(imagePath, fit: BoxFit.contain,),
            ),

            const SizedBox(height: 16.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text("Week"), 
                  selected: _selectedView == "Week",
                  onSelected: (value) {
                    setState(() {
                      _selectedView = "Week";
                    });
                  },
                ),
                const SizedBox(width: 10.0,),
                ChoiceChip(
                  label: const Text("Month"), 
                  selected: _selectedView == "Month",
                  onSelected: (value) {
                    setState(() {
                      _selectedView = "Month";
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // placeholder for graph plotting pora korbo
            // Container(
            //   height: 400,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: Colors.blue.shade200,
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   alignment: Alignment.center,
            //   child: Text(
            //     '$_selectedView statistics will be displayed here',
            //     style: const TextStyle(fontSize: 16),
            //   ),
            // ),
            FlChartLineGraph(
              dataPoints: [
                FlSpot(0, 4200),
                FlSpot(1, 2000),
                FlSpot(2, 3500),
                FlSpot(3, 4000),
              ], 
              yLabelUnit: "Steps",
            ),

            const SizedBox(height: 15),

            if (_selectedView == 'Week')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Add Value",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter your today's value",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // handle value submit
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}