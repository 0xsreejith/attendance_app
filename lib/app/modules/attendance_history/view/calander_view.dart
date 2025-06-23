import 'package:attendance_app/app/modules/attendance_history/controller/attendance_controller.dart';
import 'package:attendance_app/app/modules/attendance_history/model/attendance_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  final AttendanceController controller;

  const CalendarView({super.key, required this.controller});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
  }

  Color _getDotColor(String status) {
    switch (status) {
      case "Present":
        return const Color(0xFF4CAF50); // Green
      case "Absent":
        return const Color(0xFFF44336); // Red
      case "Leave":
        return const Color(0xFFFF9800); // Orange
      case "Late":
        return const Color(0xFF2196F3); // Blue
      default:
        return Colors.grey;
    }
  }

  Map<DateTime, List<String>> _getEventsMap(List<AttendanceModel> data) {
    Map<DateTime, List<String>> events = {};
    for (var record in data) {
      final day =
          DateTime.utc(record.date.year, record.date.month, record.date.day);
      events[day] = [record.status];
    }
    return events;
  }

  String _formatMonth(DateTime date) {
    return "${_monthName(date.month)} ${date.year}";
  }

  String _monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month];
  }

  void _selectMonth(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _focusedDay,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      helpText: 'Select Month',
      fieldHintText: 'Month/Year',
    );

    if (picked != null) {
      setState(() {
        _focusedDay = DateTime(picked.year, picked.month);
      });
    }
  }

  void _goToPreviousMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isTabletOrDesktop = constraints.maxWidth > 600;
      final double containerPadding = isTabletOrDesktop ? 24.0 : 12.0;
      final double calendarWidth =
          isTabletOrDesktop ? constraints.maxWidth * 0.6 : double.infinity;

      return Obx(() {
        final eventMap = _getEventsMap(widget.controller.attendanceList);

        return Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(containerPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Month Selector
                Container(
                  width: calendarWidth,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: _goToPreviousMonth,
                      ),
                      GestureDetector(
                        onTap: () => _selectMonth(context),
                        child: Text(
                          _formatMonth(_focusedDay),
                          style: TextStyle(
                            fontSize: isTabletOrDesktop ? 22 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: _goToNextMonth,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Calendar
                Container(
                  width: calendarWidth,
                  padding: EdgeInsets.all(containerPadding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 4,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TableCalendar(
                    firstDay: DateTime.utc(2024, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    calendarFormat: CalendarFormat.month,
                    headerVisible: false,
                    eventLoader: (day) =>
                        eventMap[DateTime.utc(day.year, day.month, day.day)] ??
                        [],
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.blue),
                      weekendStyle: TextStyle(color: Colors.blue),
                    ),
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        final events = eventMap[
                                DateTime.utc(day.year, day.month, day.day)] ??
                            [];

                        if (events.isNotEmpty) {
                          final status = events.first;
                          final color = _getDotColor(status);

                          return Center(
                            child: Container(
                              width: isTabletOrDesktop ? 45 : 38,
                              height: isTabletOrDesktop ? 45 : 38,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${day.day}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }

                        return Center(
                          child: Text('${day.day}'),
                        );
                      },
                      markerBuilder: (context, day, events) => const SizedBox(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }
}
