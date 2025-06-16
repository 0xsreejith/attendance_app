import 'package:attendance_app/app/modules/attendance/view/components/task_tracker_tile.dart';
import 'package:attendance_app/app/modules/attendance/controller/task_controller.dart';
import 'package:attendance_app/app/modules/attendance/model/task_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskTracker extends StatelessWidget {
  const TaskTracker({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Obx(() {
        final List<TaskModel> tasks = taskController.tasks;

        if (tasks.isEmpty) {
          return const Center(child: Text("No tasks available."));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TaskTrackerTile(task: task),
                const SizedBox(height: 10),
                if (index != tasks.length - 1)
                  const DottedLine(
                    dashColor: Colors.grey,
                    lineThickness: 1,
                    dashLength: 5,
                    dashGapLength: 3,
                  ),
                const SizedBox(height: 10),
              ],
            );
          },
        );
      }),
    );
  }
}
