import 'package:attendance_app/app/modules/attendance_punch/controller/check_in_check_out_controller.dart';
import 'package:attendance_app/app/modules/attendance_punch/view/scan_face.dart';
import 'package:attendance_app/app/modules/attendance_punch/view/scan_qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CheckInPage extends StatelessWidget {
  final PunchInPunchOutController punchController = Get.find();

  CheckInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {};
    final bool isCheckIn = args["isCheckIn"] ?? true;
    final bool isOnsite = args["isOnsite"] ?? true;

    final bool showQR = isOnsite;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Verification",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  "Please proceed with your ${showQR ? "QR" : "Face"} ${isCheckIn ? "Check-In" : "Check-Out"}",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset(
                  showQR ? 'assets/scan2.json' : 'assets/scan1.json'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: GestureDetector(
              onTap: () {
                Get.to(
                  () => showQR ? const ScanQRScreen() : const ScanFaceScreen(),
                  arguments: isCheckIn,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    showQR
                        ? (isCheckIn ? "Start QR Scan" : "Start QR Check-Out")
                        : (isCheckIn ? "Take a Photo" : "Face Check-Out"),
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
