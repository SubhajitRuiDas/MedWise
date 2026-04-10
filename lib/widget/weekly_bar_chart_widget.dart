import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyBarChartWidget extends StatelessWidget {
  final List<double> weeklyData;
  final int attributeIdentity;

  const WeeklyBarChartWidget({super.key, required this.weeklyData, required this.attributeIdentity});
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceEvenly,
        maxY: weeklyData.reduce((a, b) => a > b ? a : b) + 1000,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: _getInterval(),
          getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.shade300,
            strokeWidth: 1,
          );
          },
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: bottomTitles,
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true,
            interval: _getInterval(),
            reservedSize: 45,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style: const TextStyle(fontSize: 10),
              );
            },
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(
          weeklyData.length,
          (index) => BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: weeklyData[index],
                width: 18,
                borderRadius: BorderRadius.circular(6),
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.cyan],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Mon', style: style);
        break;
      case 1:
        text = const Text('Tue', style: style);
        break;
      case 2:
        text = const Text('Wed', style: style);
        break;
      case 3:
        text = const Text('Thu', style: style);
        break;
      case 4:
        text = const Text('Fri', style: style);
        break;
      case 5:
        text = const Text('Sat', style: style);
        break;
      case 6:
        text = const Text('Sun', style: style);
        break;
      default:
        text = const Text('');
    }
    return SideTitleWidget(
      meta: meta,
      space: 8,
      child: text,
    );
  }

  double _getMaxY() {
  double max = weeklyData.reduce((a, b) => a > b ? a : b);
  switch (attributeIdentity) {
    case 1: // eta steps
      return ((max / 2000).ceil() * 2000).toDouble();

    case 2: //  eta heart Rate
      return ((max / 20).ceil() * 20).toDouble();

    case 3: //  eta water drink
      return ((max / 500).ceil() * 500).toDouble();

    default:
      return max + (max * 0.2);
  }
}
double _getInterval() {
  double maxY = _getMaxY();

  switch (attributeIdentity) {
    case 1: // eta steps
      return 1000;

    case 2: //  eta heart Rate
      return 100;

    case 3: //  eta water drink
      return 500;

    default:
      return maxY / 5;
  }
}
}