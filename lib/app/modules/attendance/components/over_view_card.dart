import 'package:flutter/material.dart';

class OverViewCard extends StatelessWidget {
  final String text;
  final String number;
  final Color color;
  const OverViewCard({super.key, required this.text, required this.number, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(35),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(text,style: TextStyle(color: color,fontSize: 19),),
          Text(
            number,
            style: TextStyle(fontSize: 40, color:color),
          ),
        ],
      ),
    );
  }
}
