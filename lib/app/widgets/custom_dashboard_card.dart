import 'package:flutter/material.dart';

class MyDashboardCard extends StatelessWidget {
  final String headText;
  final String? mainDayText;
  final String? subDayText;
  final String? subText;
  final IconData icon;
  final Color? iconColor;
  final Widget? child;

  const MyDashboardCard({
    Key? key,
    required this.headText,
    this.mainDayText,
    this.subDayText,
    this.subText,
    required this.icon,
    this.iconColor,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color iconClr = iconColor ?? Colors.blue;

    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title left, icon right
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    headText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(icon, size: 22, color: iconClr),
              ],
            ),
            if (mainDayText != null) ...[
              const SizedBox(height: 8),
              Text(
                mainDayText!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
            if (subDayText != null) ...[
              const SizedBox(height: 4),
              Text(
                subDayText!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
            if (subText != null) ...[
              const SizedBox(height: 4),
              Text(
                subText!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
            if (child != null) ...[
              const SizedBox(height: 8),
              child!,
            ],
          ],
        ),
      ),
    );
  }
}
