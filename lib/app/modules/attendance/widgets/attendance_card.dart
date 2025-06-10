import 'package:attendance_app/app/modules/attendance/model/attendance_model.dart';
import 'package:flutter/material.dart';

class AttendanceCard extends StatelessWidget {
  final AttendanceModel data;

  const AttendanceCard({super.key, required this.data});

  Color getStatusColor(String status) {
    switch (status) {
      case "Present": return Colors.green;
      case "Absent": return Colors.red;
      case "Late": return Colors.orange;
      case "Leave": return Colors.blue;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${data.date.toLocal().toString().split(" ")[0]}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time, size: 18),
                const SizedBox(width: 4),
                Text("Check-in: ${data.checkIn}"),
                const SizedBox(width: 16),
                const Icon(Icons.access_time_outlined, size: 18),
                const SizedBox(width: 4),
                Text("Check-out: ${data.checkOut}"),
              ],
            ),
            const SizedBox(height: 6),
            Text(data.location, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: getStatusColor(data.status),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                data.status,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
