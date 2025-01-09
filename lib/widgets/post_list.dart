import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            var post = posts[index];
            return ListTile(
              title: Text(post['title']),
              subtitle: Text(post['content']),
            );
          },
        );
      },
    );
  }
}
