import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Color color;
  final Color iconColors;
  final Color textColors;

  const CustomBtn({
    super.key,
    required this.text,
    required this.color,
    required this.iconColors, required this.textColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.arrow_circle_right_outlined,
            color: iconColors,
            size: 30,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(color: textColors,fontSize: 20),
          ),
        ],
      ),
    );
  }
}
