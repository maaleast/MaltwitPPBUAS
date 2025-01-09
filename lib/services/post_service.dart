import 'package:cloud_firestore/cloud_firestore.dart';

class PostService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Tambah post baru
  static Future<void> addPost(String title, String content) async {
    try {
      await firestore.collection('posts').add({
        'title': title,
        'content': content,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("Post added successfully.");
    } catch (e) {
      print("Error adding post: $e");
    }
  }
}
