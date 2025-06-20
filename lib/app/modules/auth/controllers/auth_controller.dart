import 'package:attendance_app/app/modules/auth/model/user_model.dart';
import 'package:attendance_app/app/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Firebase instances
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String mobile,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (userCredential.user == null) {
        _showError("Failed to create user.");
        return false;
      }

      final newUser = UserModel(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        mobile: mobile,
      );

      await _firestore
          .collection('users')
          .doc(newUser.uid)
          .set(newUser.toMap());

      Get.snackbar("Success", "Account created successfully.");
      return true;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return false;
    } catch (e) {
      _showError(e.toString());
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return false;
    } catch (e) {
      _showError(e.toString());
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      Get.snackbar("Success", "Password reset email sent.");
      return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      _handleAuthError(e);
      return false;
    } catch (e) {
      _showError(e.toString());
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.offAllNamed(Routes.login);
    } catch (e) {
      _showError(e.toString());
    }
  }

  void _handleAuthError(FirebaseAuthException e) {
    final messages = {
      'user-not-found': "No user found for this email.",
      'wrong-password': "Incorrect password.",
      'email-already-in-use': "Email is already registered.",
      'invalid-email': "Invalid email address.",
      'weak-password': "Password should be at least 6 characters.",
    };

    final message = messages[e.code] ?? e.message ?? "Something went wrong.";
    _showError(message);
  }

  /// ❗ Show error message
  void _showError(String message) {
    Get.snackbar("Error", message);
  }
}
