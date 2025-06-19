import 'package:attendance_app/app/modules/auth/components/custom_btn.dart';
import 'package:attendance_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:attendance_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  final emailCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    final email = emailCtrl.text.trim();

    final success = await authController.resetPassword(email);
    if (success) {
      Get.snackbar(
        "Success",
        "Reset link sent to your email.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
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
                        "Forgot Password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 30),

                      const Text(
                        "Enter your registered email to reset your password",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        controller: emailCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      CustomBtn(
                        textBtn: "Reset Password",
                        onTap: _resetPassword,
                      ),
                      const SizedBox(height: 20),

                      TextButton(
                        onPressed: () {
                          Get.offNamed(Routes.login);
                        },
                        child: const Text(
                          "Back to Login",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
