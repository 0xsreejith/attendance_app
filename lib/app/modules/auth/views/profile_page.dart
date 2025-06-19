import 'package:attendance_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/app/modules/auth/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = AuthController.to.currentUser?.uid;

    if (userId == null) {
      return const Scaffold(
        body: Center(child: Text('No user logged in')),
      );
    }

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future:
            AuthController.to.firestore.collection('users').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('User data not found'));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final user = UserModel.fromMap(data);

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            "https://i.pinimg.com/736x/60/c0/e5/60c0e5a45dbc723e391a8554602360bb.jpg"),
                      ),
                      const SizedBox(height: 20),
                      Text(user.name,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(user.email, style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Text('Mobile: ${user.mobile}',
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          AuthController.to.signOut();
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
