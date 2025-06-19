import 'package:attendance_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:attendance_app/app/modules/auth/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthController authController = AuthController.to;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<UserModel> getUserStream(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((doc) {
      if (doc.exists) {
        return UserModel.fromMap(doc.data()!);
      } else {
        throw Exception('User data not found');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = authController.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("No user logged in")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authController.signOut(),
            tooltip: "Logout",
          ),
        ],
      ),
      body: StreamBuilder<UserModel>(
        stream: getUserStream(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("No user data available"));
          }

          final userModel = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Login Successful",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/images/logo.jpeg"))),
                ),
                const Divider(height: 40),
                Text("Full Name: ${userModel.name}",
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text("Email: ${userModel.email}",
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text("Phone: ${userModel.mobile}",
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}
