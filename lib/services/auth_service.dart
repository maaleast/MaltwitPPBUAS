import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login method
  static Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print("Login failed: $e");
      return false;
    }
  }

  // Register method
  static Future<String?> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      print("Registration failed: $e");
      return e.toString();
    }
  }

  // Logout method
  static Future<void> logout() async {
    await _auth.signOut();
  }

  // Get current user
  static User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Get current user's email
  static String? getCurrentUserEmail() {
    return _auth.currentUser?.email;
  }
}
