import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AttendanceChart extends StatelessWidget {
  const AttendanceChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Attendance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Legend Row
            Row(
              children: [
                _buildLegendItem(color: Colors.green, label: 'Present'),
                const SizedBox(width: 12),
                _buildLegendItem(color: Colors.red, label: 'Absent'),
                const SizedBox(width: 12),
                _buildLegendItem(color: Colors.blue, label: 'Avg Hours'),
              ],
            ),
            const SizedBox(height: 10),
            // Chart
            SizedBox(
              height: 200,
              width: constraints.maxWidth,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 12,
                  gridData: const FlGridData(
                    show: true,
                    horizontalInterval: 2,
                    drawVerticalLine: true,
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                        reservedSize: 32,
                        interval: 2,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toStringAsFixed(0),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          const months = [
                            'Jan',
                            'Feb',
                            'Mar',
                            'Apr',
                            'May',
                            'Jun',
                            'Jul',
                            'Aug',
                            'Sep',
                            'Oct',
                            'Nov',
                            'Dec'
                          ];
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              months[value.toInt() % 12],
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    // Present Line (Green)
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 7),
                        const FlSpot(1, 8),
                        const FlSpot(2, 6),
                        const FlSpot(3, 9),
                        const FlSpot(4, 7.5),
                        const FlSpot(5, 8),
                        const FlSpot(6, 9),
                        const FlSpot(7, 8.5),
                        const FlSpot(8, 9.2),
                        const FlSpot(9, 9.5),
                        const FlSpot(10, 10),
                        const FlSpot(11, 10.5),
                      ],
                      color: Colors.green,
                      barWidth: 1,
                      dotData: const FlDotData(show: true),
                    ),

                    // Absent Line (Red)
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 3),
                        const FlSpot(1, 2.5),
                        const FlSpot(2, 4),
                        const FlSpot(3, 3),
                        const FlSpot(4, 3.5),
                        const FlSpot(5, 2.8),
                        const FlSpot(6, 3.2),
                        const FlSpot(7, 3),
                        const FlSpot(8, 3.5),
                        const FlSpot(9, 3.8),
                        const FlSpot(10, 3),
                        const FlSpot(11, 2.5),
                      ],
                      color: Colors.red,
                      barWidth: 1,
                      dotData: const FlDotData(show: true),
                    ),

                    // Avg Hours Line (Blue)
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 5),
                        const FlSpot(1, 5.5),
                        const FlSpot(2, 6),
                        const FlSpot(3, 6.2),
                        const FlSpot(4, 5.8),
                        const FlSpot(5, 6.5),
                        const FlSpot(6, 6.7),
                        const FlSpot(7, 6.3),
                        const FlSpot(8, 6.8),
                        const FlSpot(9, 7),
                        const FlSpot(10, 7.2),
                        const FlSpot(11, 7),
                      ],
                      color: Colors.blue,
                      barWidth: 1,
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLegendItem({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
