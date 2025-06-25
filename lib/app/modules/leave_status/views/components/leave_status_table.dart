import 'package:flutter/material.dart';

class LeaveStatusTable extends StatelessWidget {
  final List<Map<String, String>> leaveData = [
    {
      'date': '10 June',
      'type': 'Sick Leave',
      'status': 'Approved',
      'reason': 'Fever',
    },
    {
      'date': '20 June',
      'type': 'Casual Leave',
      'status': 'Pending',
      'reason': 'Family Function',
    },
    {
      'date': '01 July',
      'type': 'WFH',
      'status': 'Rejected',
      'reason': 'No backup',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.grey.shade300,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Table(
        border: TableBorder.all(color: Colors.grey.shade300),
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(2),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          _buildHeaderRow(),
          ...leaveData.map((item) => _buildDataRow(item)).toList(),
        ],
      ),
    );
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey.shade100),
      children: [
        _buildCell("Date", isHeader: true),
        _buildCell("Leave Type", isHeader: true),
        _buildCell("Status", isHeader: true),
        _buildCell("Reason", isHeader: true),
      ],
    );
  }

  TableRow _buildDataRow(Map<String, String> data) {
    Color statusColor;
    switch (data['status']) {
      case 'Approved':
        statusColor = Colors.green;
        break;
      case 'Pending':
        statusColor = Colors.orange;
        break;
      case 'Rejected':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.black;
    }

    return TableRow(
      children: [
        _buildCell(data['date']!),
        _buildCell(data['type']!),
        _buildCell(data['status']!, color: statusColor),
        _buildCell(data['reason']!),
      ],
    );
  }

  Widget _buildCell(String text, {bool isHeader = false, Color? color}) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: color ?? (isHeader ? Colors.blue : Colors.black),
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
