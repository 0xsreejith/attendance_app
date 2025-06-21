import 'package:flutter/material.dart';
class CustomBtn extends StatelessWidget {
  final String text;
  final Color color;
  final Color iconColors;
  final Color textColors;
  final void Function()? onTap;

  const CustomBtn({
    Key? key,
    required this.text,
    required this.color,
    required this.iconColors,
    required this.textColors,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              Icons.arrow_circle_right_outlined,
              color: iconColors,
              size: 24,
            ),
            const SizedBox(width: 8),
            Flexible( // 👈 This avoids overflow
              child: Text(
                text,
                style: TextStyle(
                  color: textColors,
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis, // Optional
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
