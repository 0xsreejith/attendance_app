import 'package:attendance_app/app/modules/attendance/model/attendance_model.dart';
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
            Text(
              "${data.date.toLocal()}".split(' ')[0],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(children: [
              const Icon(Icons.access_time, size: 16, color: Colors.green),
              const SizedBox(width: 4),
              Text("In: ${data.checkIn}"),
              const SizedBox(width: 12),
              const Icon(Icons.logout, size: 16, color: Colors.red),
              const SizedBox(width: 4),
              Text("Out: ${data.checkOut}"),
            ]),
            if (data.location.isNotEmpty) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(data.location, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ],
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: getStatusColor(data.status),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                data.status,
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
