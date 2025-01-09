import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // Login method
  static Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;  // Login berhasil
    } catch (e) {
      print("Login failed: $e");
      if (e is FirebaseAuthException) {
        print("Error Code: ${e.code}, Message: ${e.message}");
      }
      return false;  // Login gagal
    }
  }

  // Register method
  static Future<String?> register(String email, String password) async {
    try {
      // Pastikan password memenuhi syarat Firebase (min 6 karakter)
      if (password.length < 6) {
        return "Password must be at least 6 characters long.";
      }

      // Cek apakah email sudah terdaftar sebelumnya
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print('User registered successfully');
      return null;  // Jika berhasil, return null
    } catch (e) {
      print("Error during registration: $e");

      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          return 'This email address is already used by another account.';
        } else if (e.code == 'weak-password') {
          return 'The password is too weak.';
        } else if (e.code == 'invalid-email') {
          return 'The email address is badly formatted.';
        } else {
          return e.message;  // Mengambil pesan kesalahan dari FirebaseAuthException
        }
      } else {
        return "Registration failed. Please try again.";  // Jika error bukan dari Firebase
      }
    }
  }
}
