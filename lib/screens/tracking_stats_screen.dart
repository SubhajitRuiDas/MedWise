import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widget/weekly_bar_chart_widget.dart';
import '../repository/database/fitness_db_helper.dart';

class TrackingStatsScreen extends StatefulWidget {
  final int attributeIdentity;
  const TrackingStatsScreen({super.key, required this.attributeIdentity});

  @override
  State<TrackingStatsScreen> createState() => _TrackingStatsScreenState();
}

class _TrackingStatsScreenState extends State<TrackingStatsScreen> {

  final TextEditingController inputController = TextEditingController();

  late String attributeText;
  late String imagePath;
  late String inputLabel;
  late String unitHint;

  String _selectedView = "Week";

  List<double> weeklyData = [];

  @override
  void initState() {
    super.initState();

    switch (widget.attributeIdentity) {
      case 1:
        attributeText = "Footstep 🏃";
        imagePath = "assets/images/run-icon.png";
        inputLabel = "Enter today's steps";
        unitHint = "Steps (e.g. 5000)";
        break;
      case 2:
        attributeText = "Heart Rate ❤️";
        imagePath = "assets/images/heartbeat.png";
        inputLabel = "Enter heart rate";
        unitHint = "BPM (e.g. 80)";
        break;
      case 3:
        attributeText = "Hydration 💧";
        imagePath = "assets/images/water-bottle.png";
        inputLabel = "Enter water intake";
        unitHint = "Water (ml)";
        break;
      default:
        attributeText = "Health Tracking";
        imagePath = "";
        inputLabel = "Enter value";
        unitHint = "";
    }

    loadWeeklyStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(attributeText,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue[300],
      ),
      backgroundColor: Colors.blue.shade50,

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Image.asset(imagePath),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text("Week", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                  selected: _selectedView == "Week",
                  selectedColor: Colors.blue[300],
                  onSelected: (_) {
                    setState(() {
                      _selectedView = "Week";
                    });
                  },
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: const Text("Month", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                  selected: _selectedView == "Month",
                  selectedColor: Colors.blue[300],
                  onSelected: (_) {
                    setState(() {
                      _selectedView = "Month";
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_selectedView == "Week")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inputLabel,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: inputController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: unitHint,
                      prefixIcon: const Icon(Icons.edit),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[300],
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () async {
                        if (inputController.text.isEmpty) return;
                        int value = int.parse(inputController.text);
                        String type;
                        if (widget.attributeIdentity == 1) {
                          type = "steps";
                        } else if (widget.attributeIdentity == 2) {
                          type = "heart";
                        } else {
                          type = "water";
                        }
                        await FitnessDbHelper.insertData({
                          "type": type,
                          "value": value,
                          "date": DateFormat('yyyy-MM-dd')
                              .format(DateTime.now())
                        });
                        inputController.clear();
                        await loadWeeklyStats();
                      },
                      child: const Text("Save Entry", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Statistics",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Weekly Progress",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),
                  Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: weeklyData.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : WeeklyBarChartWidget(weeklyData: weeklyData, attributeIdentity: widget.attributeIdentity),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
  Future<void> loadWeeklyStats() async {
    String type;
    if (widget.attributeIdentity == 1) {
      type = "steps";
    } else if (widget.attributeIdentity == 2) {
      type = "heart";
    } else {
      type = "water";
    }
    var dbData = await FitnessDbHelper.getWeeklyData(type);
    weeklyData = convertToWeeklyList(dbData);
    setState(() {});
  }
  List<double> convertToWeeklyList(List<Map<String, dynamic>> dbData) {
    List<double> weekData = List.filled(7, 0);
    for (var row in dbData) {
      DateTime date = DateTime.parse(row["date"]);
      int index = date.weekday - 1;
      weekData[index] = (row["value"] as int).toDouble();
    }
    return weekData;
  }
}