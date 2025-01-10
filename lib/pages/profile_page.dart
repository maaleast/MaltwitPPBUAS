import 'package:flutter/material.dart';
import 'package:uasapp/services/auth_service.dart'; // Pastikan path sesuai
import 'login_page.dart'; // Pastikan path untuk LoginPage sesuai

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.black, // Mengubah warna background app bar menjadi hitam
      ),
      backgroundColor: Colors.black, // Mengubah warna background halaman menjadi hitam
      body: FutureBuilder(
        future: Future.value(AuthService.getCurrentUserEmail()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}", style: TextStyle(color: Colors.white)));
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Informasi Akun:",
                    style: TextStyle(color: Colors.white), // Mengubah warna teks menjadi putih
                  ),
                  Text(
                    "Email: ${snapshot.data}",
                    style: TextStyle(color: Colors.white), // Mengubah warna teks menjadi putih
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Mengubah warna latar belakang tombol menjadi putih
                      foregroundColor: Colors.black, // Mengubah warna teks tombol menjadi hitam
                    ),
                    onPressed: () async {
                      // Logout process
                      await AuthService.logout();
                      // Setelah logout, arahkan ke halaman login dan hapus semua halaman sebelumnya
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => LoginPage()),
                            (route) => false, // Menghapus semua halaman sebelumnya
                      );
                    },
                    child: Text("Logout", style: TextStyle(color: Colors.black)), // Mengubah warna teks tombol menjadi hitam
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
