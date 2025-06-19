import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final VoidCallback? onTap; 
  final String textBtn;

  const CustomBtn({
    super.key,
    required this.textBtn,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            textBtn, 
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
