import 'package:attendance_app/app/modules/auth/components/custom_btn.dart';
import 'package:attendance_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:attendance_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final authController = Get.find<AuthController>();

  Future<void> _login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final email = emailCtrl.text.trim();
    final password = passwordCtrl.text.trim();

    try {
      // Try Firebase login
      await authController.login(email, password);

      // After login success, check Firestore phone number match
      final userDoc = await authController.firestore
          .collection('users')
          .doc(authController.currentUser?.uid)
          .get();

      if (!userDoc.exists) {
        throw Exception("User data not found");
      }

      final userData = userDoc.data();
      final phoneFromFirestore = userData?['mobile'] ?? '';

      // For demonstration, let's assume you want to match phone number with email field if user entered phone number
      // You can modify this logic as per your needs

      bool phoneMatches = false;

      // If user typed a phone number instead of email, check if it matches Firestore mobile
      // Simple heuristic: if input contains @, it's email; else mobile
      if (!email.contains('@')) {
        phoneMatches = email == phoneFromFirestore;
      } else {
        // If input is email, accept login (or add more logic if you want)
        phoneMatches = true;
      }

      if (phoneMatches) {
        // Navigate to home page
        Get.offAllNamed(Routes.HOME);
      } else {
        // Phone mismatch
        await _showErrorDialog(context, "Entered details are incorrect");
        // Optional: logout since login succeeded but phone mismatch
        await authController.signOut();
      }
    } catch (e) {
      await _showErrorDialog(context, "Entered details are incorrect");
    }
  }

  Future<void> _showErrorDialog(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Login Failed"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/top-edited.jpg',
              height: 200,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/images/bottom.png',
              height: 150,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "ZiyaAttend",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                      const Text(
                        "Smart Attendance Maintainer",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: emailCtrl,
                        decoration: const InputDecoration(
                          labelText: "Email Address or Mobile Number",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email or mobile number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passwordCtrl,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomBtn(
                        textBtn: "Login",
                        onTap: () => _login(context),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.forgotPassword);
                            },
                            child: const Text(
                              "Forgot Password?",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.signUp);
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
