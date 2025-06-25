import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LeaveStatusController extends GetxController {
  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;

  final Map<DateTime, String> _holidayTypes = {
    DateTime(2025, 6, 3): 'Green', // Green
    DateTime(2025, 6, 12): 'Green', //Green
    DateTime(2025, 6, 16): 'Red', // Red
    DateTime(2025, 6, 17): 'Red', // Red
    DateTime(2025, 6, 20): 'Orange', // Orange
    DateTime(2025, 6, 25): 'Blue', // Blue
  };

  Map<DateTime, String> get holidayTypes => _holidayTypes;

  Color getHolidayColor(DateTime day) {
    final type = _holidayTypes[DateTime(day.year, day.month, day.day)];
    switch (type) {
      case 'Green':
        return Colors.green;
      case 'Red':
        return Colors.red;
      case 'Orange':
        return Colors.orange;
      case 'Blue':
        return Colors.blue;
      default:
        return Colors.transparent;
    }
  }

  void onDaySelected(DateTime day, DateTime focusDay) {
    selectedDay.value = day;
    focusedDay.value = focusDay;
  }
}
