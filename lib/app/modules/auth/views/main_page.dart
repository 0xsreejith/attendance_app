import 'package:attendance_app/app/modules/auth/views/login_page.dart';
import 'package:attendance_app/app/modules/home/view/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BottomNavScreen();
            } else {
              return LoginPage();
            }
          }),
    );
  }
}
