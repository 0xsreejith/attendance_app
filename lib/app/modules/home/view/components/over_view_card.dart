import 'package:flutter/material.dart';

class OverViewCard extends StatelessWidget {
  final String text;
  final String number;
  final Color color;

  const OverViewCard({
    super.key,
    required this.text,
    required this.number,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate responsive sizes
    final padding = screenWidth * 0.05; // 5% of screen width
    final titleFontSize = screenWidth * 0.045; // e.g., ~18 on 400px wide screen
    final numberFontSize = screenWidth * 0.1; // e.g., ~40 on 400px wide screen

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: titleFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            number,
            style: TextStyle(
              fontSize: numberFontSize,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
