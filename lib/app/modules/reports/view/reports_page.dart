import 'package:attendance_app/app/modules/reports/view/components/report_chart.dart' show AttendanceChart;
import 'package:attendance_app/app/modules/reports/view/components/report_table.dart';
import 'package:attendance_app/app/widgets/custom_dashboard_card.dart';
import 'package:attendance_app/app/widgets/custom_header.dart';
import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> reportData = [
      {
        'title': 'Total Working Days',
        'main': '22 days',
        'sub': '(this month)',
        'icon': Icons.calendar_month_outlined,
        'iconColor': Colors.blue,
      },
      {
        'title': 'Total Hours Worked',
        'main': '145 hrs',
        'sub': '',
        'icon': Icons.hourglass_empty_sharp,
        'iconColor': Colors.blue,
      },
      {
        'title': 'Task Completed',
        'main': '35',
        'sub': 'this month',
        'icon': Icons.check_circle_outline,
        'iconColor': Colors.blue,
      },
      {
        'title': 'Average Daily Hours',
        'main': '6.6',
        'sub': 'hrs/day',
        'icon': Icons.alarm_on,
        'iconColor': Colors.blue,
      },
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomHeader(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Reports",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: reportData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isTablet ? 3 : 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 4 / 3,
                  ),
                  itemBuilder: (context, index) {
                    final data = reportData[index];
                    return MyDashboardCard(
                      headText: data['title'],
                      mainDayText: data['main'],
                      subDayText: data['sub'],
                      icon: data['icon'],
                      iconColor: data['iconColor'],
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ClockInTable(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: AttendanceChart(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
