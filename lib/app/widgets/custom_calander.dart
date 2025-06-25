import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:attendance_app/app/modules/holiday/controller/holiday_controller.dart';

class CustomHolidayCalendar extends StatelessWidget {
  final HolidayController controller;

  const CustomHolidayCalendar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final focusedDay = controller.focusedDay.value;
      final monthYear = "${_getMonthName(focusedDay.month)} ${focusedDay.year}";

      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              offset: const Offset(4.0, 4.0),
              spreadRadius: 1,
              color: Colors.grey.shade300,
            ),
            BoxShadow(
              blurRadius: 15,
              offset: const Offset(-4.0, -4.0),
              spreadRadius: 1,
              color: Colors.grey.shade300,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Weekday Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (final day in ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'])
                  Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: day == 'Sun' ? Colors.red : Colors.black,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),

            /// Month-Year Label
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                monthYear,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),

            /// TableCalendar
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: focusedDay,
              selectedDayPredicate: (day) =>
                  isSameDay(controller.selectedDay.value, day),
              calendarFormat: CalendarFormat.month,
              headerVisible: false,
              daysOfWeekVisible: false,
              availableCalendarFormats: const {
                CalendarFormat.month: '',
              },
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: false,
              ),
              onPageChanged: (newFocusedDay) {
                controller.focusedDay.value = newFocusedDay;
              },
              onDaySelected: controller.onDaySelected,
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, _) {
                  final color = controller.getHolidayColor(day);
                  final isSpecialRedDate = (day.weekday == DateTime.sunday &&
                      (day.day == 8 || day.day == 15 || day.day == 22 || day.day == 29));

                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        color: isSpecialRedDate
                            ? Colors.red
                            : (color == Colors.transparent
                                ? Colors.black
                                : Colors.white),
                      ),
                    ),
                  );
                },
                todayBuilder: (context, day, _) {
                  final color = controller.getHolidayColor(day);
                  final isSpecialRedDate = (day.weekday == DateTime.sunday &&
                      (day.day == 8 || day.day == 15 || day.day == 22));

                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        color: isSpecialRedDate
                            ? Colors.red
                            : (color == Colors.transparent
                                ? Colors.black
                                : Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  String _getMonthName(int month) {
    const months = [
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
    return months[month - 1];
  }
}
