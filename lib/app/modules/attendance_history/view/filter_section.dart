import 'package:attendance_app/app/modules/attendance_history/controller/attendance_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterSection extends StatelessWidget {
  final AttendanceController controller;

  const FilterSection({super.key, required this.controller});

  Future<void> _pickDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      controller.selectedStartDate.value = picked.start;
      controller.selectedEndDate.value = picked.end;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              const Text("Status: "),
              const SizedBox(width: 8),
              Obx(() => DropdownButton<String>(
                    value: controller.selectedStatus.value,
                    items: const [
                      DropdownMenuItem(value: "All", child: Text("All")),
                      DropdownMenuItem(
                          value: "Present", child: Text("Present")),
                      DropdownMenuItem(value: "Absent", child: Text("Absent")),
                      DropdownMenuItem(value: "Late", child: Text("Late")),
                      DropdownMenuItem(value: "Leave", child: Text("Leave")),
                    ],
                    onChanged: (value) {
                      if (value != null)
                        controller.selectedStatus.value = value;
                    },
                  )),
              const Spacer(),
              ElevatedButton(
                onPressed: () =>
                    controller.applyFilter(controller.selectedStatus.value),
                child: const Text("Apply Filters"),
              ),
            ],
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => _pickDateRange(context),
            child: Obx(() => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.date_range, size: 20),
                      const SizedBox(width: 8),
                      Text(controller.formattedRange),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
