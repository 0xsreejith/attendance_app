import 'package:attendance_app/app/modules/auth/components/custom_btn.dart';
import 'package:attendance_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:attendance_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController(); // Confirm password
  final _formKey = GlobalKey<FormState>();

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ... your Positioned widgets for images (unchanged) ...
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

                      // Name Field
                      TextFormField(
                        controller: nameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter your name' : null,
                      ),
                      const SizedBox(height: 10),

                      // Email Field
                      TextFormField(
                        controller: emailCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => !value!.contains('@')
                            ? 'Enter valid email'
                            : null,
                      ),
                      const SizedBox(height: 10),

                      // Mobile Field
                      TextFormField(
                        controller: mobileCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Mobile Number',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) =>
                            value!.length != 10 ? 'Enter valid 10-digit mobile' : null,
                      ),
                      const SizedBox(height: 10),

                      // Password Field
                      TextFormField(
                        controller: passCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) => value!.length < 6
                            ? 'Minimum 6 characters required'
                            : null,
                      ),
                      const SizedBox(height: 10),

                      // Confirm Password Field
                      TextFormField(
                        controller: confirmPassCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) => value != passCtrl.text
                            ? 'Passwords do not match'
                            : null,
                      ),
                      const SizedBox(height: 20),

                      // Sign Up Button
                      CustomBtn(
                        textBtn: "Sign Up",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            bool isSuccess = await authController.register(
                              name: nameCtrl.text.trim(),
                              email: emailCtrl.text.trim(),
                              password: passCtrl.text.trim(),
                              mobile: mobileCtrl.text.trim(),
                            );

                            if (isSuccess) {
                              Get.snackbar('Success', 'Account created successfully',
                                  snackPosition: SnackPosition.BOTTOM);
                              Get.toNamed(Routes.login);
                            } else {
                              Get.snackbar('Error', 'Registration failed',
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 10),

                      // Redirect to Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () => Get.toNamed(Routes.login),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      )
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
