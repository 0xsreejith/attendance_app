import 'package:attendance_app/app/modules/holiday/view/components/holi_day_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:attendance_app/app/widgets/custom_header.dart';
import 'package:attendance_app/app/modules/holiday/controller/holiday_controller.dart';
import 'package:attendance_app/app/modules/holiday/view/components/my_holiday_card.dart';
class HolidayScreen extends StatelessWidget {
  const HolidayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HolidayController controller = Get.put(HolidayController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHeader(),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: MyDashboardCard(
                    headText: "Total Holidays",
                    mainDayText: "18 Days",
                    subText: "In a year",
                    icon: Icons.date_range_outlined,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: 20 / (20 + 29),
                          minHeight: 6,
                          backgroundColor: Colors.blue.shade100,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: MyDashboardCard(
                    headText: "Upcoming Holidays",
                    mainDayText: "5",
                    subDayText: "(Bookrid - 17 June)",
                    subText: "29 days remaining this month",
                    icon: Icons.calendar_month_outlined,
                    child: SizedBox(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                holidayType(" Public", Colors.green),
                const SizedBox(width: 10),
                holidayType(" Optional", Colors.orange),
                const SizedBox(width: 10),
                holidayType(" Company", Colors.blue),
              ],
            ),
            const SizedBox(height: 20),

            /// Obx Calendar
            Obx(() {
              final focusedDay = controller.focusedDay.value;
              final monthYear =
                  "${_getMonthName(focusedDay.month)} ${focusedDay.year}";

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
                        for (final day in [
                          'Sun',
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat'
                        ])
                          Expanded(
                            child: Center(
                              child: Text(
                                day,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      day == 'Sun' ? Colors.red : Colors.black,
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
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, _) {
                          final color = controller.getHolidayColor(day);
                          final isSpecialRedDate =
                              (day.weekday == DateTime.sunday &&
                                  (day.day == 8 ||
                                      day.day == 15 ||
                                      day.day == 22 ||
                                      day.day == 29));

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
                          final isSpecialRedDate = (day.weekday ==
                                  DateTime.sunday &&
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
                      onDaySelected: controller.onDaySelected,
                    )
                  ],
                ),
              );
            }),
            const SizedBox(height: 20),

            /// Holiday Table
            VerticalHolidayTable(),
          ],
        ),
      ),
    );
  }

  Widget holidayType(String label, Color color) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
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
