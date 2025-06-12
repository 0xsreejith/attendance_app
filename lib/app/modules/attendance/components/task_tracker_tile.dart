import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance_app/app/modules/attendance/controller/task_controller.dart';
import 'package:attendance_app/app/modules/attendance/model/task_model.dart';
import 'package:intl/intl.dart';

class TaskTrackerTile extends StatelessWidget {
  final TaskModel task;

  const TaskTrackerTile({
    super.key,
    required this.task,
  });

  String formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return DateFormat('dd MMM').format(date);
  }

  Color getPriorityColor(String? priority) {
    switch (priority) {
      case "High":
        return Colors.red;
      case "Medium":
        return Colors.orange;
      case "Low":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskController = Get.find<TaskController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title & Due Date
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                task.title ?? "Untitled Task",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            Text(
              "Due Date: ${formatDate(task.dueDate)}",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Status + Radio Buttons (One Line)
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 4,
          runSpacing: 0,
          children: [
            const Text("Status:", style: TextStyle(fontSize: 16)),
            _buildRadio(task, "Not Started", taskController),
            _buildRadio(task, "In Progress", taskController),
            _buildRadio(task, "Completed", taskController),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(
                  "Progress:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    SizedBox(
                      width: 38,
                      height: 38,
                      child: CircularProgressIndicator(
                        value: task.progress ?? 0.0,
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          (task.progress ?? 0.0) >= 1.0
                              ? Colors.green
                              : Colors.orange,
                        ),
                        backgroundColor: Colors.grey.shade200,
                      ),
                    ),
                    Text(
                      "${((task.progress ?? 0.0) * 100).round()}%",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
              ],
            ),
            Text(
              task.remainingTime ?? "No deadline",
              style: TextStyle(
                fontSize: 14,
                color: (task.remainingTime?.toLowerCase() == "overdue")
                    ? Colors.red
                    : Colors.orange,
              ),
            ),
            const Text("✎ Assigned by \n(optional)")
          ],
        ),
        const SizedBox(height: 12),

// Priority Display Row
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Priority:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 12),
            Text(
              "Low",
              style: TextStyle(
                fontSize: 14,
                color: task.priority == "Low" ? Colors.green : Colors.black,
                fontWeight: task.priority == "Low"
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "Medium",
              style: TextStyle(
                fontSize: 14,
                color: task.priority == "Medium" ? Colors.orange : Colors.black,
                fontWeight: task.priority == "Medium"
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "High",
              style: TextStyle(
                fontSize: 14,
                color: task.priority == "High" ? Colors.red : Colors.black,
                fontWeight: task.priority == "High"
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

// Updation Status Radio Buttons Row
        // Updation Status Radio Buttons Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 12),
            _buildUpdationRadio(task, "Start"),
            _buildUpdationRadio(task, "Update"),
            _buildUpdationRadio(task, "Complete"),
          ],
        ),
      ],
    );
  }

  Widget _buildRadio(TaskModel task, String value, TaskController controller) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: task.status,
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (val) {
            // controller.updateTaskStatus(task.id!, val!);
          },
        ),
        Text(value, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

Widget _buildUpdationRadio(TaskModel task, String value) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Radio<String>(
        value: value,
        groupValue: task.updation,
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onChanged: (val) {
          // You can update task.updation using controller if needed
        },
      ),
      Text(value, style: const TextStyle(fontSize: 14)),
      const SizedBox(width: 8),
    ],
  );
}
