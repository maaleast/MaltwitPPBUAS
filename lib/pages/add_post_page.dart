import 'package:flutter/material.dart';
import 'package:uasapp/services/post_service.dart'; // Ensure the path is correct
import 'package:uasapp/services/auth_service.dart'; // For getting username

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController(); // Username input is now editable

  @override
  void initState() {
    super.initState();
    // Auto-fill username with the current user's display name
    _usernameController.text = AuthService.getCurrentUser()?.displayName ?? 'IsiSesuaiKemauan';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      appBar: AppBar(
        backgroundColor: Colors.black, // Black background for the AppBar
        title: Center(
          child: Text(
            "",
            style: TextStyle(color: Colors.white), // White text for title
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align the fields to the left
          children: [
            // Centered "Buat Twit" title
            Center(
              child: Text(
                "Buat Twit",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24, // Larger font size for emphasis
                  fontWeight: FontWeight.bold, // Bold text for title
                ),
              ),
            ),
            SizedBox(height: 20), // Spacing between the title and the fields

            // Title input field
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Judul",
                labelStyle: TextStyle(color: Colors.white), // White label text
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              style: TextStyle(color: Colors.white), // White text
            ),
            SizedBox(height: 12), // Spacing between fields

            // Content input field
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: "Isi Twit",
                labelStyle: TextStyle(color: Colors.white), // White label text
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              style: TextStyle(color: Colors.white), // White text
              maxLines: 5, // Allow multiple lines for content
            ),
            SizedBox(height: 12),

            // Editable username input field
            TextField(
              controller: _usernameController, // Username field is now editable
              decoration: InputDecoration(
                labelText: "Username",
                labelStyle: TextStyle(color: Colors.white), // White label text
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              style: TextStyle(color: Colors.white), // White text
            ),
            SizedBox(height: 20), // Spacing for the button

            // Post button
            ElevatedButton(
              onPressed: () async {
                String title = _titleController.text.trim();
                String content = _contentController.text.trim();
                String username = _usernameController.text.trim();

                if (title.isNotEmpty && content.isNotEmpty) {
                  await PostService.createPost(title, content, username); // Create post with username
                  Navigator.pop(context); // Go back after posting
                } else {
                  print("Judul atau isi tidak boleh kosong.");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // White button background
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Post",
                style: TextStyle(color: Colors.black), // Black text on the button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
