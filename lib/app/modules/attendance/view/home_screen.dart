import 'package:attendance_app/app/modules/attendance/controller/check_in_check_out_controller.dart';
import 'package:attendance_app/app/modules/attendance/controller/tab_navigation.dart';
import 'package:attendance_app/app/modules/attendance/view/components/custom_btn.dart';
import 'package:attendance_app/app/modules/attendance/view/components/dashboard_card.dart';
import 'package:attendance_app/app/modules/attendance/view/components/over_view_card.dart';
import 'package:attendance_app/app/modules/attendance/view/components/tab_btn.dart';
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
  final PunchInPunchOutController punchController =
      Get.put(PunchInPunchOutController());
  final TaskTabController taskController = Get.put(TaskTabController());
  String selectedSort = "deadline";

  final List<Map<String, dynamic>> tabs = [
    {"title": "My Tasks", "icon": Icons.assignment},
    {"title": "Task Tracker", "icon": Icons.track_changes},
    {"title": "On Going & Pending Task", "icon": Icons.loop},
    {"title": "Work Summery", "icon": Icons.folder_outlined},
  ];

  void _showPunchInOptionDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Select Punch-In Type",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 8),
              const Text("Are you working from home or onsite today?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      punchController.punchIn(isOnsite: true);
                      Get.back();
                      Get.toNamed("/checkIn", arguments: {
                        "isCheckIn": true,
                        "isOnsite": true,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300]),
                    child: const Text("On Site",
                        style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      punchController.punchIn(isOnsite: false);
                      Get.back();
                      Get.toNamed("/checkIn", arguments: {
                        "isCheckIn": true,
                        "isOnsite": false,
                      });
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text("Work From Home",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCheckoutDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning_amber_rounded,
                  size: 60, color: Colors.orange),
              const SizedBox(height: 16),
              const Text("Do you really want to",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange)),
              const Text("check out!",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Get.back(), // Close dialog
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300]),
                    child: const Text("Update Task"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back(); // Close the dialog
                      // Navigate to punch screen for check-out
                      Get.toNamed("/checkIn", arguments: {
                        "isCheckIn": false,
                        "isOnsite": punchController.isOnsite.value,
                      });
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text("Continue",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckInSection() {
    return Obx(() {
      final isPunchedIn = punchController.isPunchedIn.value;
      final punchInTime = punchController.punchInTime.value;
      final punchOutTime = punchController.punchOutTime.value;
      final location = punchController.punchLocation.value;

      // Determine text and color based on punch state
      String statusText;
      Color statusColor;
      if (isPunchedIn) {
        statusText = "You are Checked-in $punchInTime";
        statusColor = Colors.green;
      } else if (punchOutTime.isNotEmpty) {
        statusText = "You are Checked-out $punchOutTime";
        statusColor = Colors.blue;
      } else {
        statusText = "You haven't punched in yet!";
        statusColor = Colors.red;
      }

      return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue.shade50,
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status text with dynamic color
            Text(statusText,
                style: TextStyle(
                    color: statusColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            
            if (isPunchedIn) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.alarm, color: Colors.orange),
                  const SizedBox(width: 10),
                  Text(punchInTime,
                      style: const TextStyle(
                          color: Colors.orange, fontSize: 20)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.red),
                  const SizedBox(width: 10),
                  Text(location, style: const TextStyle(fontSize: 20)),
                ],
              ),
            ] else if (punchOutTime.isNotEmpty) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.alarm, color: Colors.blue),
                  const SizedBox(width: 10),
                  Text(punchOutTime,
                      style: const TextStyle(
                          color: Colors.blue, fontSize: 20)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.blue),
                  const SizedBox(width: 10),
                  Text(location, style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  )),
                ],
              ),
            ],
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomBtn(
                  onTap: () {
                    if (!isPunchedIn) _showPunchInOptionDialog(Get.context!);
                  },
                  text: "Punch In",
                  color: isPunchedIn ? Colors.grey.shade400 : Colors.blue,
                  iconColors: Colors.white,
                  textColors: Colors.white,
                ),
                const SizedBox(width: 80),
                CustomBtn(
                  onTap: () {
                    if (isPunchedIn) _showCheckoutDialog();
                  },
                  text: "Punch Out",
                  color: isPunchedIn ? Colors.blue : Colors.grey.shade300,
                  iconColors: Colors.white,
                  textColors: Colors.white,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const SizedBox(height: 10),
              const Text("Good Morning,",
                  style: TextStyle(color: Colors.grey, fontSize: 20)),
              const Text("Hermant Rangarajan",
                  style: TextStyle(fontSize: 24, color: Colors.grey)),
              const SizedBox(height: 20),
              _buildCheckInSection(),
              const SizedBox(height: 20),
              const Text("Overview",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22)),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OverViewCard(
                      color: Colors.green, number: "20", text: "Presence"),
                  OverViewCard(
                      color: Colors.red, number: "03", text: "Absence"),
                  OverViewCard(
                      color: Colors.orange, number: "02", text: "Leaves"),
                ],
              ),
              const SizedBox(height: 15),
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
                          isSelected: taskController.selectedTab.value == index,
                          onTap: () => taskController.changeTab(index),
                        ),
                      );
                    }),
                  ),
                );
              }),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sort by:",
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold)),
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
              Obx(() {
                switch (taskController.selectedTab.value) {
                  case 0:
                    return const MyTasks();
                  case 1:
                    return const TaskTracker();
                  case 2:
                    return const OngoingPendingTasks();
                  case 3:
                    return const WorkSummery();
                  default:
                    return const SizedBox();
                }
              }),
              const SizedBox(height: 20),
              const Text("Dashboard",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22)),
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
                      title: "Attendance"),
                  DashboardCard(
                      icon: Icons.access_time,
                      iconColor: Colors.orange,
                      title: "Leaves"),
                  DashboardCard(
                      icon: Icons.circle,
                      iconColor: Colors.purple,
                      title: "Leave Status"),
                  DashboardCard(
                      icon: Icons.checklist,
                      iconColor: Colors.indigo,
                      title: "Holiday List"),
                  DashboardCard(
                      icon: Icons.payment_sharp,
                      iconColor: Colors.greenAccent,
                      title: "Payslip"),
                  DashboardCard(
                      icon: Icons.auto_graph_sharp,
                      iconColor: Colors.red,
                      title: "Reports"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}