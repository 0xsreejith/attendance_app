import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final void Function()? onTap;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Scaling factors for responsiveness
    double iconSize = width * 0.08;
    double fontSize = width * 0.04;
    double padding = width * 0.045;

    // Clamp to avoid being too small on small screens or too big on large screens
    iconSize = iconSize.clamp(24.0, 40.0);
    fontSize = fontSize.clamp(12.0, 18.0);
    padding = padding.clamp(12.0, 24.0);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(padding / 1.5),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: iconSize),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
