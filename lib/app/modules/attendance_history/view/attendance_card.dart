import 'package:attendance_app/app/modules/attendance_history/model/attendance_model.dart';
import 'package:flutter/material.dart';

class AttendanceCard extends StatelessWidget {
  final AttendanceModel data;

  const AttendanceCard({super.key, required this.data});

  Color getStatusColor(String status) {
    switch (status) {
      case "Present":
        return Colors.green;
      case "Absent":
        return Colors.red;
      case "Late":
        return Colors.orange;
      case "Leave":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📅 Date
            Row(
              children: [
                const Text("📅 ", style: TextStyle(fontSize: 16)),
                Text(
                  "${data.date.toLocal()}".split(' ')[0],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // ⏰ Time In / Out
            Row(
              children: [
                const Text("⏰ In: ", style: TextStyle(fontSize: 14)),
                Text(data.checkIn),
                const SizedBox(width: 16),
                const Text("⏰ Out: ", style: TextStyle(fontSize: 14)),
                Text(data.checkOut),
              ],
            ),

            // 📍 Location
            if (data.location.isNotEmpty) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  const Text("📍", style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 4),
                  Text(
                    data.location,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 8),

            // Status tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: getStatusColor(data.status),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                data.status,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
