import 'package:flutter/material.dart';
import 'package:attendance_app/app/modules/home/view/components/work_data.dart';

class WorkSummery extends StatelessWidget {
  const WorkSummery({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 600;

          if (isWide) {
            // Two columns side by side for wide screens
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildBox(_firstBoxItems())),
                const SizedBox(width: 16),
                Expanded(child: _buildBox(_secondBoxItems())),
              ],
            );
          } else {
            // Single column stacked layout for phones
            return Column(
              children: [
                _buildBox(_firstBoxItems()),
                const SizedBox(height: 16),
                _buildBox(_secondBoxItems()),
              ],
            );
          }
        },
      ),
    );
  }

  // Extracted data into functions for clarity
  List<Widget> _firstBoxItems() {
    return [
      const WorkData(
        textTop: "Total Working",
        subText: "Days",
        icon: Icons.date_range_sharp,
        value: "20",
      ),
      const WorkData(
        textTop: "Average Daily",
        subText: "Hours",
        icon: Icons.watch_later_outlined,
        value: "8.0 hours",
      ),
      const WorkData(
        textTop: "Project Involved",
        subText: "Revenue",
        icon: Icons.pie_chart_outline,
        value: "Dashboard",
      ),
    ];
  }

  List<Widget> _secondBoxItems() {
    return [
      const WorkData(
        textTop: "Total Hours",
        subText: "Worked",
        icon: Icons.watch_later_outlined,
        value: "160 hours",
      ),
      const WorkData(
        textTop: "Productivity",
        subText: "Indicator",
        icon: Icons.pending_actions,
        value: "80%",
      ),
      const WorkData(
        textTop: "Leave Taken",
        subText: "",
        icon: Icons.payment_rounded,
        value: "2 days",
      ),
    ];
  }

  Widget _buildBox(List<Widget> items) {
    return Container(
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
            .sublist(0, items.length * 2 - 1), // remove last SizedBox
      ),
    );
  }
}
