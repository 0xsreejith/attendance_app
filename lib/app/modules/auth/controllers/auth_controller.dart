import 'package:attendance_app/app/modules/auth/model/user_model.dart';
import 'package:attendance_app/app/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class AuthController extends GetxController {
  static AuthController get to => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFirestore get firestore => _firestore;

  /// Returns the currently logged-in user, or null if none
  User? get currentUser => _auth.currentUser;

  /// Register new user, returns true on success
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
        Get.snackbar("Error", "Failed to create user.",
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }

      final newUser = UserModel(
        uid: userCredential.user!.uid,
        name: name.trim(),
        email: email.trim(),
        mobile: mobile.trim(),
      );

      await _firestore
          .collection('users')
          .doc(newUser.uid)
          .set(newUser.toMap());

      Get.snackbar("Success", "Account created successfully.",
          snackPosition: SnackPosition.BOTTOM);
      return true;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return false;
    } catch (e) {
      _handleGenericError(e);
      return false;
    }
  }

  /// Login existing user, returns true on success
  Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return false;
    } catch (e) {
      _handleGenericError(e);
      return false;
    }
  }

  /// Send password reset email
  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      Get.snackbar("Success", "Password reset email sent.",
          snackPosition: SnackPosition.BOTTOM);
      return true;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return false;
    } catch (e) {
      _handleGenericError(e);
      return false;
    }
  }

  /// Sign out user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.offAllNamed(Routes.login);
    } catch (e) {
      _handleGenericError(e);
    }
  }

  /// Private: handle Firebase Auth errors
  void _handleAuthError(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'user-not-found':
        message = "No user found for this email.";
        break;
      case 'wrong-password':
        message = "Incorrect password.";
        break;
      case 'email-already-in-use':
        message = "This email is already registered.";
        break;
      case 'invalid-email':
        message = "The email address is not valid.";
        break;
      case 'weak-password':
        message = "Password should be at least 6 characters.";
        break;
      default:
        message = e.message ?? "Authentication error occurred.";
    }
    Get.snackbar("Error", message, snackPosition: SnackPosition.BOTTOM);
  }

  /// Private: handle generic errors
  void _handleGenericError(dynamic e) {
    Get.snackbar("Error", "Unexpected error: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM);
  }
}


