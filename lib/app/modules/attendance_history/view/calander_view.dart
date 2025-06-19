// calendar_view.dart

import 'package:attendance_app/app/modules/attendance_history/controller/attendance_controller.dart';
import 'package:attendance_app/app/modules/attendance_history/model/attendance_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatelessWidget {
  final AttendanceController controller;

  const CalendarView({super.key, required this.controller});

  Color _getDotColor(String status) {
    switch (status) {
      case "Present":
        return const Color(0xFF4CAF50);
      case "Absent":
        return const Color(0xFFF44336);
      case "Late":
        return const Color(0xFFFF9800);
      case "Leave":
        return const Color(0xFF2196F3);
      default:
        return Colors.grey;
    }
  }

  Map<DateTime, List<String>> _getEventsMap(List<AttendanceModel> data) {
    Map<DateTime, List<String>> events = {};
    for (var record in data) {
      final day = DateTime.utc(record.date.year, record.date.month, record.date.day);
      events[day] = [record.status];
    }
    return events;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final eventMap = _getEventsMap(controller.attendanceList);

      return TableCalendar(
        firstDay: DateTime.utc(2024, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: DateTime.now(),
        calendarFormat: CalendarFormat.month,
        eventLoader: (day) => eventMap[DateTime.utc(day.year, day.month, day.day)] ?? [],
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            if (events.isEmpty) return null;
            return Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: events.map((e) {
                    return Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: _getDotColor(e as String),
                        shape: BoxShape.circle,
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
