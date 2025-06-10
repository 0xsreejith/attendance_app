import 'package:attendance_app/app/modules/attendance/controller/attendance_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/attendance_card.dart';
import '../widgets/filter_section.dart';

class AttendanceScreen extends StatelessWidget {
  final AttendanceController controller = Get.put(AttendanceController());

  AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchData();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Attendance"),
        actions: const [
          Icon(Icons.calendar_month),
          SizedBox(width: 10),
          Icon(Icons.filter_list),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          FilterSection(controller: controller),
          const Divider(),
          Expanded(
            child: Obx(() => controller.filteredList.isEmpty
                ? const Center(child: Text("No records found"))
                : ListView.builder(
                    itemCount: controller.filteredList.length,
                    itemBuilder: (_, index) {
                      return AttendanceCard(data: controller.filteredList[index]);
                    },
                  )),
          ),
        ],
      ),
    );
  }
}
