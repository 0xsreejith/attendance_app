import 'package:flutter/material.dart';
import 'package:attendance_app/app/modules/home/view/components/work_data.dart';

class WorkSummery extends StatelessWidget {
  const WorkSummery({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBox([
              WorkData(
                textTop: "Total Working",
                subText: "Days",
                icon: Icons.date_range_sharp,
                value: "20",
              ),
              WorkData(
                textTop: "Average Daily",
                subText: "Hours",
                icon: Icons.watch_later_outlined,
                value: "8.0 hours",
              ),
              WorkData(
                textTop: "Project Involved",
                subText: "Revenue",
                icon: Icons.pie_chart_outline,
                value: "Dashboard",
              ),
            ]),
            const SizedBox(width: 16),
            _buildBox([
              WorkData(
                textTop: "Total Hours",
                subText: "Worked",
                icon: Icons.watch_later_outlined,
                value: "160 hours",
              ),
              WorkData(
                textTop: "Productivity",
                subText: "Indicator",
                icon: Icons.pending_actions,
                value: "80%",
              ),
              WorkData(
                textTop: "Leave Taken",
                subText: "",
                icon: Icons.payment_rounded,
                value: "2 days",
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildBox(List<Widget> items) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .expand((item) => [item, const SizedBox(height: 12)])
              .toList()
              .sublist(0, items.length * 2 - 1),
        ),
      ),
    );
  }
}
