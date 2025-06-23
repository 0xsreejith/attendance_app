import 'package:attendance_app/app/modules/attendance/view/components/custom_list_tile.dart';
import 'package:attendance_app/app/modules/attendance/view/components/pie_chart.dart';
import 'package:attendance_app/app/modules/attendance/view/components/summery_card.dart';
import 'package:attendance_app/app/modules/attendance_history/controller/attendance_controller.dart';
import 'package:attendance_app/app/modules/attendance_history/view/calander_view.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceScreen extends StatelessWidget {
  final AttendanceController controller = Get.find<AttendanceController>();
  AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Attendance Overview"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar First
            const Text("Calendar View",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            CalendarView(controller: controller),

            const SizedBox(height: 24),
            //overview section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        offset: const Offset(4.0, 4.0),
                        spreadRadius: 1,
                        blurRadius: 4.0,
                      ),
                      BoxShadow(
                        color: Colors.grey.shade200,
                        offset: const Offset(-4.0, -4.0),
                        spreadRadius: 1,
                        blurRadius: 4.0,
                      )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Overview",
                        style:
                            TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const Text("Total Days: 31",
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    const SizedBox(height: 16),
              
                    // Summary Cards
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SummaryCard(
                            title: "Presence", value: "20", color: Colors.green),
                        SummaryCard(
                            title: "Absence", value: "03", color: Colors.red),
                        SummaryCard(
                            title: "Leaves", value: "02", color: Colors.orange),
                        SummaryCard(
                            title: "Late", value: "06", color: Colors.blue),
                      ],
                    ),
              
                    const SizedBox(height: 24),
                    // Pie Chart
                    AttendancePieChart(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "June 18, 2025",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Status",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                    stringContainer(
                        "Present", Colors.green, Colors.green.shade100)
                  ],
                ),
                const SizedBox(height: 10),
                //dotted divider
                const DottedLine(
                  dashLength: 4,
                  dashColor: Colors.grey,
                ),
                const SizedBox(height: 10),
                //check-in and check-out times
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    checkTime("Check-in", "09:30 AM", Icons.alarm),
                    // Divider + Arrow
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                                child:
                                    Divider(color: Colors.grey, thickness: 1)),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(Icons.arrow_forward_ios,
                                  size: 20, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    checkTime("Check-out", "06:00 PM", Icons.alarm_off),
                  ],
                ),
                //work mode and verification
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //work mode
                      MyContainer(
                        mode: "Work Mode",
                        subText: "Office",
                        textColor: Colors.deepPurple,
                        bgColor: Colors.deepPurple.shade100,
                      ),
                      MyContainer(
                        mode: "Verification",
                        subText: "Selfie",
                        textColor: Colors.deepPurple,
                        bgColor: Colors.orange.shade100,
                      ),
                    ],
                  ),
                ),
                //location and details
                const SizedBox(height: 15),
                const CustomListTile(
                    icon: Icons.location_history,
                    iconColor: Colors.red,
                    title: "Location",
                    subtitle: "Lat:13.05,Long:80.24"),

                const SizedBox(height: 10),
                const CustomListTile(
                    icon: Icons.note_alt,
                    iconColor: Colors.grey,
                    title: "Notes",
                    subtitle: "Worked on UI and Bug Fixing"),
                const SizedBox(height: 100),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget checkTime(String label, String time, IconData? icon) {
  return Row(
    children: [
      Icon(
        icon,
        color: Colors.green,
        size: 40,
      ),
      Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(time,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    ],
  );
}

Widget stringContainer(String text, Color? textColor, Color bgColor) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
    ),
  );
}

class MyContainer extends StatelessWidget {
  final String mode;
  final String subText;
  final Color? textColor;
  final Color? bgColor;
  const MyContainer(
      {super.key,
      required this.mode,
      required this.subText,
      this.textColor,
      this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(4.0, 4.0),
              spreadRadius: 1,
              blurRadius: 4.0,
            ),
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(-4.0, -4.0),
              spreadRadius: 1,
              blurRadius: 4.0,
            ),
          ]),
      child: Column(
        children: [
          Text(mode),
          stringContainer(subText, textColor, bgColor ?? Colors.blue.shade100),
        ],
      ),
    );
  }
}
