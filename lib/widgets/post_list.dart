import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uasapp/services/auth_service.dart';
import 'package:uasapp/services/post_service.dart';
import 'package:uasapp/pages/add_post_page.dart';

class PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        var posts = snapshot.data!.docs;
        var currentUserEmail = AuthService.getCurrentUserEmail(); // Dapatkan email pengguna saat ini
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            var post = posts[index];
            bool isPostOwner = post['email'] == currentUserEmail; // Periksa apakah pengguna yang login adalah pembuat post

            return Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListTile(
                title: Text(post['title']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('@${post['username']}'),
                    SizedBox(height: 8),
                    Text(post['content']),
                    SizedBox(height: 8),
                    if (isPostOwner) // Tampilkan tombol edit dan delete hanya jika pemilik post
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Navigasi ke halaman edit
                              _editPost(context, post.id, post['title'], post['content']);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              // Menghapus post
                              await PostService.deletePost(post.id);
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _editPost(BuildContext context, String postId, String title, String content) {
    // Navigasi ke halaman AddPostPage untuk edit
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddPostPage(
          postId: postId,
          initialTitle: title,
          initialContent: content,
        ),
      ),
    );
  }
}
