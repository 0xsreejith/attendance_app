import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance_app/app/modules/home/controller/task_controller.dart';
import 'package:attendance_app/app/modules/home/model/task_model.dart';
import 'package:attendance_app/app/modules/home/view/components/ongoing_pending_tile.dart';
import 'package:dotted_line/dotted_line.dart';

class OngoingPendingTasks extends StatelessWidget {
  const OngoingPendingTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Obx(() {
        final List<TaskModel> filteredTasks = taskController.tasks.where((task) {
          return task.status == "Ongoing" || task.status == "Pending";
        }).toList();

        if (filteredTasks.isEmpty) {
          return const Center(child: Text("No Ongoing or Pending tasks."));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredTasks.length,
          itemBuilder: (context, index) {
            final task = filteredTasks[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OngoingPendingTile(
                  task: task,
                  onDonePressed: () {
                   // taskController.completeTask(task.id ?? "");
                  },
                ),
                const SizedBox(height: 10),
                if (index != filteredTasks.length - 1)
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
