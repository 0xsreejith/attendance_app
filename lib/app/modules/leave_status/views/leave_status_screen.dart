
import 'package:attendance_app/app/modules/leave_status/controller/leave_status_controller.dart';
import 'package:attendance_app/app/modules/leave_status/views/components/custom_calander.dart';
import 'package:attendance_app/app/modules/leave_status/views/components/leave_status_table.dart';
import 'package:attendance_app/app/widgets/custom_header.dart';
import 'package:attendance_app/app/widgets/my_holiday_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sales_graph/flutter_sales_graph.dart';
import 'package:get/get.dart';

class LeaveStatusScreen extends StatelessWidget {
  final LeaveStatusController controller = Get.put(LeaveStatusController());
  LeaveStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> leaveCards = [
      {
        'title': 'Leave Taken',
        'value': '16 days',
        'subtitle': '10 days remaining this month',
        'icon': Icons.check_circle_outline,
        'color': Colors.blueAccent,
      },
      {
        'title': 'Leave Balance',
        'value': '8 days',
        'subtitle': '29 days remaining this month',
        'icon': Icons.event_available,
        'color': Colors.green,
      },
      {
        'title': 'Pending Request',
        'value': '1 request',
        'subtitle': '29 days remaining this month',
        'icon': Icons.hourglass_empty,
        'color': Colors.orange,
      },
      {
        'title': 'Approved Leaves',
        'value': '5 leaves',
        'subtitle': '29 days remaining this month',
        'icon': Icons.verified,
        'color': Colors.teal,
      },
      {
        'title': 'Rejected Leaves',
        'value': '2 leaves',
        'subtitle': '29 days remaining this month',
        'icon': Icons.cancel_outlined,
        'color': Colors.redAccent,
      },
      {
        'title': 'Upcoming Leaves',
        'value': '1 leave',
        'subtitle': 'Scheduled (25 June)',
        'icon': Icons.upcoming,
        'color': Colors.deepPurple,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomHeader(),
              const SizedBox(height: 20),

              /// Grid of cards
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.3,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: leaveCards.map((item) {
                  final isLeaveTaken = item['title'] == 'Leave Taken';

                  return MyDashboardCard(
                    headText: item['title'],
                    mainDayText: item['value'],
                    subText: item['subtitle'],
                    icon: item['icon'],
                    iconColor: item['color'],
                    child: isLeaveTaken
                        ? Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: 16 / 26,
                                backgroundColor: Colors.grey[300],
                                color: item['color'],
                                minHeight: 6,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              /// Holiday calendar
              CustomHolidayCalendar(controller: controller),
              const SizedBox(height: 20),
              LeaveStatusTable(),
              const SizedBox(height: 20),

              /// leave overview
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    const Text(
                      "Leave Overview",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text("Your leave distribution for the current year"),
                    const SizedBox(height: 20),

                    /// Bar Chart
                    const SizedBox(
                      height: 120,
                      child: FlutterSalesGraph(
                        salesData: [
                          6,
                          5,
                          3,
                          2
                        ], // sample leave data per quarter
                        labels:  ['Q1', 'Q2', 'Q3', 'Q4'],
                        maxBarHeight: 100,
                        barWidth: 30.0,
                        colors: const [Colors.blue],
                        dateLineHeight: 20.0,
                      ),
                    ),
                    const SizedBox(height: 12),

                    /// Legend
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          "Leave days Taken",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('Total days'), Text("20")],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('Remaining days'), Text("29")],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
