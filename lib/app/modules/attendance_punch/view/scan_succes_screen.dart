import 'package:attendance_app/app/modules/home/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ScanSuccessScreen extends StatefulWidget {
  final bool isCheckIn;

  const ScanSuccessScreen({super.key, required this.isCheckIn});

  @override
  State<ScanSuccessScreen> createState() => _ScanSuccessScreenState();
}

class _ScanSuccessScreenState extends State<ScanSuccessScreen> {
  late String formattedTime;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    formattedTime = DateFormat('hh:mm a').format(now); // e.g., 09:05 AM
    goToHome();
  }

  void goToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.off(() =>  HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    final isCheckIn = widget.isCheckIn;
    final bgColor = isCheckIn ? Colors.green : Colors.orange;
    final gradient = LinearGradient(
      colors: [bgColor, Colors.white],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
              const SizedBox(height: 20),
              Text(
                isCheckIn
                    ? "Punch-In Successful at $formattedTime"
                    : "Punch-Out Successful at $formattedTime",
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
