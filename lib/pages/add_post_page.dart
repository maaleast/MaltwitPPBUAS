import 'package:flutter/material.dart';
import '../services/post_service.dart';

class AddPostPage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Post")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Post Title"),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: "Post Content"),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String title = titleController.text;
                String content = contentController.text;

                if (title.isEmpty || content.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Both fields must be filled!")),
                  );
                  return;
                }

                // Add the post to Firestore
                await PostService.addPost(title, content);
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              child: Text("Add Post"),
            ),
          ],
        ),
      ),
    );
  }
}
