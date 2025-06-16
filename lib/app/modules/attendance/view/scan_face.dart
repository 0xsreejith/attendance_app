import 'package:attendance_app/app/modules/attendance/view/scan_succes_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanFaceScreen extends StatefulWidget {
  const ScanFaceScreen({super.key});

  @override
  State<ScanFaceScreen> createState() => _ScanFaceScreenState();
}

class _ScanFaceScreenState extends State<ScanFaceScreen> {
  late final bool isCheckIn;
  CameraController? _controller;
  bool _isCameraInitialized = false;
  bool _isFlashOn = false;
  List<CameraDescription>? _cameras;
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    isCheckIn = Get.arguments ?? true;
    initCamera();
  }

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    await _startCamera(_selectedCameraIndex);
  }

  Future<void> _startCamera(int index) async {
    final selectedCamera = _cameras![index];
    _controller = CameraController(selectedCamera, ResolutionPreset.medium);
    await _controller!.initialize();
    if (mounted) {
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  void toggleFlash() {
    _isFlashOn = !_isFlashOn;
    setState(() {});
  }

  void switchCamera() async {
    if (_cameras == null || _cameras!.isEmpty) return;

    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras!.length;
    await _startCamera(_selectedCameraIndex);
  }

  void capturePhoto() async {
    // Simulate success, you can add photo capture logic here
    Get.to(() => ScanSuccessScreen(isCheckIn: isCheckIn));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCameraInitialized
          ? Stack(
              children: [
                Positioned.fill(
                  child: SafeArea(
                    child: SizedBox.expand(
                      child: CameraPreview(_controller!),
                    ),
                  ),
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
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Point your face right at the camera",
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.flip_camera_ios,
                                  color: Colors.white),
                              iconSize: 30,
                              onPressed: switchCamera,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(18),
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: capturePhoto,
                              child: const Icon(Icons.check,
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
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
