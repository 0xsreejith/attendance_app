import 'package:attendance_app/app/modules/home/model/task_model.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  var tasks = <TaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _addDemoTasks();
    _updateAllTaskProgress();
  }

  void addTask(TaskModel task) {
    _updateTaskProgress(task);
    tasks.add(task);
  }

  void startTask(String id) {
    final task = tasks.firstWhere((t) => t.id == id);
    task.status = "Ongoing";
    task.updation = "Start";
    task.startDate = DateTime.now();
    _updateTaskProgress(task);
    tasks.refresh();
  }

  void updateTaskStatus(String id, String newStatus) {
    final task = tasks.firstWhere((t) => t.id == id);
    task.status = newStatus;
    task.updation = newStatus == "Completed" ? "Complete" : "Update";

    if (newStatus == "Completed") {
      task.completedDate = DateTime.now();
      task.progress = 1.0;
    } else {
      _updateTaskProgress(task);
    }

    tasks.refresh();
  }

  List<TaskModel> get myTasks {
    _updateAllTaskProgress();
    return tasks.where((task) => task.status == "Pending").toList();
  }

  List<TaskModel> get trackerTasks {
    _updateAllTaskProgress();
    return tasks;
  }

  List<TaskModel> get ongoingOrPendingTasks {
    _updateAllTaskProgress();
    return tasks
        .where((task) => task.status == "Pending" || task.status == "Ongoing")
        .toList();
  }

  // 🔥 NEW: Get list of all task progress values
  List<double> getAllProgress() {
    _updateAllTaskProgress();
    return tasks.map((t) => t.progress ?? 0.0).toList();
  }

  double get overallProgress {
    if (tasks.isEmpty) return 0.0;
    final progresses = getAllProgress();
    return progresses.reduce((a, b) => a + b) / progresses.length;
  }

  void _addDemoTasks() {
    final now = DateTime.now();

    tasks.addAll([
      TaskModel(
        id: 'task1',
        title: 'Design UI for Attendance App',
        description: 'Create a user-friendly interface using Flutter.',
        priority: 'High',
        status: 'Pending',
        assignedDate: now.subtract(const Duration(days: 1)),
        dueDate: now.add(const Duration(days: 3)),
        expectedCompletion: now.add(const Duration(days: 3)),
        remainingTime: "3 days remaining",
      ),
      TaskModel(
        id: 'task2',
        title: 'Connect Backend to Firestore',
        description: 'Integrate Firebase with the app and store task data.',
        priority: 'Medium',
        status: 'Ongoing',
        assignedDate: now.subtract(const Duration(days: 2)),
        startDate: now.subtract(const Duration(days: 1)),
        expectedCompletion: now.add(const Duration(days: 2)),
        remainingTime: "2 days remaining",
      ),
      TaskModel(
        id: 'task3',
        title: 'Write App Documentation',
        description: 'Add usage instructions and API reference.',
        priority: 'Low',
        status: 'Completed',
        assignedDate: now.subtract(const Duration(days: 7)),
        startDate: now.subtract(const Duration(days: 5)),
        completedDate: now.subtract(const Duration(days: 1)),
        updation: 'Complete',
        progress: 1.0,
        remainingTime: "Completed",
      ),
      TaskModel(
        id: 'task4',
        title: 'Setup Authentication Module',
        description: 'Implement login and signup with Firebase Auth.',
        priority: 'High',
        status: 'Ongoing',
        assignedDate: now.subtract(const Duration(days: 2)),
        startDate: now.subtract(const Duration(days: 2)),
        expectedCompletion: now.add(const Duration(days: 4)),
        remainingTime: "4 days remaining",
      ),
      TaskModel(
        id: 'task5',
        title: 'Testing & Bug Fixing',
        description: 'Perform testing and resolve known issues.',
        priority: 'Medium',
        status: 'Ongoing',
        assignedDate: now.subtract(const Duration(days: 1)),
        startDate: now.subtract(const Duration(days: 1, hours: 12)),
        expectedCompletion: now.add(const Duration(days: 1)),
        remainingTime: "1 day remaining",
      ),
      TaskModel(
        id: 'task6',
        title: 'Push to GitHub',
        description: 'Upload the final project to GitHub repository.',
        priority: 'Low',
        status: 'Pending',
        assignedDate: now,
        dueDate: now.add(const Duration(days: 2)),
        expectedCompletion: now.add(const Duration(days: 2)),
        remainingTime: "2 days remaining",
      ),
    ]);

    _updateAllTaskProgress(); // Make sure to keep this for progress update
  }

  void _updateTaskProgress(TaskModel task) {
    if (task.status == "Completed") {
      task.progress = 1.0;
      return;
    }

    if (task.startDate != null && task.expectedCompletion != null) {
      final total =
          task.expectedCompletion!.difference(task.startDate!).inSeconds;
      final elapsed = DateTime.now().difference(task.startDate!).inSeconds;

      task.progress = total > 0 ? (elapsed / total).clamp(0.0, 1.0) : 0.0;
    } else {
      task.progress = 0.0;
    }
  }

  void _updateAllTaskProgress() {
    for (var task in tasks) {
      _updateTaskProgress(task);
    }
    tasks.refresh();
  }
}
