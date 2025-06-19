import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:attendance_app/app/modules/home/model/task_model.dart';

class OngoingPendingTile extends StatelessWidget {
  final TaskModel task;
  final VoidCallback? onDonePressed;

  const OngoingPendingTile({
    super.key,
    required this.task,
    this.onDonePressed,
  });

  String formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return DateFormat('dd MMM yyyy').format(date);
  }

  Color getPriorityColor(String? priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOngoing = task.status == "Ongoing";

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            task.title ?? "No Title",
            style: const TextStyle(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Status
          // Status
          Row(
            children: [
              const Text(
                "Status: ",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
              ),
              Text(
                task.status ?? 'Unknown',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: task.status == "Ongoing"
                      ? Colors.blue
                      : task.status == "Pending"
                          ? Colors.orange
                          : Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Date Info

          Text(
            isOngoing
                ? "Start: ${formatDate(task.startDate)}"
                : "Assigned: ${formatDate(task.assignedDate)}",
            style: const TextStyle(fontSize: 19),
          ),
          const SizedBox(width: 20),

          Text(
            "Due: ${formatDate(isOngoing ? task.expectedCompletion : task.dueDate)}",
            style: const TextStyle(fontSize: 19),
          ),
          const SizedBox(height: 10),

          // Priority and Done Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Priority: ",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    task.priority ?? 'Medium',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: getPriorityColor(task.priority),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: onDonePressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  "Mark as Done",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
