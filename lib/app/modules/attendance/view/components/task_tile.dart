import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onStartPressed;
  final String buttonText;

  const TaskTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.onStartPressed,
    this.buttonText = "Start",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          style: const TextStyle(
            color: Colors.green,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // Subtitle with bullet
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("• ", style: TextStyle(fontSize: 18)),
            Expanded(
              child: Text(
                subtitle,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Start button
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
              color: Colors.blue,
              onPressed: onStartPressed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
