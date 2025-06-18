import 'package:attendance_app/app/modules/attendance/controller/attendance_controller.dart';
import 'package:attendance_app/app/modules/attendance/view/widgets/calander_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/filter_section.dart';
import '../widgets/attendance_card.dart';

class MyAttendanceScreen extends StatelessWidget {
  final AttendanceController controller = Get.put(AttendanceController());

  MyAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchData();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Attendance"),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () => controller.isCalendarView.toggle(),
          ),
        ],
      ),
      body: Column(
        children: [
          FilterSection(controller: controller),
          Expanded(
            child: Obx(() => controller.isCalendarView.value
                ? CalendarView(controller: controller)
                : controller.filteredList.isEmpty
                    ? const Center(child: Text("No records found"))
                    : ListView.builder(
                        itemCount: controller.filteredList.length,
                        itemBuilder: (context, index) {
                          return AttendanceCard(data: controller.filteredList[index]);
                        },
                      )),
          ),
        ],
      ),
    );
  }
}
