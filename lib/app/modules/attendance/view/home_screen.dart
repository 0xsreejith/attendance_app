import 'package:attendance_app/app/modules/attendance/view/components/custom_btn.dart';
import 'package:attendance_app/app/modules/attendance/view/components/dashboard_card.dart';
import 'package:attendance_app/app/modules/attendance/view/components/over_view_card.dart';
import 'package:attendance_app/app/modules/attendance/view/components/tab_btn.dart';
import 'package:attendance_app/app/modules/attendance/controller/tab_navigation.dart';
import 'package:attendance_app/app/modules/attendance/view/widgets/custom_app_bar.dart';
import 'package:attendance_app/app/modules/attendance/view/widgets/my_tasks.dart';
import 'package:attendance_app/app/modules/attendance/view/widgets/ongoing_pending_tasks.dart';
import 'package:attendance_app/app/modules/attendance/view/widgets/task_tracker.dart';
import 'package:attendance_app/app/modules/attendance/view/widgets/work_summery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskTabController taskController = Get.put(TaskTabController());
  String selectedSort = "deadline";

  final List<Map<String, dynamic>> tabs = [
    {"title": "My Tasks", "icon": Icons.assignment},
    {"title": "Task Tracker", "icon": Icons.track_changes},
    {"title": "On Going & Pending Task", "icon": Icons.loop},
    {"title": "Work Summery", "icon": Icons.folder_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                      "Good Morning,",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    const Text(
                      "Hermant Rangarajan",
                      style: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),

                    // Check-in/out Section
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blue[35],
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "You are Checked-in 09:00 AM",
                            style: TextStyle(color: Colors.green, fontSize: 20),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.alarm,
                                color: Colors.orange,
                                size: 30,
                              ),
                              Text(
                                "09:20 am_11-06-2025",
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 30,
                              ),
                              Text(
                                "Location/IP (for remote attendance)",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
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
                    // Overview Cards
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
                    const SizedBox(height: 15),

                    // Tabs
                    Obx(() {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(tabs.length, (index) {
                            final tab = tabs[index];
                            return Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: TabButton(
                                text: tab["title"],
                                icon: tab["icon"],
                                isSelected:
                                    taskController.selectedTab.value == index,
                                onTap: () => taskController.changeTab(index),
                              ),
                            );
                          }),
                        ),
                      );
                    }),

                    const SizedBox(height: 10),

                    // Sort Options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sort by:",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: "deadline",
                              groupValue: selectedSort,
                              onChanged: (value) {
                                setState(() {
                                  selectedSort = value!;
                                });
                              },
                            ),
                            const Text("Deadline"),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: "project",
                              groupValue: selectedSort,
                              onChanged: (value) {
                                setState(() {
                                  selectedSort = value!;
                                });
                              },
                            ),
                            const Text("Project"),
                          ],
                        ),
                        Icon(Icons.settings, color: Colors.grey[600]),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Tab Content
                    Obx(() {
                      switch (taskController.selectedTab.value) {
                        case 0:
                          return MyTasks();
                        case 1:
                          return TaskTracker();
                        case 2:
                          return OngoingPendingTasks();
                        case 3:
                          return WorkSummery();
                        default:
                          return const SizedBox();
                      }
                    }),

                    const SizedBox(height: 20),

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
                          title: "Leave Status",
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
