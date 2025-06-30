import 'package:flutter/material.dart';

class ClockInTable extends StatelessWidget {
  final List<Map<String, String>> data = const [
    {
      'date': 'June 21',
      'checkIn': '09:15 AM',
      'checkOut': '05:45 PM',
      'hours': '8.5 hrs',
      'status': 'Present',
    },
    {
      'date': 'June 22',
      'checkIn': '--',
      'checkOut': '--',
      'hours': '0 hrs',
      'status': 'Absent',
    },
    {
      'date': 'June 23',
      'checkIn': '09:30 AM',
      'checkOut': '04:00 PM',
      'hours': '6.5 hrs',
      'status': 'Half Day',
    },
  ];

  const ClockInTable({Key? key}) : super(key: key);

  Color _statusColor(String status) {
    switch (status) {
      case 'Present':
        return Colors.green;
      case 'Absent':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
          4: FlexColumnWidth(),
        },
        children: [
          const TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child:
                    Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('Check-in',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('Check-out',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('Total Hrs',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child:
                    Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          ...data.map(
            (row) => TableRow(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8), child: Text(row['date']!)),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(row['checkIn']!)),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(row['checkOut']!)),
                Padding(
                    padding: const EdgeInsets.all(8), child: Text(row['hours']!)),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    row['status']!,
                    style: TextStyle(color: _statusColor(row['status']!)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
