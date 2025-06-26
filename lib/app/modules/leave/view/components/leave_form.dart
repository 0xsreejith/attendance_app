import 'package:attendance_app/app/modules/leave/controller/leave_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveForm extends StatelessWidget {
  const LeaveForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaveController());

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Apply for Leave",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildLabeledTextField(
                  "Employee Name", Icons.person, "Employee Name - autofilled",
                  readOnly: true),
              const SizedBox(height: 16),
              _buildLabeledTextField(
                  "Employee ID", Icons.badge, "Employee ID - autofilled",
                  readOnly: true),
              const SizedBox(height: 24),
              const Text("Leave Dates",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Obx(() => Row(
                    children: [
                      Expanded(
                        child: _buildDatePicker(
                          "From Date",
                          controller.fromDate.value,
                          () => controller.pickFromDate(context),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDatePicker(
                          "To Date",
                          controller.toDate.value,
                          () => controller.pickToDate(context),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 24),
              const Text("Leave Type",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Obx(() => DropdownButtonFormField<String>(
                    value: controller.selectedLeaveType.value,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.list),
                      hintText: 'Choose Type',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    items: controller.leaveTypes
                        .map((type) =>
                            DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (value) =>
                        controller.selectedLeaveType.value = value,
                    validator: (value) =>
                        value == null ? "Select a leave type" : null,
                  )),
              const SizedBox(height: 24),
              const Text("Reason",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              TextFormField(
                controller: controller.reasonController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Enter reason",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                validator: (value) => value!.isEmpty ? "Enter a reason" : null,
              ),
              const SizedBox(height: 24),
              const Text("Attachment",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Obx(() => InkWell(
                    onTap: controller.pickAttachment,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.attach_file),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        controller.selectedAttachment.value ??
                            "Attachment (Optional)",
                        style: TextStyle(
                          color: controller.selectedAttachment.value != null
                              ? Colors.black
                              : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  )),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: controller.submitLeave,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text("Submit",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabeledTextField(String label, IconData icon, String hintText,
      {bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextFormField(
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(String label, DateTime? date, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: label,
          prefixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          date != null ? "${date.day}/${date.month}/${date.year}" : label,
          style: TextStyle(
            color: date != null ? Colors.black : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
