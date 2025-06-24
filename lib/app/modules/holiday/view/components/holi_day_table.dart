import 'package:flutter/material.dart';

class VerticalHolidayTable extends StatelessWidget {
  final List<String> dates = ['17 June', '15 August', '23 October'];
  final List<String> days = ['Tuesday', 'Thursday', 'Wednesday'];
  final List<String> holidays = ['Bakrid', 'Independence Day', 'Diwali'];
  final List<String> types = ['Public Holiday', 'National Holiday', 'Optional'];
  final List<String> notes = [
    'Company-wide holiday',
    'Paid Leave',
    'Can be applied'
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white, boxShadow: [
            BoxShadow(
                blurRadius: 15,
                offset: const Offset(4.0, 4.0),
                spreadRadius: 1,
                color: Colors.grey.shade300),
            BoxShadow(
                blurRadius: 15,
                offset: const Offset(-4.0, -4.0),
                spreadRadius: 1,
                color: Colors.grey.shade300)
          ]),
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder.all(color: Colors.grey.shade400),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
              4: FlexColumnWidth(2),
            },
            children: [
              _buildRow("Date", dates),
              _buildRow("Day", days),
              _buildRow("Holiday Name", holidays),
              _buildRow("Type", types),
              _buildRow("Note", notes),
            ],
          ),
        );
      },
    );
  }

  TableRow _buildRow(String label, List<String> values) {
    return TableRow(
      children: [
        _buildCell(label, isHeader: true),
        ...values.map((v) => _buildCell(v)).toList(),
      ],
    );
  }

  Widget _buildCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? Colors.blue : Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
