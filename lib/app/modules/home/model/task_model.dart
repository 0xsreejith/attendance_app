class TaskModel {
  String? id; // unique identifier
  String? title;
  String? description;
  String? priority; // "High", "Medium", "Low"
  String? status; // "Pending", "Ongoing", "Completed"
  String? updation; // "Start", "Update", "Complete"
  String? remainingTime; // optional display like "3 days remaining"

  double? progress; // value between 0.0 and 1.0 for percentage indicator

  DateTime? assignedDate; // when the task is created
  DateTime? dueDate; // deadline
  DateTime? startDate; // when started
  DateTime? expectedCompletion; // when it's supposed to be completed
  DateTime? completedDate; // actual finish time

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.priority,
    this.status,
    this.updation,
    this.remainingTime,
    this.progress,
    this.assignedDate,
    this.dueDate,
    this.startDate,
    this.expectedCompletion,
    this.completedDate,
  });
}
