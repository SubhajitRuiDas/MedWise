import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FlChartLineGraph extends StatelessWidget {
  final List<FlSpot> dataPoints;
  final String yLabelUnit; // e.g. "steps", "bpm", "ml"

  const FlChartLineGraph({
    super.key,
    required this.dataPoints,
    required this.yLabelUnit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    "${value.toInt()} $yLabelUnit",
                    style: const TextStyle(fontSize: 12),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text("Day ${value.toInt()}");
                },
              ),
            ),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: dataPoints,
              isCurved: true,
              barWidth: 4,
              color: Colors.blue,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: true, color: const Color.fromARGB(255, 71, 106, 136)),
            ),
          ],
        ),
      ),
    );
  }
}
