import 'package:attendance_app/app/modules/holiday/controller/holiday_controller.dart';
import 'package:attendance_app/app/modules/holiday/view/components/holi_day_table.dart';
import 'package:attendance_app/app/widgets/custom_calander.dart';
import 'package:attendance_app/app/widgets/custom_header.dart';
import 'package:attendance_app/app/widgets/my_holiday_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HolidayScreen extends StatelessWidget {
  const HolidayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HolidayController controller = Get.find<HolidayController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHeader(),
            const SizedBox(height: 20),

            /// Dashboard Cards
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

            /// Holiday Types
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

            /// Custom Calendar Widget
            CustomHolidayCalendar(controller: controller),

            const SizedBox(height: 20),

            /// Holiday List Table
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
