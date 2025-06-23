import 'package:attendance_app/app/modules/attendance_punch/controller/check_in_check_out_controller.dart';
import 'package:attendance_app/app/modules/home/controller/tab_navigation.dart';
import 'package:attendance_app/app/modules/home/controller/task_controller.dart';
import 'package:attendance_app/app/modules/home/view/components/my_tasks.dart';
import 'package:attendance_app/app/modules/home/view/components/ongoing_pending_tasks.dart';
import 'package:attendance_app/app/widgets/custom_btn.dart';
import 'package:attendance_app/app/modules/home/view/components/dashboard_card.dart';
import 'package:attendance_app/app/modules/home/view/components/over_view_card.dart';
import 'package:attendance_app/app/modules/home/view/components/tab_btn.dart';
import 'package:attendance_app/app/widgets/custom_app_bar.dart';
import 'package:attendance_app/app/modules/home/view/components/task_tracker.dart';
import 'package:attendance_app/app/modules/home/view/components/work_summery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Make controllers persistent
  final PunchInPunchOutController punchController =
      Get.put(PunchInPunchOutController());

  final TaskController taskController = Get.find<TaskController>();
  final TaskTabController tabController = Get.find<TaskTabController>();
  String selectedSort = "deadline";

  final List<Map<String, dynamic>> tabs = [
    {"title": "My Tasks", "icon": Icons.assignment},
    {"title": "Task Tracker", "icon": Icons.track_changes},
    {"title": "On Going & Pending Task", "icon": Icons.loop},
    {"title": "Work Summery", "icon": Icons.folder_outlined},
  ];

  // Helper function to format date time
  String formatDateTime(String isoTime) {
    try {
      final dt = DateTime.parse(isoTime);
      final time = DateFormat('hh:mm a').format(dt);
      final date = DateFormat('dd-MM-yyyy').format(dt);
      return "$time\n$date";
    } catch (e) {
      return isoTime;
    }
  }

  void _showPunchInOptionDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Add top space for close button
                  const SizedBox(height: 30),
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
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        child: const Text("Work From Home",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Close button at top right
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.close, size: 24),
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCheckoutDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Add top space for close button
                  const SizedBox(height: 30),
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
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300]),
                        child: const Text("Update Task"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                          // Call punchOut before navigation
                          punchController.punchOut();
                          Get.toNamed("/checkIn", arguments: {
                            "isCheckIn": false,
                            "isOnsite": punchController.isOnsite.value,
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        child: const Text("Continue",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Close button at top right
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.close, size: 24),
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckInSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double fontSize = screenWidth < 400 ? 16 : 20;
        double iconTextFontSize = screenWidth < 400 ? 14 : 18;

        return Obx(() {
          final isPunchedIn = punchController.isPunchedIn.value;
          final punchInTime = punchController.punchInTime.value;
          final punchOutTime = punchController.punchOutTime.value;
          final location = punchController.punchLocation.value;

          // Extract time parts
          String inTime = punchInTime.isNotEmpty
              ? formatDateTime(punchInTime).split('\n')[0]
              : "";
          String outTime = punchOutTime.isNotEmpty
              ? formatDateTime(punchOutTime).split('\n')[0]
              : "";

          // Determine status
          String statusText;
          Color statusColor;
          if (isPunchedIn) {
            statusText = "You are Checked-in at $inTime";
            statusColor = Colors.green;
          } else if (punchOutTime.isNotEmpty) {
            statusText = "You haven't punched in yet!";
            statusColor = Colors.red;
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
                Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                if (isPunchedIn || punchOutTime.isNotEmpty) ...[
                  if (punchInTime.isNotEmpty)
                    Row(
                      children: [
                        const Icon(Icons.alarm, color: Colors.orange),
                        const SizedBox(width: 10),
                        Text(
                          formatDateTime(punchInTime).split('\n')[1],
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: iconTextFontSize,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(fontSize: iconTextFontSize),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomBtn(
                        onTap: () {
                          if (!isPunchedIn) {
                            _showPunchInOptionDialog(Get.context!);
                          }
                        },
                        text: "Punch In",
                        color: isPunchedIn ? Colors.grey.shade400 : Colors.blue,
                        iconColors: Colors.white,
                        textColors: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomBtn(
                        onTap: () {
                          if (isPunchedIn) {
                            _showCheckoutDialog();
                          }
                        },
                        text: "Punch Out",
                        color: isPunchedIn ? Colors.blue : Colors.grey.shade300,
                        iconColors: Colors.white,
                        textColors: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CustomAppBar(),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            color: Colors.green,
                            number: "20",
                            text: "Presence"),
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
                                isSelected:
                                    tabController.selectedTab.value == index,
                                onTap: () => tabController.changeTab(index),
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
                      switch (tabController.selectedTab.value) {
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
                    LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = 3;
                        if (constraints.maxWidth > 900) {
                          crossAxisCount = 4;
                        } else if (constraints.maxWidth > 600) {
                          crossAxisCount = 3;
                        }

                        return LayoutBuilder(
                          builder: (context, constraints) {
                            int crossAxisCount;

                            if (constraints.maxWidth >= 1200) {
                              crossAxisCount = 5; // Desktop
                            } else if (constraints.maxWidth >= 800) {
                              crossAxisCount = 4; // Tablet
                            } else {
                              crossAxisCount =
                                  3; // Mobile (default to 3 per row)
                            }

                            return GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.75,
                              children: [
                                DashboardCard(
                                  icon: Icons.calendar_today_outlined,
                                  iconColor: Colors.green,
                                  title: "Attendance",
                                  onTap: () => Get.toNamed("/attendance"),
                                ),
                                DashboardCard(
                                  onTap: () => Get.toNamed("/leave"),
                                  icon: Icons.access_time,
                                  iconColor: Colors.orange,
                                  title: "Leaves",
                                ),
                                const DashboardCard(
                                  icon: Icons.circle,
                                  iconColor: Colors.purple,
                                  title: "Leave Status",
                                ),
                                const DashboardCard(
                                  icon: Icons.checklist,
                                  iconColor: Colors.indigo,
                                  title: "Holiday List",
                                ),
                                const DashboardCard(
                                  icon: Icons.payment_sharp,
                                  iconColor: Colors.greenAccent,
                                  title: "Payslip",
                                ),
                                const DashboardCard(
                                  icon: Icons.auto_graph_sharp,
                                  iconColor: Colors.red,
                                  title: "Reports",
                                ),
                              ],
                            );
                          },
                        );
                      },
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
