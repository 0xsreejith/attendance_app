import 'package:attendance_app/app/modules/home/view/screens/scan_succes_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({super.key});

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  late final bool isCheckIn;
  final MobileScannerController _qrController = MobileScannerController();
  bool _isScanned = false;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    isCheckIn = Get.arguments ?? true;
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isScanned) return;
    _isScanned = true;

    final barcode = capture.barcodes.first;
    final String code = barcode.rawValue ?? "---";
    debugPrint("QR Scanned: $code");

    Get.off(() => ScanSuccessScreen(isCheckIn: isCheckIn));
  }

  void toggleFlash() {
    _isFlashOn = !_isFlashOn;
    _qrController.toggleTorch();
    setState(() {});
  }

  @override
  void dispose() {
    _qrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: _qrController,
            onDetect: _onDetect,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.8),
                    Colors.white.withOpacity(0.3),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    isCheckIn ? "Check In" : "Check Out",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Point the camera at your QR code",
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.cameraswitch, color: Colors.white),
                        iconSize: 30,
                        onPressed: () {
                          // No actual switching with mobile_scanner, but button shown for UI consistency
                          Get.snackbar("Camera", "Switching camera is not supported here",
                              backgroundColor: Colors.white.withOpacity(0.9));
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(18),
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          _qrController.stop();
                          if (!_isScanned) {
                            _onDetect(BarcodeCapture(barcodes: [
                              Barcode(rawValue: "manual-scan")
                            ]));
                          }
                        },
                        child: const Icon(Icons.qr_code_scanner,
                            color: Colors.white, size: 28),
                      ),
                      IconButton(
                        icon: Icon(
                          _isFlashOn ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                        ),
                        iconSize: 30,
                        onPressed: toggleFlash,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
