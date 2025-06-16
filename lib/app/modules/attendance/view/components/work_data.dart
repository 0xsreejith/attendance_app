import 'package:flutter/material.dart';

class WorkData extends StatelessWidget {
  final String textTop;
  final String subText;
  final IconData icon;
  final String value;

  const WorkData({
    super.key,
    required this.textTop,
    required this.subText,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.green, size: 30),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textTop,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            ),
            if (subText.trim().isNotEmpty)
              Text(
                subText,
                style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
              ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}
