import 'package:flutter/material.dart';
import 'package:flutter_sales_graph/flutter_sales_graph.dart';
import 'package:attendance_app/app/modules/leave/view/components/dashboard_card.dart';
import 'package:attendance_app/app/core/constannts/app_color.dart';

class LeaveDashboard extends StatelessWidget {
  const LeaveDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final leaveData = [5.0, 4.0, 3.0, 2.0];

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 2;
        if (constraints.maxWidth > 900) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 3;
        }

        return Scaffold(
          backgroundColor: Colors.grey[100],
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  MyDashboardCard(
                    headText: "Total Leave Taken",
                    dayText: "16 days",
                    subText: "29 days remaining this year",
                    icon: Icons.event_note,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: 20 / (20 + 29),
                          minHeight: 6,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
                        ),
                      ),
                    ),
                  ),
                  const MyDashboardCard(
                    headText: "Approval Rate",
                    dayText: "92%",
                    subText: "This year",
                    icon: Icons.verified,
                    child: SizedBox(),
                  ),
                  const MyDashboardCard(
                    headText: "Pending Request",
                    dayText: "1",
                    subText: "Waiting for manager",
                    icon: Icons.pending_actions,
                    child: SizedBox(),
                  ),
                  const MyDashboardCard(
                    headText: "Team Members on Leave",
                    dayText: "2",
                    subText: "Today",
                    icon: Icons.group,
                    child: SizedBox(),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text("Leave Overview", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              // Sales Graph
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 120,
                      child: FlutterSalesGraph(
                        salesData: leaveData,
                        labels: const ['Q1', 'Q2', 'Q3', 'Q4'],
                        maxBarHeight: 100,
                        barWidth: 30.0,
                        colors: const [Colors.blue],
                        dateLineHeight: 20.0,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: AppColor.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          "Leave days Taken",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
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

              const SizedBox(height: 24),
              const Text("Upcoming Leave", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text("You scheduled time off"),
              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Annual Leave", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      SizedBox(height: 4),
                      Text("Apr 22 - Apr 24, 2025 (3 days)", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text("Pending", style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(21),
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.orange),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pending Approval", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          SizedBox(height: 2),
                          Text("Your leave request is waiting manager approval.", style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
