import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AttendancePieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
                color: Colors.green,
                value: 20,
                title: "20\nDays",
                radius: 50,
                titleStyle: const TextStyle(color: Colors.white)),
            PieChartSectionData(
                color: Colors.red,
                value: 3,
                title: "03\nDays",
                radius: 50,
                titleStyle: const TextStyle(color: Colors.white)),
            PieChartSectionData(
                color: Colors.orange,
                value: 2,
                title: "02\nDays",
                radius: 50,
                titleStyle: const TextStyle(color: Colors.white)),
            PieChartSectionData(
                color: Colors.blue,
                value: 6,
                title: "06\nDays",
                radius: 50,
                titleStyle: const TextStyle(color: Colors.white)),
          ],
          centerSpaceRadius: 40,
          sectionsSpace: 1,
        ),
      ),
    );
  }
}
