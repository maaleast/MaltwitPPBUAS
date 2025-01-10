import 'package:flutter/material.dart';
import 'package:uasapp/services/post_service.dart';


class UpdateTwitPage extends StatelessWidget {
  final String postId;
  final String initialTitle;
  final String initialContent;

  UpdateTwitPage({
    required this.postId,
    required this.initialTitle,
    required this.initialContent,
    Key? key,
  }) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titleController.text = initialTitle;
    _contentController.text = initialContent;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Twit'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Isi Twit'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                var title = _titleController.text;
                var content = _contentController.text;
                await PostService.updatePost(postId, title, content);
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
