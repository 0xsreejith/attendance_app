import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HolidayController extends GetxController {
  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;

  final Map<DateTime, String> _holidayTypes = {
    DateTime(2025, 6, 3): 'Public',
    DateTime(2025, 6, 12): 'Public',
    DateTime(2025, 6, 17): 'Company',
    DateTime(2025, 6, 16): 'Company',
    DateTime(2025, 6, 20): 'Optional',
    DateTime(2025, 6, 25): 'Company',
  };

  Map<DateTime, String> get holidayTypes => _holidayTypes;

  Color getHolidayColor(DateTime day) {
    final type = _holidayTypes[DateTime(day.year, day.month, day.day)];
    switch (type) {
      case 'Public':
        return Colors.green;
      case 'Optional':
        return Colors.orange;
      case 'Company':
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
