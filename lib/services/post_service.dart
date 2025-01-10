import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uasapp/services/auth_service.dart';

class PostService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new post
  static Future<void> createPost(String title, String content, String username) async {
    try {
      var currentUser = AuthService.getCurrentUser();

      if (currentUser != null) {
        // Create post data
        final postData = {
          'user': {
            'username': username,  // Username inside the user object
            'email': currentUser.email,
          },
          'title': title,
          'content': content,
          'timestamp': FieldValue.serverTimestamp(),
          'createdAt': FieldValue.serverTimestamp(),
          'username': username,  // Username outside the user object
          'email': currentUser.email,  // Email outside the user object (repeated)
        };

        // Add post to Firestore collection
        await _firestore.collection('posts').add(postData);
      } else {
        print("No user is logged in");
      }
    } catch (e) {
      print("Error creating post: $e");
    }
  }

  // Get posts for a specific user
  static Stream<QuerySnapshot> getUserPosts(String email) {
    try {
      // Query to get posts based on the user's email
      return _firestore
          .collection('posts')
          .where('user.email', isEqualTo: email) // Filter posts by user's email
          .orderBy('createdAt', descending: true) // Order posts by creation date
          .snapshots();
    } catch (e) {
      print("Error getting user posts: $e");
      throw e;
    }
  }

  // Delete a post by its ID
  static Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
      print("Post deleted successfully");
    } catch (e) {
      print("Error deleting post: $e");
    }
  }

  // Update an existing post by its ID
  static Future<void> updatePost(String postId, String newTitle, String newContent) async {
    try {
      await _firestore.collection('posts').doc(postId).update({
        'title': newTitle,
        'content': newContent,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Post updated successfully");
    } catch (e) {
      print("Error updating post: $e");
    }
  }
}
