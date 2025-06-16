import 'package:attendance_app/app/modules/attendance/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanSuccessScreen extends StatefulWidget {
  final bool isCheckIn; // true = check-in, false = check-out

  const ScanSuccessScreen({super.key, required this.isCheckIn});

  @override
  State<ScanSuccessScreen> createState() => _ScanSuccessScreenState();
}

class _ScanSuccessScreenState extends State<ScanSuccessScreen> {
  @override
  void initState() {
    super.initState();
    goToHome();
  }

  void goToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.off(() => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    final isCheckIn = widget.isCheckIn;
    final bgColor = isCheckIn ? Colors.green : Colors.orange;
    final gradient = LinearGradient(
      colors: [bgColor,Colors.white],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(30),
            child: const Icon(
              Icons.check,
              size: 60,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
