import 'package:attendance_app/app/modules/attendance/components/dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/app/modules/attendance/components/custom_btn.dart';
import 'package:attendance_app/app/modules/attendance/components/over_view_card.dart';
import 'package:attendance_app/app/modules/attendance/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBar(),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "\"Good Morning,",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    const Text(
                      "Hermant Rangarajan\"",
                      style: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),

                    // Check-in/out Container
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blue[35],
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\"You haven't Checked-in yet\"",
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ),
                          SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomBtn(
                                text: "Check In",
                                color: Colors.blue,
                                iconColors: Colors.white,
                                textColors: Colors.white,
                              ),
                              SizedBox(width: 80),
                              CustomBtn(
                                text: "Check Out",
                                color: Colors.grey,
                                iconColors: Colors.white,
                                textColors: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      "Overview",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OverViewCard(
                          color: Colors.green,
                          number: "20",
                          text: "Presence",
                        ),
                        OverViewCard(
                          color: Colors.red,
                          number: "03",
                          text: "Absence",
                        ),
                        OverViewCard(
                          color: Colors.orange,
                          number: "02",
                          text: "Leaves",
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      "Dashboard",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Dashboard Card Grid
                    GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.85,
                      children: const [
                        DashboardCard(
                          icon: Icons.calendar_today_outlined,
                          iconColor: Colors.green,
                          title: "Attendance",
                        ),
                        DashboardCard(
                          icon: Icons.access_time,
                          iconColor: Colors.orange,
                          title: "Leaves",
                        ),
                        DashboardCard(
                          icon: Icons.circle,
                          iconColor: Colors.purple,
                          title: "Leave Satatus",
                        ),
                        DashboardCard(
                          icon: Icons.checklist,
                          iconColor: Colors.indigo,
                          title: "Holiday List",
                        ),
                        DashboardCard(
                          icon: Icons.payment_sharp,
                          iconColor: Colors.greenAccent,
                          title: "Payslip",
                        ),
                        DashboardCard(
                          icon: Icons.auto_graph_sharp,
                          iconColor: Colors.red,
                          title: "Reports",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
