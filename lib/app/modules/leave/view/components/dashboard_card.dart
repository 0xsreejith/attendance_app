import 'package:flutter/material.dart';

class MyDashboardCard extends StatelessWidget {
  final String headText;
  final String dayText;
  final String subText;
  final IconData icon;
  final Widget child;

  const MyDashboardCard({
    super.key,
    required this.headText,
    required this.dayText,
    required this.subText,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // outer subtle
              spreadRadius: 2,
              blurRadius: 12,
              offset: const Offset(4, 4),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.05), // soft inner glow
              spreadRadius: -1,
              blurRadius: 6,
              offset: const Offset(-2, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  headText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Icon(icon, color: Colors.blue),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              dayText,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subText,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            if (child != const SizedBox()) ...[
              const SizedBox(height: 12),
              child,
            ]
          ],
        ),
      ),
    );
  }
}
